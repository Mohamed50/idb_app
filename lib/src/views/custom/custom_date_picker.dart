import 'package:az_banking_app/src/config/config.dart';
import 'package:flutter/material.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:get/get.dart';
import 'customs.dart';

class CustomDateField extends StatelessWidget {
  final String? label;
  final bool allowFutureDate;
  final bool allowPastDate;
  final bool enabled;
  final bool withYear;
  final DateTime? dateTime;
  final String dateFormat;
  final double fontSize;
  final ValueChanged<DateTime> onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller = TextEditingController();

  CustomDateField({
    super.key,
    this.label,
    this.enabled = true,
    this.withYear = true,
    required this.dateTime,
    required this.onChanged,
    this.dateFormat = 'dd MMMM yyyy',
    this.validator,
    this.allowFutureDate = false,
    this.allowPastDate = true,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    if(dateTime != null) {
      controller.text = Utils.formatDate(dateTime!, format: dateFormat);
    }
    return CustomFormField(
      label: label ?? TranslationsKeys.tkDateLabel,
      controller: controller,
      enabled: enabled,
      onTap: () => _showDatePicker(context),
      validator: validator,
      fontSize: fontSize,
      suffixIcon: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Icon(Icons.calendar_month),
      ),
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime today = DateTime.now();
    FocusScope.of(context).unfocus();
    DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: dateTime ?? today,
      firstDate: DateTime.now().copyWith(year: today.year - (allowPastDate ? 2 : 0)),
      lastDate: DateTime.now().copyWith(year: today.year + (allowFutureDate ? 1 : 0)),
      locale: const Locale('en', 'GB'),
      confirmText: TranslationsKeys.tkConfirmBtn.tr,
      cancelText: TranslationsKeys.tkCancelLabel.tr,
      helpText: TranslationsKeys.tkSelectDateLabel.tr,
    );
    if (pickedDateTime != null) {
      controller.text = Utils.formatDate(pickedDateTime);
      onChanged(pickedDateTime);
    }
  }
}

class CustomDateRangeField extends StatelessWidget {
  final bool enabled;
  final bool allowFutureDate;
  final bool withYear;
  final bool withDayName;
  final DateTimeRange? dateTimeRange;
  final String dateFormat;
  final ValueChanged<DateTimeRange> onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller = TextEditingController();

  CustomDateRangeField({
    super.key,
    this.enabled = true,
    required this.dateTimeRange,
    required this.onChanged,
    this.dateFormat = 'dd MMM yyyy',
    this.validator,
    this.allowFutureDate = false,
    this.withYear = true,
    this.withDayName = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText.subtitle(
            TranslationsKeys.tkDateLabel,
            fontSize: 10,
          ),
          const SizedBox(width: 4.0),
          Row(
            children: [
              const CustomText.subtitle(
                TranslationsKeys.tkFromLabel,
                color: ColorManager.titleColor,
              ),
              const SizedBox(width: 4.0),
              CustomDateText(
                dateTimeRange?.start,
                dateFormat: dateFormat,
                fontWeight: FontWeight.w900,
                color: ColorManager.titleColor,
                fontSize: 12.0,
                capsLock: false,
                withDayName: withDayName,
                withYear: withYear,
              ),
              const SizedBox(width: 2.0),
              const CustomText.subtitle(
                TranslationsKeys.tkToLabel,
                color: ColorManager.titleColor,
              ),
              const SizedBox(width: 4.0),
              CustomDateText(
                dateTimeRange?.end,
                dateFormat: dateFormat,
                fontWeight: FontWeight.w900,
                color: ColorManager.titleColor,
                fontSize: 12.0,
                capsLock: false,
                withDayName: withDayName,
                withYear: withYear,
              ),
            ],
          ),
        ],
      );
    }
    if(dateTimeRange != null) {
      controller.text = Utils.formatDateRange(dateTimeRange!.start, dateTimeRange!.end, format: dateFormat);
    }
    return CustomFormField(
      label: TranslationsKeys.tkDateLabel,
      controller: controller,
      enabled: enabled,
      textColor: ColorManager.titleColor,
      onTap: () => _showDatePicker(context),
      validator: validator,
      backgroundColor: ColorManager.darkBackgroundColor,
      suffixIcon: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Icon(Icons.calendar_month, color: ColorManager.primaryColor,),
      ),
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime today = DateTime.now();
    FocusScope.of(context).unfocus();
    DateTimeRange? pickedDateTimeRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateTimeRange,
      firstDate: DateTime.now().copyWith(year: today.year - 2),
      lastDate: DateTime.now().copyWith(year: today.year + (allowFutureDate ? 1 : 0)),
      locale: const Locale('en', 'GB'),
      confirmText: TranslationsKeys.tkConfirmBtn.tr,
      cancelText: TranslationsKeys.tkCancelLabel.tr,
      helpText: TranslationsKeys.tkSelectDateLabel.tr,
      saveText: TranslationsKeys.tkConfirmBtn.tr,
      fieldStartLabelText: TranslationsKeys.tkFromLabel.tr,
      fieldStartHintText: TranslationsKeys.tkFromLabel.tr,
      fieldEndLabelText: TranslationsKeys.tkToLabel.tr,
      fieldEndHintText: TranslationsKeys.tkToLabel.tr,
      builder: (context, child) => child!,
    );
    if (pickedDateTimeRange != null) {
      controller.text = Utils.formatDateRange(pickedDateTimeRange.start, pickedDateTimeRange.end, format: dateFormat);
      onChanged(pickedDateTimeRange);
    }
  }
}
