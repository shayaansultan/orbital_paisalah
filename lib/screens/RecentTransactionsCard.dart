import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'TransactionCustom.dart';
import 'TransactionCard.dart';
import 'NewTransactionPage.dart';

class RecentTransactionsCard extends StatelessWidget {
  final db = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 21, 41, 76),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Divider(
              color: Colors.white,
              thickness: 1,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTransactionPage()),
                  );
                },
                child: const Text('New Transaction'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to All Transactions page
                },
                child: Text('All Transactions'),
              ),
            ],
          ),
          // Divider(
          //   color: Colors.white,
          //   thickness: 1,
          // ),
          StreamBuilder(
            stream: db.child('users/${user!.uid}/transactions').onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final transactions = Map<String, dynamic>.from(
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>);
                final transactionList = transactions.entries
                    .map((entry) => TransactionCustom.fromMap(
                        entry.key, Map<String, dynamic>.from(entry.value)))
                    .toList();
                transactionList.sort((a, b) => b.date.compareTo(a.date));
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      transactionList.length > 3 ? 3 : transactionList.length,
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
                return CircularProgressIndicator();
              }
            },
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTransactionPage()),
                  );
                },
                child: const Text('New Transaction'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to All Transactions page
                },
                child: Text('All Transactions'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
