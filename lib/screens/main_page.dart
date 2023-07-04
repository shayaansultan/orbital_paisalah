import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:orbital_paisalah/cards/CurrentBalanceCard.dart';
import 'package:orbital_paisalah/cards/PieChartCard.dart';
import 'package:orbital_paisalah/cards/RecentTransactionsCard.dart';
import 'package:orbital_paisalah/screens/starting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final db = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  double _balance = 0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    db.child('users/${user!.uid}/balance').onValue.listen((event) {
      final balance = event.snapshot.value;
      setState(() {
        _balance = balance != null ? balance as double : 0;
      });
    });
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
      body: ListView(padding: EdgeInsets.fromLTRB(16, 32, 16, 32), children: [
        const CurrentBalanceCard(),
        const SizedBox(height: 30.0),
        RecentTransactionsCard(),
        const SizedBox(height: 30.0),
        const PieChartCard(), //NEW CARD ADDED
      ]),
    );
  }
}
