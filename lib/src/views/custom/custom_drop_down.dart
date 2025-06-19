import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDown<T> extends StatelessWidget {
  final ValueChanged<T?>? onSaved;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final List<T> options;
  final String label;
  final T? value;

  const CustomDropDown({super.key, this.onSaved, this.label = TranslationsKeys.tkFromAccountLabel, this.validator, required this.options, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: ColorManager.titleColor, fontWeight: FontWeight.w700, fontSize: 14.0);
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: ColorManager.darkBackgroundColor),
    );

    InputDecoration decoration = InputDecoration(
      filled: true,
      fillColor: ColorManager.darkBackgroundColor,
      contentPadding: const EdgeInsets.all(12.0),
      labelText: label.tr,
      border: inputBorder,
      enabledBorder: inputBorder,
      labelStyle: textStyle,
    );
    return DropdownButtonFormField<T>(
      value: value,
      decoration: decoration,
      validator: validator,
      items: options
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: CustomText.title(
                  e.toString(),
                  fontSize: 14.0,
                ),
              ))
          .toList(),
      onChanged: (v) {
        if(onChanged != null) {
          onChanged!(v);
        }
      },
      onSaved: (v) {
        if (onSaved != null) {
          onSaved!(v);
        }
      },
    );
  }
}
