import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = FirebaseDatabase.instance.ref();
final user = FirebaseAuth.instance.currentUser;
final userID = user!.uid;

void setBalance(double balance) async {
  try {
    await db.child('users/$userID').update({'balance': balance});
    print('Balance updated');
  } catch (e) {
    print('Error: $e');
  }
}

void newTransaction(
  String name,
  double amount,
  String category,
  bool isExpense,
) async {
  try {
    if (isExpense) {
      await db.child('users/$userID').update({'balance': -amount});
    } else {
      await db.child('users/$userID').update({'balance': amount});
    }

    await db.child('users/$userID/transactions').push().set({
      'name': name,
      'amount': amount,
      'category': category,
      'date': DateTime.now().toString(),
    });
    print('Expense added');
  } catch (e) {
    print('Error: $e');
  }
}
