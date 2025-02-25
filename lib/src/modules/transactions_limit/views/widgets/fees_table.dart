import 'package:az_banking_app/src/modules/transactions_limit/data/models/transaction_limit_model.dart';
import 'package:flutter/material.dart';

class FeesTable extends StatelessWidget {
  final List<FeeModel> fees;
  const FeesTable({super.key, required this.fees});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 5, // Reduce spacing to fit
      border: TableBorder.all(color: Colors.black12),
      columns: [
        DataColumn(label: Text("Service", style: TextStyle(fontSize: 12))),
        DataColumn(label: Text("Min", style: TextStyle(fontSize: 12))),
        DataColumn(label: Text("Max", style: TextStyle(fontSize: 12))),
        DataColumn(label: Text("Fees", style: TextStyle(fontSize: 12))),
      ],
      rows: fees.map((limit) {
        return DataRow(cells: [
          DataCell(Text(limit.serviceName, style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)),
          DataCell(Text(limit.minTranAmount.toString(), style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)),
          DataCell(Text(limit.maxTranAmount.toString(), style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)),
          DataCell(Text(limit.fees.toString(), style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)),
        ]);
      }).toList(),
    );
  }
}
