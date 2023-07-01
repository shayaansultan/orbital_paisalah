import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Icon(
            type == 'expense' ? Icons.arrow_downward : Icons.arrow_upward,
            color: type == 'expense' ? Colors.red : Colors.green,
          ),
        ),

        // leading: Text(
        //   '\$${amount.toStringAsFixed(2)}',
        //   style: TextStyle(
        //     color: type == 'expense' ? Colors.red : Colors.green,
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   //align text in center vertically
        //   textAlign: TextAlign.center,
        // ),
        title: Text(category),
        subtitle: Text(DateFormat.yMMMd().format(date) +
            ' ' +
            DateFormat.jm().format(date)),
        trailing: Text('\$${amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
