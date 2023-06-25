import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'TransactionCustom.dart';
import 'TransactionCard.dart';
import 'NewTransactionPage.dart';

class RecentTransactionsCard extends StatelessWidget {
  final db = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser;

  RecentTransactionsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 21, 41, 76),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewTransactionPage()),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'New',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Divider(
              color: Colors.white,
              thickness: 1,
            ),
          ),

          // Divider(
          //   color: Colors.white,
          //   thickness: 1,
          // ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactionList.length > 3
                            ? 3
                            : transactionList.length,
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
                        child: Text(
                          'No Transactions Available',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ));
                  }
                },
              )),
          // const Padding(
          //   padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          //   child: Divider(
          //     color: Colors.white,
          //     thickness: 1,
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => NewTransactionPage()),
              //     );
              //   },
              //   child: const Text('New Transaction'),
              // ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to All Transactions page
                    },
                    child: const Text('All Transactions'),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
