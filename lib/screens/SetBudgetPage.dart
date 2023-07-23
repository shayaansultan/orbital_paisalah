import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetBudgetPage extends StatefulWidget {
  const SetBudgetPage({Key? key}) : super(key: key);

  @override
  _SetBudgetPageState createState() => _SetBudgetPageState();
}

class _SetBudgetPageState extends State<SetBudgetPage> {
  final db = FirebaseDatabase.instance.ref();
  final dailyBudgetController = TextEditingController();
  final weeklyBudgetController = TextEditingController();
  final monthlyBudgetController = TextEditingController();

  @override
  void dispose() {
    dailyBudgetController.dispose();
    weeklyBudgetController.dispose();
    monthlyBudgetController.dispose();
    super.dispose();
  }

  void _updateBudget() {
    final user = FirebaseAuth.instance.currentUser;
    final dailyBudget = double.tryParse(dailyBudgetController.text) ?? 0.0;
    final weeklyBudget = double.tryParse(weeklyBudgetController.text) ?? 0.0;
    final monthlyBudget = double.tryParse(monthlyBudgetController.text) ?? 0.0;

    db.child('users/${user!.uid}/budget').set({
      'daily': dailyBudget,
      'weekly': weeklyBudget,
      'monthly': monthlyBudget,
    }).then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      // Handle errors here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: dailyBudgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Set Daily Budget',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: weeklyBudgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Set Weekly Budget',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: monthlyBudgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Set Monthly Budget',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateBudget,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
