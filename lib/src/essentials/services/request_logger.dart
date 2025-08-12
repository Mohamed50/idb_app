import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// **POSIX-safe single-quote escape**
String _shEscape(String s) => s.replaceAll("'", r"'\''");

/// **Header Title-Case** (e.g., content-type -> Content-Type)
String _titleCaseHeader(String name) =>
    name.split('-').map((p) => p.isEmpty ? p : p[0].toUpperCase() + p.substring(1)).join('-');

String _maybeRedact(String key, String value, bool redact) {
  if (!redact) return value;
  final k = key.toLowerCase();
  const sensitive = {
    'authorization',
    'proxy-authorization',
    'cookie',
    'set-cookie',
    'x-api-key',
    'x-auth-token',
    'api-key',
    'access-token',
    'x-access-token',
    'x-secret-key',
  };
  return sensitive.contains(k) ? '***REDACTED***' : value;
}

/// **Builds a clean one-liner `curl` from a GetX [Response]**
///
/// - Dedupes headers (case-insensitive)
/// - Skips hop/end-to-end headers that curl should set itself
/// - Adds `Content-Type: application/json; charset=utf-8` iff body is Map/List and missing
/// - Redacts sensitive headers by default
/// ────────────────────────────────────────────────
String buildCurlFromResponse(
    Response response, {
      dynamic body, // pass the body you sent, if you have it
      bool redactSensitive = true,
    }) {
  final req = response.request;
  final method = (req?.method ?? 'GET').toUpperCase();
  final url = req?.url.toString() ?? '';

  // 1) Normalize & filter headers
  final skip = <String>{
    'content-length',
    'host',
    'connection',
    'accept-encoding',
    'user-agent',
    'content-encoding',
    'transfer-encoding',
    // HTTP/2 psuedo-headers, just in case:
    ':method',
    ':path',
    ':authority',
    ':scheme',
  };

  final normalized = <String, String>{};
  (req?.headers ?? {}).forEach((k, v) {
    final lk = k.toLowerCase().trim();
    if (!skip.contains(lk)) {
      normalized[lk] = v.toString().trim(); // last wins
    }
  });

  // 2) Determine body
  final rawBody = body;
  String? bodyString;
  bool isJsonBody = false;

  if (rawBody != null && method != 'GET' && method != 'HEAD') {
    if (rawBody is String) {
      bodyString = rawBody;
      // Don't guess content-type for arbitrary strings
    } else if (rawBody is List<int>) {
      bodyString = base64.encode(rawBody);
      normalized.putIfAbsent('content-transfer-encoding', () => 'base64');
    } else if (rawBody is Map || rawBody is List) {
      bodyString = json.encode(rawBody);
      isJsonBody = true;
    } else {
      bodyString = '[Body omitted: unsupported type ${rawBody.runtimeType}]';
    }
  }

  // 3) Add JSON content-type if needed (avoid duplicates regardless of case)
  if (isJsonBody && !normalized.containsKey('content-type')) {
    normalized['content-type'] = 'application/json; charset=utf-8';
  }

  // 4) Compose curl
  final parts = <String>['curl', '-X $method'];

  // Sort headers for stable output
  final headerKeys = normalized.keys.toList()..sort();
  for (final lk in headerKeys) {
    final name = _titleCaseHeader(lk);
    final value = _maybeRedact(lk, normalized[lk]!, redactSensitive);
    parts.add("-H '${_shEscape('$name: $value')}'");
  }

  if (bodyString != null && bodyString.isNotEmpty) {
    parts.add("--data-raw '${_shEscape(bodyString)}'");
  }

  parts.add("'${_shEscape(url)}'");
  return parts.join(' ');
}

/// **Convenience logger**
/// ────────────────────────────────────────────────
void logRequestAsCurl(Response response, {dynamic body, bool redactSensitive = !kDebugMode}) {
  final curl = buildCurlFromResponse(response, body: body, redactSensitive: redactSensitive);
  log('===============================================================');
  log('CURL: $curl');
  log('RESPONSE: ${response.bodyString}');
  log('===============================================================');
}
