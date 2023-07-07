import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:orbital_paisalah/others/database.dart';
import 'package:orbital_paisalah/others/TransactionCustom.dart';

class UpdateTransactionPage extends StatefulWidget {
  final TransactionCustom transaction;

  UpdateTransactionPage({required this.transaction});

  @override
  _UpdateTransactionPageState createState() => _UpdateTransactionPageState();
}

class _UpdateTransactionPageState extends State<UpdateTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _category = 'Food';
  bool _isExpense = true;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.transaction.amount.toString();
    _noteController.text = widget.transaction.note;
    _category = widget.transaction.category;
    _isExpense = widget.transaction.type == 'expense';
    _dateTime = DateTime.fromMillisecondsSinceEpoch(widget.transaction.date);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
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

  void _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final note = _noteController.text;
      final dateTime = _dateTime;
      final id = widget.transaction.id;

      final result = await updateTransaction(
        id,
        amount,
        _isExpense,
        _category,
        note,
        dateTime,
      );

      if (result) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Transaction updated'),
              content: Text('The transaction has been updated.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content:
                  Text('An error occurred while updating the transaction.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Type
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const Text('Expense'),
                        value: true,
                        groupValue: _isExpense,
                        onChanged: (value) {
                          setState(() {
                            _isExpense = value!;
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
                            _isExpense = value!;
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
                // Amount
                TextFormField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount.';
                    }
                    final double? amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'Please enter a valid amount.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Note
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    prefixIcon: Icon(Icons.note),
                  ),
                  onSaved: (value) {
                    if (value == null || value.isEmpty) {
                      _noteController.text = '';
                    }
                  },
                ),
                const SizedBox(height: 16.0),

                // Category
                if (_isExpense) ...[
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category),
                    ),
                  ),
                ],

                const SizedBox(height: 16.0),

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

                Center(
                  child: ElevatedButton(
                    onPressed: _saveTransaction,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
