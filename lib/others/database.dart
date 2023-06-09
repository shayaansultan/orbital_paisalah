import 'dart:async';
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

Future<bool> newTransaction(num amount, bool isExpense, String category,
    String note, DateTime dateTime) async {
  try {
    final new_amount;
    if (isExpense) {
      new_amount = -amount;
    } else {
      new_amount = amount;
    }

    final snapshot = await db.child('users/$userID/balance').get();

    final balance = snapshot.value;

    final new_balance =
        balance != null ? (balance as num) + (new_amount) : new_amount;

    await db.child('users/$userID').update({'balance': new_balance});

    await db.child('users/$userID/transactions').push().set({
      'amount': amount,
      'type': isExpense ? 'expense' : 'income', // 'expense' or 'income
      'category': category,
      'date': dateTime.millisecondsSinceEpoch,
      'note': note,
    });
    print('Expense added');
    return true;
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

Future<bool> updateTransaction(String id, num amount, bool isExpense,
    String category, String note, DateTime dateTime) async {
  try {
    final amountSnap =
        await db.child('users/$userID/transactions/$id/amount').get();
    num oldAmount = amountSnap.value as num;
    final typeSnap =
        await db.child('users/$userID/transactions/$id/type').get();
    final oldType = typeSnap.value;

    if (oldType == 'expense') {
      oldAmount = -(oldAmount);
    }

    final new_amount;
    if (isExpense) {
      new_amount = -amount;
    } else {
      new_amount = amount;
    }

    final snapshot = await db.child('users/$userID/balance').get();

    final balance = snapshot.value;

    final new_balance = balance != null
        ? (balance as num) + (new_amount) - (oldAmount)
        : new_amount;

    await db.child('users/$userID').update({'balance': new_balance});

    //updating the transaction
    await db.child('users/$userID/transactions/$id').update({
      'amount': amount,
      'type': isExpense ? 'expense' : 'income', // 'expense' or 'income
      'category': category,
      'date': dateTime.millisecondsSinceEpoch,
      'note': note,
    });

    return true;
  } catch (e) {
    print('Error: $e');
    return false;
  }
}
