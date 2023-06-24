import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = FirebaseDatabase.instance.ref();
final user = FirebaseAuth.instance.currentUser;
final userID = user!.uid;

Future<bool> setBalance(double balance) async {
  try {
    await db.child('users/$userID').update({'balance': balance});
    print('Balance updated');
    return true;
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

Future<bool> newTransaction(num amount, bool isExpense, String category) async {
  try {
    final snapshot = await db.child('users/$userID/balance').get();

    final balance = snapshot.value;

    final new_balance = balance != null
        ? (balance as num) + (isExpense ? -amount : amount)
        : amount;

    await db.child('users/$userID').update({'balance': new_balance});

    await db.child('users/$userID/transactions').push().set({
      'amount': amount,
      'type': isExpense ? 'expense' : 'income', // 'expense' or 'income
      'category': category,
      'date': DateTime.now().millisecondsSinceEpoch,
    });
    print('Expense added');
    return true;
  } catch (e) {
    print('Error: $e');
    return false;
  }
}