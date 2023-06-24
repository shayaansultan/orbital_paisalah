import 'package:flutter/material.dart';
import 'CurrentBalanceCard.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Test Page"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            //padding: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 64,
                // ),
                CurrentBalanceCard(balance: 1100.00),
                const SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
        ));
  }
}
