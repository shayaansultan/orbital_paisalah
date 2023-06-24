import 'package:flutter/material.dart';
import 'database.dart';

class SetBalancePage extends StatefulWidget {
  @override
  _SetBalancePageState createState() => _SetBalancePageState();
}

class _SetBalancePageState extends State<SetBalancePage> {
  final _balanceController = TextEditingController();

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set New Balance'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _balanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Balance',
                  hintText: 'Enter your balance',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  double balance = double.parse(_balanceController.text);
                  setBalance(balance);
                  Navigator.pop(context);
                },
                child: const Text('Set Balance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
