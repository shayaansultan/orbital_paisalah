import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future signIn(email, password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 51, 81),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 24, 51, 81),
          shadowColor: Colors.transparent,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Title(
                color: Colors.white,
                child: const Text("Login",
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center)),
            const SizedBox(height: 50),
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                label: Text("Enter Email"),
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                prefixIconColor: Colors.white,
                suffixIconColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: const InputDecoration(
                label: Text("Enter Password"),
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.password_outlined),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                prefixIconColor: Colors.white,
                suffixIconColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  signIn(_emailController.text, _passwordController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                child: const Text("Login"),
              ),
            ),
          ]),
        ));
  }
}
