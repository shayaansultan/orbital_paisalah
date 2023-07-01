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
        dense: false,
        tileColor: Color.fromARGB(255, 37, 68, 121),
        textColor: Colors.white,
        // leading: Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
        //   child: Icon(
        //     type == 'expense' ? Icons.arrow_downward : Icons.arrow_upward,
        //     color: type == 'expense' ? Colors.red : Colors.green,
        //   ),
        // ),

        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Text('\$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: type == 'expense' ? Colors.redAccent : Colors.green,
              )),
        ),
        title: Text(
          category,
          // style: const TextStyle(
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        subtitle: Text(
            '${DateFormat.yMMMd().format(date)} ${DateFormat.jm().format(date)}'),
        // trailing: Text('\$${amount.toStringAsFixed(2)}',
        //     style: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //       color: type == 'expense' ? Colors.redAccent : Colors.green,
        //     )),

        trailing: IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        minVerticalPadding: 10,
      ),
    );
  }
}
