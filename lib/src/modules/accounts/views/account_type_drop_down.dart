import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_type_model.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountTypeDropDown extends StatelessWidget {
  final ValueChanged<AccountType?>? onSaved;
  final FormFieldValidator<AccountType>? validator;
  final String label;

  const AccountTypeDropDown({super.key, this.onSaved, this.label = TranslationsKeys.tkFromAccountLabel, this.validator});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: ColorManager.bodyColor, fontWeight: FontWeight.w700, fontSize: 14.0);
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: ColorManager.lightBackgroundColor),
    );

    InputDecoration decoration = InputDecoration(
      filled: true,
      fillColor: ColorManager.lightBackgroundColor,
      contentPadding: const EdgeInsets.all(12.0),
      labelText: label.tr,
      border: inputBorder,
      enabledBorder: inputBorder,
      labelStyle: textStyle,
    );
    List<AccountType> types = [AccountType.current, AccountType.saving, AccountType.ntd];
    return DropdownButtonFormField<AccountType>(
      decoration: decoration,
      validator: validator,
      items: types
          .map((e) => DropdownMenuItem<AccountType>(
                value: e,
                child: CustomText.title(e.toLabel(), fontSize: 14.0,),
              ))
          .toList(),
      onChanged: (v) {},
      onSaved: (v) {
        if (onSaved != null) {
          onSaved!(v);
        }
      },
    );
  }
}
