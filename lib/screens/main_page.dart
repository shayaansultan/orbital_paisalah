import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orbital_paisalah/screens/starting_page.dart';
import 'package:orbital_paisalah/screens/transaction_item_tile.dart';
import 'login_page.dart';
import 'income_expense_card.dart';
import 'SetBalancePage.dart';
import 'NewTransactionPage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        //padding: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 64,
            // ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: Column(
                  children: [
                    Text("\$1100.00",
                        style: Theme.of(context).textTheme.titleLarge),
                    Text("Total Balance",
                        style: Theme.of(context).textTheme.titleLarge)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: const [
                Expanded(
                    child: IncomeExpenseCard(
                  expenseData:
                      ExpenseData("Income", "2000", Icons.arrow_upward_rounded),
                )),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: IncomeExpenseCard(
                  expenseData: ExpenseData(
                      "Expense", "-900", Icons.arrow_downward_rounded),
                ))
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            const Text("Recent Transactions"),
            const SizedBox(
              height: 32.0,
            ),
            const Text("Today"),
            const SizedBox(
              height: 30.0,
            ),
            //TransactionItemTile()

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetBalancePage()),
                );
              },
              child: Text('Set Balance'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewTransactionPage()),
                );
              },
              child: Text('New Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
// backgroundColor: const Color.fromARGB(255, 24, 51, 81),
// shadowColor: Colors.transparent,
// title: Text("PaisaLah!", style: TextStyle(color: Colors.white)),
// automaticallyImplyLeading: false,
// actions: [
//   IconButton(
//     icon: const Icon(Icons.logout),
//     onPressed: () async {
//       await FirebaseAuth.instance.signOut();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => StartingPage()),
//       );
//     },
//   ),
// ]
