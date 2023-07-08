import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:orbital_paisalah/cards/CurrentBalanceCard.dart';
import 'package:orbital_paisalah/cards/RecentTransactionsCard.dart';
import 'package:orbital_paisalah/screens/starting_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
    _firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });

      },
      onResume: (message) async{
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });

      },
    );
  }

  void _activateListeners() {
    db.child('users/${user!.uid}/balance').onValue.listen((event) {
      final balance = event.snapshot.value;
      setState(() {
        _balance = balance != null ? balance as num : 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
<<<<<<< Updated upstream
      body: SingleChildScrollView(
          child: Container(
        color: Color.fromARGB(255, 12, 23, 43),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CurrentBalanceCard(),
              const SizedBox(
                height: 30.0,
              ),
              RecentTransactionsCard()
            ],
          ),
        ),
      )),
=======
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              notificationAlert,
            ),
            Text(
              messageTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      body: ListView(padding: EdgeInsets.fromLTRB(16, 32, 16, 0), children: [
        const CurrentBalanceCard(),
        const SizedBox(height: 30.0),
        RecentTransactionsCard(),
        const SizedBox(height: 30.0),
        const PieChartCard(), //NEW CARD ADDED
      ]),
>>>>>>> Stashed changes
    );
  }
}
// backgroundColor: const Color.fromARGB(255, 24, 51, 81),
// shadowColor: Colors.transparent,
// title: Text("PaisaLah!", style: TextStyle(color: Colors.white)),
// automaticallyImplyLeading: false,
// actions: [
//   IconButton(
//     icon: const Icon(Icons.logout),
//     onPressed: () async {
//       await FirebaseAuth.instance.signOut();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => StartingPage()),
//       );
//     },
//   ),
// ]
