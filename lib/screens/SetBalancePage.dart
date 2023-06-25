import 'package:flutter/material.dart';
import '../others/database.dart';

class SetBalancePage extends StatefulWidget {
  @override
  _SetBalancePageState createState() => _SetBalancePageState();
}

class _SetBalancePageState extends State<SetBalancePage> {
  final _balanceController = TextEditingController();
  bool _isSuccess = false;

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Set New Balance'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _balanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Balance',
                  hintText: 'Enter your balance',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  double balance = double.parse(_balanceController.text);
                  bool isSuccess = await setBalance(balance);
                  setState(() {
                    _isSuccess = isSuccess;
                  });
                  _showDialog();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Set Balance',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_isSuccess ? 'Success' : 'Error'),
          content: Text(_isSuccess
              ? 'Balance updated successfully.'
              : 'Failed to update balance.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (_isSuccess) {
                  Navigator.pop(context);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
