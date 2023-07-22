import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbital_paisalah/screens/UpdateTransactionPage.dart';
import 'package:orbital_paisalah/others/TransactionCustom.dart';

class TransactionCard extends StatelessWidget {
  final String category;
  final num amount;
  final DateTime date;
  final String type;
  final String note;
  final String id;

  const TransactionCard({
    Key? key,
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
    required this.note,
    required this.id,
  }) : super(key: key);

  List<Widget> description() {
    if (note == '') {
      return [
        Text(category, style: const TextStyle(fontWeight: FontWeight.bold))
      ];
    } else {
      return [
        Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              category,
              textAlign: TextAlign.left,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(note,
                textAlign: TextAlign.left,
                style: const TextStyle(fontStyle: FontStyle.italic)))
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: false,
        tileColor: Color.fromARGB(255, 37, 68, 121),
        textColor: Colors.white,
        leading: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('\$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: type == 'expense'
                    ? Colors.redAccent
                    : Colors.lightGreenAccent,
              )),
        ]),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: description(),
        ),
        subtitle: Text(
            '${DateFormat.yMMMd().format(date)} ${DateFormat.jm().format(date)}'),
        trailing: IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateTransactionPage(
                            transaction: TransactionCustom(
                          id: id,
                          amount: amount,
                          category: category,
                          date: date.millisecondsSinceEpoch,
                          type: type,
                          note: note,
                        ))));
          },
        ),
        minVerticalPadding: 10,
      ),
    );
  }
}
