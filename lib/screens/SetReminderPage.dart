import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SetReminderPage extends StatefulWidget {
  const SetReminderPage({Key? key}) : super(key: key);

  @override
  _SetReminderPageState createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  final db = FirebaseDatabase.instance.ref();
  final noteController = TextEditingController();
  DateTime? selectedDate = DateTime.now();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate!) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _updateReminder() {
    final user = FirebaseAuth.instance.currentUser;
    final note = noteController.text;
    final date = selectedDate?.millisecondsSinceEpoch ?? 0;

    db.child('users/${user!.uid}/reminder').push().update({
      'note': note,
      'date': date,
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
        title: Text('Set Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(DateFormat.yMd().format(selectedDate!)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Text(
              'A reminder will be sent next time you open the app on the selected date.',
              style: TextStyle(
                  // color: Colors.grey,
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateReminder,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
