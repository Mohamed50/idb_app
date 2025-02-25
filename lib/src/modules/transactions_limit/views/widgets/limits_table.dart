import 'package:az_banking_app/src/modules/transactions_limit/data/models/transaction_limit_model.dart';
import 'package:flutter/material.dart';

class LimitsTable extends StatelessWidget {
  final List<LimitModel> limits;
  const LimitsTable({super.key, required this.limits});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 5, // Reduce spacing to fit
      border: TableBorder.all(color: Colors.black12),
      columns: [
        DataColumn(label: Text("Service", style: TextStyle(fontSize: 12))),
        DataColumn(label: Text("Per Tran", style: TextStyle(fontSize: 12))),
        DataColumn(label: Text("Per Day", style: TextStyle(fontSize: 12))),
        DataColumn(label: Text("No. of Trans", style: TextStyle(fontSize: 12))),
      ],
      rows: limits.map((limit) {
        return DataRow(cells: [
          DataCell(Text(limit.serviceName, style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)),
          DataCell(Text(limit.amountPerTran.toString(), style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)),
          DataCell(Text(limit.amountPerDay.toString(), style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)),
          DataCell(Text(limit.noOfTrans.toString(), style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)),
        ]);
      }).toList(),
    );
  }
}
