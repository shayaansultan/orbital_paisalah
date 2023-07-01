import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Transaction'),
        actions: [
          IconButton(
            onPressed: () {
              _saveTransaction;
            },
            icon: const Icon(Icons.save),
          ),
        ],
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
                decoration: const InputDecoration(
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
              const SizedBox(height: 12.0),
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                ),
                onSaved: (value) {
                  if (value == null || value.isEmpty) {
                    _note = '';
                  } else {
                    _note = value;
                  }
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
              const Divider(color: Colors.transparent, height: 16.0),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: DateFormat.yMd().add_jm().format(_selectedDateTime),
                ),
                onTap: () async {
                  final newDateTime = await showDatePicker(
                    context: context,
                    initialDate: _selectedDateTime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (newDateTime != null) {
                    final newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
                    );
                    if (newTime != null) {
                      setState(() {
                        _selectedDateTime = DateTime(
                          newDateTime.year,
                          newDateTime.month,
                          newDateTime.day,
                          newTime.hour,
                          newTime.minute,
                        );
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Date and Time',
                ),
              ),
              const SizedBox(height: 16.0),
              // const SizedBox(height: 16.0),
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
          _amount, _transactionType == 'Expense', _category, _note, _selectedDateTime);
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
