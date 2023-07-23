import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:orbital_paisalah/cards/CurrentBalanceCard.dart';
import 'package:orbital_paisalah/cards/RecentTransactionsCard.dart';
import 'package:orbital_paisalah/screens/SetReminderPage.dart';
import 'package:orbital_paisalah/screens/starting_page.dart';
import 'package:orbital_paisalah/cards/NewPieChart.dart';
import 'package:orbital_paisalah/others/BalanceNotifier.dart';
import 'package:orbital_paisalah/screens/SetBudgetPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final db = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  num _balance = 0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
    _showBalanceNotification(100);
  }

  void _activateListeners() {
    db.child('users/${user!.uid}/balance').onValue.listen((event) {
      final balance = event.snapshot.value;
      setState(() {
        _balance = balance != null ? balance as num : 0;
      });
    });
  }

  Future<void> _showBalanceNotification(double balanceThreshold) async {
    await BalanceNotifier.initNotifications();
    await BalanceNotifier.showBalanceNotification(balanceThreshold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 23, 43),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('$userEmail'),
        backgroundColor: Color.fromARGB(255, 21, 41, 76),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StartingPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(padding: EdgeInsets.fromLTRB(16, 16, 16, 32), children: [
        // ElevatedButton(
        //     onPressed: () async {
        //       await BalanceNotifier.initNotifications();
        //       await BalanceNotifier.showBalanceNotification(100);
        //     },
        //     child: Text('Check Balance')),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // go to set budget page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetBudgetPage()),
                );
              },
              child: Text('Set Budget'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetReminderPage()),
                );
              },
              child: Text('Set Reminder'),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const CurrentBalanceCard(),
        const SizedBox(height: 30.0),
        RecentTransactionsCard(),
        const SizedBox(height: 30.0),
        // const PieChartCard(), //NEW CARD ADDED
        NewPieChart(),
      ]),
    );
  }
}
