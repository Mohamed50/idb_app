import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/statements/data/models/statement_model.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatementItemTile extends StatelessWidget {
  final StatementModel statementModel;
  final Color? backgroundColor;

  const StatementItemTile({super.key, required this.statementModel, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final color =
        statementModel.tranDirection == TransactionDirection.tranIn ? ColorManager.positiveColor : ColorManager.negativeColor;
    final icon = statementModel.tranDirection == TransactionDirection.tranIn
        ? FontAwesomeIcons.arrowTrendUp
        : FontAwesomeIcons.arrowTrendDown;
    return CustomCard(
      padding: EdgeInsets.all(12.0),
      color: backgroundColor ?? ColorManager.darkBackgroundColor,
      child: Row(
        children: [
          CustomCard(
              color: color.withValues(alpha: 0.08),
              child: FaIcon(icon, color: color, size: 24.0)),
          SizedBox(width: 8.0),
          Expanded(child: CustomText.subtitle(statementModel.naration,
              color: ColorManager.titleColor)),
          CustomText.title(statementModel.amount, color: color),
        ],
      ),
    );
  }
}
