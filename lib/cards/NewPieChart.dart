import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/SetBalancePage.dart';
import 'package:pie_chart/pie_chart.dart';

class NewPieChart extends StatefulWidget {
  const NewPieChart({Key? key}) : super(key: key);

  @override
  _NewPieChart createState() => _NewPieChart();
}

class _NewPieChart extends State<NewPieChart> {
  final db = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 21, 41, 76),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categorical Spending',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            // SizedBox(height: 8.0),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.3,
                )),

            StreamBuilder<DatabaseEvent>(
              stream: db.child('users/${user!.uid}/transactions').onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final transactionList = snapshot.data?.snapshot.value;

                  if (transactionList == null) {
                    return Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'No Transactions Available',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ));
                  } else {
                    final newMap = transactionList as Map<dynamic, dynamic>;

                    Map<String, double> expenseMap = {};

                    newMap.forEach((key, value) {
                      final innerMap = Map.from(value);
                      final amount = innerMap['amount'].toDouble();
                      final category = innerMap['category'] as String;
                      final type = innerMap['type'] as String;

                      if (type == 'expense') {
                        if (expenseMap.containsKey(category)) {
                          expenseMap[category] = expenseMap[category]! + amount;
                        } else {
                          expenseMap[category] = amount as double;
                        }
                      }
                    });

                    if (expenseMap.isEmpty) {
                      return Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'No Expenses Available',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ));
                    } else {
                      return PieChart(
                        dataMap: expenseMap,
                        colorList: const [
                          Colors.green,
                          Colors.blue,
                          Colors.red,
                          Colors.pinkAccent,
                          Colors.purple,
                          Colors.brown
                        ],
                        chartType: ChartType.disc,
                        // chartRadius: MediaQuery.of(context).size.width / 2.7,
                        animationDuration: const Duration(milliseconds: 800),
                        legendOptions: const LegendOptions(
                          legendTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                          decimalPlaces: 1,
                        ),
                      );
                    }
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
