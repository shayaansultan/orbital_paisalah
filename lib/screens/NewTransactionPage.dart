import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../others/database.dart';
import 'package:orbital_paisalah/others/BalanceNotifier.dart';

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
  DateTime _dateTime = DateTime.now();
  bool _isExpense = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Transaction'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaction Type
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('Expense'),
                      value: true,
                      groupValue: _isExpense,
                      onChanged: (value) {
                        setState(() {
                          _transactionType = 'expense';
                          _isExpense = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('Income'),
                      value: false,
                      groupValue: _isExpense,
                      onChanged: (value) {
                        setState(() {
                          _transactionType == 'income';
                          _isExpense = false;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const Divider(
                height: 10,
                thickness: 1,
                color: Color(0xFFBDBDBD),
              ),

              //Amount
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
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

              //Note
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Note (Optional)',
                  prefixIcon: Icon(Icons.note),
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

              // Category
              if (_isExpense)
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
                      'Investments/Saving',
                      'Other',
                    ]
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category),
                    )),
              const Divider(color: Colors.transparent, height: 16.0),

              //Date and Time
              Row(
                children: <Widget>[
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
                        child: Text(DateFormat.yMd().format(_dateTime)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          prefixIcon: Icon(Icons.access_time),
                        ),
                        child: Text(DateFormat.Hm().format(_dateTime)),
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(color: Colors.transparent, height: 16.0),

              // Save Button
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
      )),
    );
  }

  void _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_transactionType == 'income' ||
          _transactionType == 'Income' ||
          _isExpense == false) {
        _category = 'Income';
      }

      bool success = await newTransaction(
          _amount, _isExpense, _category, _note, _dateTime);
      if (success) {
        await BalanceNotifier.initNotifications();
        await BalanceNotifier.showBalanceNotification(100);

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateTime),
    );
    if (picked != null) {
      setState(() {
        _dateTime = DateTime(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }
}
