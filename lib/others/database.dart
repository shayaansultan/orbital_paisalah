import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'BalanceNotifier.dart';

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

Future<void> budgetChecker() async {
  try {
    final dailySnap = await db.child('users/$userID/budget/daily').get();
    final dailyBudget = dailySnap.value as num;
    final weeklySnap = await db.child('users/$userID/budget/weekly').get();
    final weeklyBudget = weeklySnap.value as num;
    final monthlySnap = await db.child('users/$userID/budget/monthly').get();
    final monthlyBudget = monthlySnap.value as num;

    //write code for getting the millseconds from epoch for today, this week and this month
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = DateTime(today.year, today.month, today.day + 1);

    // final weekStart = today.subtract(Duration(days: today.weekday - 1));
    // final weekEnd =
    //     today.add(Duration(days: DateTime.daysPerWeek - today.weekday));

    final day = today.weekday;
    final weekStart = DateTime(today.year, today.month, today.day - day + 1);
    final weekEnd = DateTime(today.year, today.month, today.day - day + 8);

    final monthStart = DateTime(today.year, today.month, 1);
    final monthEnd = DateTime(today.year, today.month + 1, 1);

    //getting the total expense for today, this week and this month
    final transactions =
        await db.child('users/${user!.uid}/transactions').get();
    final transactionList = transactions.value;
    final newMap = transactionList as Map<dynamic, dynamic>;
    Map<String, double> budgetMap = {
      'daily': 0.0,
      'weekly': 0.0,
      'monthly': 0.0,
    };

    //filter newMap for transactions that are within today, this week and this month
    newMap.forEach((key, value) {
      final innerMap = Map.from(value);
      final amount = innerMap['amount'].toDouble();
      final date = innerMap['date'] as int;
      final type = innerMap['type'] as String;

      if (type == 'expense') {
        if (date >= todayStart.millisecondsSinceEpoch &&
            date < todayEnd.millisecondsSinceEpoch) {
          budgetMap['daily'] = budgetMap['daily']! + amount;
        }

        if (date >= weekStart.millisecondsSinceEpoch &&
            date < weekEnd.millisecondsSinceEpoch) {
          budgetMap['weekly'] = budgetMap['weekly']! + amount;
        }

        if (date >= monthStart.millisecondsSinceEpoch &&
            date < monthEnd.millisecondsSinceEpoch) {
          budgetMap['monthly'] = budgetMap['monthly']! + amount;
        }
      }
    });

    //check if the budget is exceeded, and if yes, send a notification
    final todayExpense = budgetMap['daily']!;
    final weekExpense = budgetMap['weekly']!;
    final monthExpense = budgetMap['monthly']!;

    if (todayExpense > dailyBudget) {
      //send notification
      BalanceNotifier.showBalanceNotification('daily');
    }

    if (weekExpense > weeklyBudget) {
      //send notification
      BalanceNotifier.showBalanceNotification('weekly');
    }

    if (monthExpense > monthlyBudget) {
      BalanceNotifier.showBalanceNotification('monthly');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> reminderChecker() async {
  try {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = DateTime(today.year, today.month, today.day + 1);

    final reminders = await db.child('users/${user!.uid}/reminder').get();

    final reminderList = reminders.value;

    if (reminderList != null) {
      final newMap = reminderList as Map<dynamic, dynamic>;

      newMap.forEach((key, value) {
        final innerMap = Map.from(value);
        final date = innerMap['date'] as int;
        final note = innerMap['note'] as String;

        if (date >= todayStart.millisecondsSinceEpoch &&
            date < todayEnd.millisecondsSinceEpoch) {
          BalanceNotifier.showReminderNotification(note);
        }
      });
    }
  } catch (e) {
    print('Error: $e');
  }
}
