import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/statements/data/models/history_model.dart';
import 'package:az_banking_app/src/modules/statements/data/models/statement_model.dart';
import 'package:az_banking_app/src/modules/statements/views/widgets/history_item_tile.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'statement_item_tile.dart';

class HistoryListView extends StatelessWidget {
  final List<HistoryModel> items;
  final EdgeInsets? padding;
  final Color? cardColor;

  const HistoryListView({super.key, required this.items, this.padding, this.cardColor});

  @override
  Widget build(BuildContext context) {
    if(items.isNotEmpty){
      return ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        padding: padding ?? EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => HistoryItemTile(
          item: items[index],
          backgroundColor: cardColor,
        ),
        separatorBuilder: (context, index) => SizedBox(height: 12.0),
      );
    }
    return Center(child: CustomText(TranslationsKeys.tkNoDataLabel));
  }
}
