import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/screen_utils.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class CustomFormField extends StatelessWidget {
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final String? label;
  final Widget? icon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final int? maxLines;
  final int? maxLength;
  final InputDecoration? decoration;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final List<TextInputFormatter> inputFormatters;

  const CustomFormField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.validator,
    this.onSaved,
    this.icon,
    this.suffixIcon,
    this.border,
    this.maxLines,
    this.maxLength,
    this.decoration,
    this.onChanged,
    this.initialValue,
    this.backgroundColor = ColorManager.darkBackgroundColor,
    this.textColor = ColorManager.titleColor,
    this.fontSize = 14,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.enabled = true,
    this.onTap,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = TextStyle(
        color: ColorManager.bodyColor, fontWeight: FontWeight.w400, fontSize: ScreenUtils.getFontSize(context, fontSize));
    TextStyle textStyle =
        TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: ScreenUtils.getFontSize(context, fontSize));
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: backgroundColor),
    );
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      onSaved: (v) => onSaved != null? onSaved!(v?.replaceAll(',', '')) : (){},
      onChanged: (v) => onChanged != null? onChanged!(v.replaceAll(',', '')) : (){},
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
      style: textStyle,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      decoration: decoration ??
          InputDecoration(
            filled: true,
            fillColor: backgroundColor,
            contentPadding: const EdgeInsets.all(12.0),
            hintText: hint?.tr,
            labelText: label?.tr,
            prefixIcon: icon,
            suffixIcon: suffixIcon,
            border: border ?? inputBorder,
            enabledBorder: border ?? inputBorder,
            labelStyle: textStyle,
            hintStyle: hintStyle,
          ),
    );
  }
}

class PasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final String? label;
  final Widget? icon;
  final InputBorder? border;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final int? maxLines;
  final InputDecoration? decoration;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final List<TextInputFormatter> inputFormatters;

  const PasswordFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.hint,
    this.label,
    this.icon,
    this.border,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.maxLines = 1,
    this.decoration,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.fontSize = 14,
    this.backgroundColor = ColorManager.darkBackgroundColor,
    this.textColor = ColorManager.titleColor,
    this.inputFormatters = const [],
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = TextStyle(
        color: widget.textColor, fontWeight: FontWeight.w400, fontSize: ScreenUtils.getFontSize(context, widget.fontSize));
    TextStyle textStyle = TextStyle(
        color: widget.textColor, fontWeight: FontWeight.w700, fontSize: ScreenUtils.getFontSize(context, widget.fontSize));
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: widget.backgroundColor),
    );

    Widget eyeIcon = InkWell(
      onTap: () {
        setState(() {
          secure = !secure;
        });
      },
      child: Icon(
        secure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
      ),
    );
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: widget.validator,
      maxLines: widget.maxLines,
      style: textStyle,
      obscureText: secure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      decoration: widget.decoration ??
          InputDecoration(
            filled: true,
            fillColor: widget.backgroundColor,
            hintText: widget.hint?.tr,
            labelText: widget.label?.tr,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            icon: widget.icon,
            suffixIcon: eyeIcon,
            border: widget.border ?? inputBorder,
            enabledBorder: widget.border ?? inputBorder,
            labelStyle: textStyle,
            hintStyle: hintStyle,
            errorMaxLines: 2,
          ),
    );
  }
}


/// **AmountFormatter (9 integers + 2 decimals)**
///
/// - Locale-aware grouping for the integer part
/// - Uses '.' as the decimal separator (commas are treated as grouping only)
/// - Max integer digits: 9
/// - Max decimal digits: 2 (configurable)
/// - Preserves caret; rejects edits that exceed limits
class AmountFormatter extends TextInputFormatter {
  final int maxDecimals;
  final int maxIntegers;
  final NumberFormat _intFormatter;

  AmountFormatter({
    this.maxDecimals = 2,
    this.maxIntegers = 9,
    String locale = 'en_US',
  }) : _intFormatter = NumberFormat.decimalPattern(locale);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final rawText = newValue.text;
    if (rawText.isEmpty) {
      return const TextEditingValue(text: '');
    }

    // 1) Remove grouping commas/spaces and any non-digit/non-dot chars
    //    (Only '.' is considered a decimal point)
    final sanitized = rawText
        .replaceAll(',', '')                // strip thousands separators
        .replaceAll(RegExp(r'[^0-9\.]'), ''); // keep only digits and '.'

    // 2) Collapse multiple '.' to a single decimal point
    String unified = sanitized;
    final firstDot = unified.indexOf('.');
    if (firstDot != -1) {
      final before = unified.substring(0, firstDot + 1);
      final after = unified.substring(firstDot + 1).replaceAll('.', '');
      unified = before + after;
    }

    // 3) Split into integer and fraction
    var parts = unified.split('.');
    var intPart = parts[0];
    var fracPart = parts.length > 1 ? parts[1] : '';

    // Normalize leading zeros in integer part (keep one zero)
    intPart = intPart.replaceAll(RegExp(r'^0+(?=\d)'), '');
    if (intPart.isEmpty) intPart = '0';

    // 4) Enforce limits
    // Integer digits (without signs/anything else)
    final intDigits = intPart.replaceAll(RegExp(r'\D'), '');
    if (intDigits.length > maxIntegers) {
      return oldValue; // reject edit
    }

    // Decimal digits
    if (maxDecimals >= 0 && fracPart.length > maxDecimals) {
      return oldValue; // reject edit beyond allowed decimals
    }

    // 5) Format integer part with grouping
    final formattedInt = _intFormatter.format(int.parse(intPart));

    // Preserve trailing '.' while typing decimals
    final hasTrailingDot = unified.endsWith('.') && maxDecimals != 0;

    // 6) Rebuild formatted text
    final formatted = (fracPart.isEmpty && !hasTrailingDot)
        ? formattedInt
        : '$formattedInt.$fracPart';

    // 7) Caret preservation
    int clamp(int v, int min, int max) => v < min ? min : (v > max ? max : v);
    final leftRaw = newValue.text.substring(
      0,
      clamp(newValue.selection.baseOffset, 0, newValue.text.length),
    );

    // Recompute "logical" chars (digits + '.') to the left, ignoring grouping commas
    final leftSanitized = leftRaw
        .replaceAll(',', '')
        .replaceAll(RegExp(r'[^0-9\.]'), '');

    String collapseFirstDot(String s) {
      final i = s.indexOf('.');
      if (i == -1) return s.replaceAll('.', '');
      return s.substring(0, i + 1) + s.substring(i + 1).replaceAll('.', '');
    }

    final leftUnified = collapseFirstDot(leftSanitized);
    final logicalLeftCount = RegExp(r'[0-9.]').allMatches(leftUnified).length;

    int seen = 0;
    int newOffset = 0;
    for (int i = 0; i < formatted.length; i++) {
      final ch = formatted[i];
      if (RegExp(r'[0-9.]').hasMatch(ch)) {
        seen++;
      }
      if (seen >= logicalLeftCount) {
        newOffset = i + 1;
        break;
      }
      if (i == formatted.length - 1) {
        newOffset = formatted.length;
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}



