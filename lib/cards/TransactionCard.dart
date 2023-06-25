import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String category;
  final num amount;
  final DateTime date;
  final String type;

  const TransactionCard({
    Key? key,
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Color.fromARGB(255, 37, 68, 121),
        textColor: Colors.white,
        leading: Icon(
          type == 'expense' ? Icons.arrow_downward : Icons.arrow_upward,
          color: type == 'expense' ? Colors.red : Colors.green,
        ),
        title: Text(category),
        subtitle: Text(date.toString()),
        trailing: Text('\$${amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
