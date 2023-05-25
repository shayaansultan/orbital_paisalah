import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 51, 81),
        shadowColor: Colors.transparent,
        title: Text("PaisaLah!", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
