import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'database.dart';
import 'SetBalancePage.dart';

class CurrentBalanceCard extends StatefulWidget {
  const CurrentBalanceCard({Key? key}) : super(key: key);

  @override
  _CurrentBalanceCardState createState() => _CurrentBalanceCardState();
}

class _CurrentBalanceCardState extends State<CurrentBalanceCard> {
  final db = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 21, 41, 76),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            // SizedBox(height: 8.0),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),

            StreamBuilder<DatabaseEvent>(
              stream: db.child('users/${user!.uid}/balance').onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final balance = snapshot.data?.snapshot.value as num?;
                  return Text(
                    '\$${balance != null ? (balance).toStringAsFixed(2) : '0.00'}',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetBalancePage()),
                );
              },
              child: Text('Change Balance'),
            ),
          ],
        ),
      ),
    );
  }
}
