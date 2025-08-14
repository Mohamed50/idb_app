import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';

class AmountInputField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const AmountInputField({
    super.key,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      label: TranslationsKeys.tkAmountLabel,
      onSaved: onSaved,
      validator: InputsValidator.generalValidator,
      keyboardType: TextInputType.number,
      inputFormatters: [AmountFormatter()],
    );
  }
}
