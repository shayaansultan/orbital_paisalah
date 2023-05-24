import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 51, 81),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 24, 51, 81),
          shadowColor: Colors.transparent,
        ),
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              cursorColor: Colors.white,
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.white),
            )
          ]),
        ));
  }
}
