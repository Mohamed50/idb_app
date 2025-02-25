import 'package:az_banking_app/src/modules/statements/data/models/statement_model.dart';
import 'package:flutter/material.dart';
import 'statement_item_tile.dart';

class StatementsListView extends StatelessWidget {
  final List<StatementModel> statements;
  final EdgeInsets? padding;
  final Color? cardColor;

  const StatementsListView({super.key, required this.statements, this.padding, this.cardColor});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: statements.length,
      padding: padding ?? EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => StatementItemTile(
        statementModel: statements[index],
        backgroundColor: cardColor,
      ),
      separatorBuilder: (context, index) => SizedBox(height: 12.0),
    );
  }
}
