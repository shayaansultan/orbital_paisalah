import 'package:flutter/material.dart';

class TransactionItemTile extends StatelessWidget {
  const TransactionItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
            leading: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(color: Colors.indigo,
              ),
            child: const Icon(Icons.access_time_filled_sharp)),
            title: const Text("Jacket"),
            subtitle: const Text("Adidas"),
            trailing: Column(
              children: const [
                Text("-\$1200"),
                SizedBox(height: 30.0,),
                Text("Aug 25")
          ],),
      ),
    );
  }
}
