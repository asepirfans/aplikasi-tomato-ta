import 'package:flutter/material.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataTable(
        columns: [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Nama')),
          DataColumn(label: Text('Usia')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('John')),
            DataCell(Text('25')),
          ]),
          DataRow(cells: [
            DataCell(Text('2')),
            DataCell(Text('Jane')),
            DataCell(Text('30')),
          ]),
          // Add more rows as needed
        ],
      ),
    );
  }
}
