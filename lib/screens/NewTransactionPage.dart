import 'package:flutter/material.dart';
import '../others/database.dart';

class NewTransactionPage extends StatefulWidget {
  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  String _transactionType = 'Expense';
  String _category = 'Food';
  double _amount = 0.0;
  String _note = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _transactionType,
                onChanged: (value) {
                  setState(() {
                    _transactionType = value!;
                  });
                },
                items: ['Expense', 'Income']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
              ),
              SizedBox(height: 16.0),
              if (_transactionType == 'Expense')
                DropdownButtonFormField<String>(
                  value: _category,
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                  items: [
                    'Food',
                    'Entertainment',
                    'Shopping',
                    'Transport',
                    'Housing',
                    'Investments/Saving'
                  ]
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                ),
              // const SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter an amount';
                //   }
                //   if (double.tryParse(value) == null) {
                //     return 'Please enter a valid number';
                //   }
                //   return null;
                // },
                onSaved: (value) {
                  if (value == null || value.isEmpty) {
                    _note = '';
                  } else {
                    _note = value;
                  }
                },
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _saveTransaction,
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_transactionType == 'Income') {
        _category = 'Income';
      }

      bool success = await newTransaction(
          _amount, _transactionType == 'Expense', _category, _note);
      if (success) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Transaction Saved'),
            content: Text('Your transaction has been saved.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while saving your transaction.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}
