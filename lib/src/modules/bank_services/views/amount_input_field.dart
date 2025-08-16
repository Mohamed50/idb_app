import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';

class AmountInputField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final int maxDecimals;
  final int maxIntegers;
  final int minValue;

  const AmountInputField({
    super.key,
    required this.onSaved,
    this.maxDecimals = 2,
    this.maxIntegers = 7,
    this.minValue = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      label: TranslationsKeys.tkAmountLabel,
      onSaved: onSaved,
      validator: (value) => InputsValidator.validateAmount(value, minValue),
      keyboardType: TextInputType.number,
      inputFormatters: [
        AmountFormatter(
          maxIntegers: maxIntegers,
          maxDecimals: maxDecimals,
        )
      ],
    );
  }
}
