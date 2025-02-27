import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsDropDown extends StatelessWidget {
  final ValueChanged<AccountModel?>? onSaved;
  final ValueChanged<AccountModel>? onChanged;
  final String label;
  final FormFieldValidator<AccountModel>? validator;
  final bool changePrimaryOnChange;
  final bool withOneAccountError;
  final Color fillColor;

  const AccountsDropDown({
    super.key,
    this.onSaved,
    this.onChanged,
    this.label = TranslationsKeys.tkFromAccountLabel,
    this.validator,
    this.changePrimaryOnChange = false,
    this.withOneAccountError = false,
    this.fillColor = ColorManager.darkBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: ColorManager.titleColor, fontWeight: FontWeight.w700, fontSize: 14.0);
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: fillColor),
    );

    InputDecoration decoration = InputDecoration(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.all(12.0),
      labelText: label.tr,
      border: inputBorder,
      enabledBorder: inputBorder,
      labelStyle: textStyle,
    );
    return GetX<AccountViewModel>(builder: (controller) {
      List<AccountModel> accounts = controller.accounts.data ?? <AccountModel>[];
      return DropdownButtonFormField<AccountModel>(
        value: controller.primaryAccount,
        decoration: decoration,
        validator: validator,
        items: accounts
            .map((e) => DropdownMenuItem<AccountModel>(
                  value: e,
                  child: CustomText.title(e.accountNo, fontSize: 14.0),
                ))
            .toList(),
        onChanged: (value) {
          if (changePrimaryOnChange) {
            controller.onSelectedAccountChange(value);
          }
          if (onChanged != null && value != null) {
            onChanged!(value);
          }
        },
        onSaved: (v) {
          if (onSaved != null) {
            onSaved!(v);
          }
        },
      );
    });
  }
}
