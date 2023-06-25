import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseData{
  final String label;
  final String amount;
  final IconData icon;
  const ExpenseData(this.label, this.amount, this.icon);
}
class IncomeExpenseCard extends StatelessWidget{

  final ExpenseData expenseData;
  const IncomeExpenseCard({Key? key, required this.expenseData}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [Text(expenseData.label),Text(expenseData.amount)
        ],),
      ),
      Icon(expenseData.icon)
    ],),);
  }


}
