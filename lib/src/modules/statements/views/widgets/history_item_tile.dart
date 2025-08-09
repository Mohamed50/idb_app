import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/statements/data/models/history_model.dart';
import 'package:az_banking_app/src/modules/statements/data/models/statement_model.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryItemTile extends StatelessWidget {
  final HistoryModel item;
  final Color? backgroundColor;

  const HistoryItemTile({super.key, required this.item, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    print(item.toJson());
    return CustomCard(
      padding: EdgeInsets.all(12.0),
      color: backgroundColor ?? ColorManager.darkBackgroundColor,
      child: Row(
        children: [
          // CustomCard(color: color.withValues(alpha: 0.08), child: FaIcon(icon, color: color, size: 24.0)),
          SizedBox(width: 8.0),
          Expanded(
            child: CustomText.subtitle(
              item.billInfo,
              color: ColorManager.titleColor,
              fontSize: 12.0,
            ),
          ),
          SizedBox(width: 4.0),
          CustomText.title(
            item.amount,
            color: ColorManager.primaryColor,
          ),
          SizedBox(width: 4.0),
          CustomText.title(
            TranslationsKeys.tkSDGLabel,
            color: ColorManager.primaryColor,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
