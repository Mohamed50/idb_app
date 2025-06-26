import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/widgets/confirmation_dialog.dart';
import 'package:az_banking_app/src/modules/auth/data/models/user.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/actions/bill_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/src/utils/route_manager.dart';
import '/src/essentials/config/api_config.dart';
import '/src/utils/utils.dart';
import 'memory_service.dart';

/// Service class responsible for handling API calls and managing HTTP requests.
class ApiService extends GetConnect {
  /// Retrieves the access token from memory.
  String? get accessToken => MemoryService.instance.accessToken;

  /// Retrieves the refresh token from memory.
  String? get refreshToken => MemoryService.instance.refreshToken;

  /// Retrieves the userId from memory.
  String? get userId => MemoryService.instance.userId;

  /// Retrieves the user from memory.
  UserModel? get user =>
      MemoryService.instance.user == null ? null : UserModel.fromJson(json.decode(MemoryService.instance.user!));

  /// Initializes the API service with a timeout setting for HTTP requests.
  @override
  void onInit() {
    httpClient.timeout = const Duration(seconds: 120);
    super.onInit();
  }

  /// Performs an HTTP POST request.
  ///
  /// `url`: The endpoint URL.
  /// `body`: The request payload.
  /// `contentType`: Optional content type header.
  /// `headers`: Optional headers for the request.
  /// `query`: Optional query parameters.
  /// `decoder`: Optional decoder for the response.
  /// `uploadProgress`: Optional callback for tracking upload progress.
  @override
  Future<Response<T>> post<T>(
    String? url,
    body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    body['Lang'] = Get.locale!.languageCode == 'en' ? 0 : 1;
    body['Tran_DateTime'] = tranDateTime;
    Response<T> response = await super.post(
      url,
      body,
      contentType: contentType,
      headers: headers ?? getDefaultHeader(),
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    logRequestData(response, body);
    handleError(response);
    return response;
  }

  Future<Response<T>> transaction<T>(
    String url,
    body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
    required Future<bool> Function() onDuplicated,
  }) async {
    if (isDuplicateTransaction(url, body)) {
      bool status = await onDuplicated();
      if (!status) throw AppException(TranslationsKeys.tkTransactionCanceledMsg);
    }
    final response = await post<T>(
      url,
      body,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    saveTransaction(url, body);
    return response;
  }

  /// Performs an HTTP DELETE request.
  ///
  /// `url`: The endpoint URL.
  /// `contentType`: Optional content type header.
  /// `headers`: Optional headers for the request.
  /// `query`: Optional query parameters.
  /// `decoder`: Optional decoder for the response.
  @override
  Future<Response<T>> delete<T>(
    String url, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    Response<T> response =
        await super.delete(url, contentType: contentType, headers: headers ?? getDefaultHeader(), query: query, decoder: decoder);
    logRequestData(response);
    handleError(response);
    return response;
  }

  /// Performs an HTTP PUT request.
  ///
  /// `url`: The endpoint URL.
  /// `body`: The request payload.
  /// `contentType`: Optional content type header.
  /// `headers`: Optional headers for the request.
  /// `query`: Optional query parameters.
  /// `decoder`: Optional decoder for the response.
  @override
  Future<Response<T>> put<T>(
    String url,
    body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    Response<T> response = await super.put(url, body,
        contentType: contentType,
        headers: headers ?? getDefaultHeader(),
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
    logRequestData(response);
    handleError(response);
    return response;
  }

  /// Performs an HTTP GET request.
  ///
  /// `url`: The endpoint URL.
  /// `contentType`: Optional content type header.
  /// `headers`: Optional headers for the request.
  /// `query`: Optional query parameters.
  /// `decoder`: Optional decoder for the response.
  @override
  Future<Response<T>> get<T>(
    String url, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    Response<T> response =
        await super.get(url, contentType: contentType, headers: headers ?? getDefaultHeader(), query: query, decoder: decoder);
    logRequestData(response);
    handleError(response);
    return response;
  }

  /// Logs request and response data for debugging purposes.
  ///
  /// `response`: The HTTP response object.
  /// `body`: Optional request body.
  void logRequestData(Response response, [dynamic body]) {
    log('Calling API: ${response.request!.url.toString()}');
    log('Headers: ${response.request!.headers}');
    log('Status Code: ${response.statusCode}');
    log('body: $body');
    log('Response headers: ${response.headers}');
    log('Response: ${response.bodyString}');
  }

  /// Handles errors in API responses.
  ///
  /// If the response indicates an error, it throws the appropriate exception or refreshes the session if necessary.
  ///
  /// `response`: The HTTP response object.
  void handleError(Response response) {
    if (response.hasError) {
      if (response.statusCode == 401) {
        refreshSession();
      }
      if (response.status.isNotFound) {
        throw Exception(response.statusText);
      } else {
        if (response.body != null) {
          if (response.body['message'] == 'Validation error') {
            throw AuthException('Wrong Credentials');
          }
          throw APIException(response.body['detail']);
        } else {
          throw APIException('Timeout');
        }
      }
    } else if (response.body['Response_Code'] != null &&
        response.body['Response_Code'] != 200 &&
        response.body['Response_Code'] != 0) {
      if (response.body['Response_Code'] != 2 && response.body['Response_Message'] != 'Reset Device?') {
        throw APIException(response.body['Response_Message']);
      }
    }
  }

  /// Generates the default headers for API requests.
  ///
  /// `token`: Optional access token to override the stored token.
  Map<String, String> getDefaultHeader([String? token]) {
    return {
      'Authorization': ' Bearer ${token ?? MemoryService.instance.accessToken ?? ' '}',
      'content-type': 'application/json',
    };
  }

  /// Generates the headers for unauthorized requests.
  Map<String, String> getUnauthorizedHeader() {
    return {
      'content-type': 'application/json',
    };
  }

  /// Refreshes the session by renewing the access token using the refresh token.
  ///
  /// If the refresh fails, it clears the tokens and redirects to the initial route.
  Future<bool> refreshSession() async {
    try {
      String refreshToken = MemoryService.instance.refreshToken!;
      final body = {'refresh': refreshToken};
      Response response = await post(
        APIConfiguration.refreshSessionUrl,
        body,
      );
      MemoryService.instance.accessToken = response.body['access'];
      return true;
    } catch (e) {
      MemoryService.instance.accessToken = null;
      MemoryService.instance.refreshToken = null;
      Get.offAllNamed(RouteManager.initialRoute);
      rethrow;
    }
  }

  /// Generates an MD5 hash for a given input string.
  ///
  /// **Parameters:**
  /// - `input`: The string to be hashed.
  ///
  /// **Returns:**
  /// - A hexadecimal string representing the MD5 hash.
  String generateMd5(String input) {
    final List<int> bytes = utf8.encode(input); // Convert input to UTF-8 bytes
    final Digest hash = md5.convert(bytes); // Compute MD5 hash
    return hash.toString(); // Convert to hexadecimal string
  }

  String get tranDateTime {
    return DateFormat('dd-MM-yy-hh-mm-ss', 'en').format(DateTime.now()).replaceAll('-', '');
  }

  void saveTransaction(String url, Map<String, dynamic> body) {
    body.remove('Lang');
    body.remove('Tran_DateTime');
    final hash = TransactionSignature.from(url, body).toHash();
    final timestamp = DateTime.now();
    MemoryService.instance.lastTransactionCache = TransactionCacheModel(hash: hash, timestamp: timestamp);
  }

  bool isDuplicateTransaction(String url, Map<String, dynamic> body) {
    final currentHash = TransactionSignature.from(url, body).toHash();
    final cache = MemoryService.instance.lastTransactionCache;

    if (cache == null) return false;

    final isExpired = DateTime.now().difference(cache.timestamp).inMinutes > 10;
   return !isExpired && cache.hash == currentHash;
  }

  Future<bool> onDuplicated([String? type]) async {
    if(type == 'transfer'){
      TransferActions.instance.hideLoader();
    }
    else{
      BillsActions.instance.hideLoader();
    }
    final result = await Get.dialog<bool>(ConfirmationDialog(message: TranslationsKeys.tkDuplicatedTransactionMsg));
    if(type == 'transfer'){
      TransferActions.instance.showLoader();
    }
    else{
      BillsActions.instance.showLoader();
    }
    return result ?? false;
  }
}

class TransactionSignature {
  final String url;
  final Map<String, dynamic> body;

  TransactionSignature({required this.url, required this.body});

  String toHash() {
    final sortedBody = Map.fromEntries(
      body.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    return '$url|${sortedBody.toString()}'; // or use json.encode
  }

  static TransactionSignature from(String url, Map<String, dynamic> body) {
    return TransactionSignature(url: url, body: body);
  }
}

class TransactionCacheModel {
  final String hash;
  final DateTime timestamp;

  TransactionCacheModel({required this.hash, required this.timestamp});

  Map<String, dynamic> toJson() => {
        'hash': hash,
        'timestamp': timestamp.toIso8601String(),
      };

  factory TransactionCacheModel.fromJson(Map<String, dynamic> json) {
    return TransactionCacheModel(
      hash: json['hash'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
