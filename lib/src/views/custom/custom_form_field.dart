import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/screen_utils.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class CustomFormField extends StatelessWidget {
  final VoidCallback? onTap;
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
    this.decoration,
    this.onChanged,
    this.initialValue,
    this.backgroundColor = ColorManager.darkBackgroundColor,
    this.textColor = ColorManager.titleColor,
    this.fontSize = 14,
    this.keyboardType,
    this.textInputAction,
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
      enabled: enabled,
      onSaved: (v) => onSaved != null? onSaved!(v?.replaceAll(',', '')) : (){},
      onChanged: (v) => onChanged != null? onChanged!(v.replaceAll(',', '')) : (){},
      validator: validator,
      maxLines: maxLines,
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

/// **AmountFormatter (with decimals)**
///
/// - Groups the integer part with commas
/// - Allows a single decimal point
/// - Limits fractional digits (default: 2)
/// - Preserves caret while typing
///
// ────────────────────────────────────────────────
class AmountFormatter extends TextInputFormatter {
  final int maxDecimals;
  final NumberFormat _intFormatter;

  AmountFormatter({
    this.maxDecimals = 2,
    String locale = 'en_US',
  }) : _intFormatter = NumberFormat.decimalPattern(locale);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final rawText = newValue.text;

    // Quick exit
    if (rawText.isEmpty) {
      return const TextEditingValue(text: '');
    }

    // Keep only digits and decimal separators; accept both '.' and ','
    final sanitized = rawText.replaceAll(RegExp(r'[^0-9\.,]'), '');

    // Unify decimal to '.' (we'll always output '.')
    var unified = sanitized.replaceAll(',', '.');

    // Keep only the first '.' as decimal separator
    final firstDot = unified.indexOf('.');
    if (firstDot != -1) {
      final before = unified.substring(0, firstDot + 1);
      final after = unified.substring(firstDot + 1).replaceAll('.', '');
      unified = before + after;
    }

    // Split into integer and fraction
    var parts = unified.split('.');
    var intPart = parts[0];
    var fracPart = parts.length > 1 ? parts[1] : '';

    // Trim fraction to maxDecimals (if provided)
    if (maxDecimals >= 0 && fracPart.length > maxDecimals) {
      fracPart = fracPart.substring(0, maxDecimals);
    }

    // Remove leading zeros (but leave one zero if empty)
    intPart = intPart.replaceAll(RegExp(r'^0+(?=\d)'), '');
    if (intPart.isEmpty) intPart = '0';

    // Format integer part with grouping
    final formattedInt = _intFormatter.format(int.parse(intPart));

    // Rebuild final formatted text
    final hasTrailingDot = unified.endsWith('.') && maxDecimals != 0;
    final formatted = (fracPart.isEmpty && !hasTrailingDot)
        ? formattedInt
        : '$formattedInt.$fracPart';

    // --- Caret preservation ---
    // Count how many "meaningful" chars (digits + '.') were to the left
    final leftRaw = newValue.text
        .substring(0, newValue.selection.baseOffset.clamp(0, newValue.text.length))
        .replaceAll(RegExp(r'[^0-9\.,]'), '')
        .replaceAll(',', '.');

    // Collapse to a single dot in the left side as well
    String collapseFirstDot(String s) {
      final i = s.indexOf('.');
      if (i == -1) return s.replaceAll('.', '');
      return s.substring(0, i + 1) + s.substring(i + 1).replaceAll('.', '');
    }

    final leftUnified = collapseFirstDot(leftRaw);
    final logicalLeftCount = RegExp(r'[0-9.]').allMatches(leftUnified).length;

    // Find the corresponding position in the formatted text
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
      // If we never reach logicalLeftCount (e.g., backspacing), keep advancing
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

