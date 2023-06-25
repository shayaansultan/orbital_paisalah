import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'NewTransactionPage.dart';
import 'package:orbital_paisalah/others/TransactionCustom.dart';
import 'package:orbital_paisalah/cards/TransactionCard.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();

  const TransactionsPage({Key? key}) : super(key: key);
}

class _TransactionsPageState extends State<TransactionsPage> {
  final db = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 23, 43),
      appBar: AppBar(
        title: const Text('All Transactions'),
        backgroundColor: Color.fromARGB(255, 21, 41, 76),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewTransactionPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
              child: StreamBuilder(
                stream: db.child('users/${user!.uid}/transactions').onValue,
                builder: (context, snapshot) {
                  try {
                    if (snapshot.hasData) {
                      final transactions = Map<String, dynamic>.from(snapshot
                          .data!.snapshot.value as Map<dynamic, dynamic>);
                      final transactionList = transactions.entries
                          .map((entry) => TransactionCustom.fromMap(entry.key,
                              Map<String, dynamic>.from(entry.value)))
                          .toList();
                      transactionList.sort((a, b) => b.date.compareTo(a.date));
                      return ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactionList.length,
                        itemBuilder: (context, index) {
                          final transaction = transactionList[index];
                          return TransactionCard(
                            category: transaction.category,
                            amount: transaction.amount,
                            date: (DateTime.fromMillisecondsSinceEpoch(
                                transaction.date)),
                            type: transaction.type,
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  } catch (e) {
                    return Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'No Transactions Available',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ));
                  }
                },
              ))),
    );
  }
}
