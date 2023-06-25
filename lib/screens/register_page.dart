import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main_page.dart';
import '../others/database.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isSuccess = false;
  String _errorMessage = '';
  bool _passwordMatch = false;

  Future<String> signUp(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 51, 81),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 51, 81),
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Title(
                  color: Colors.white,
                  child: const Text("Register",
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center)),
              const SizedBox(height: 50),
              Container(
                //padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text("Confirm Password"),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            _showPasswordMatch();
                            return;
                          }

                          _errorMessage = await signUp(
                              _emailController.text, _passwordController.text);
                          if (_errorMessage == 'Success') {
                            _isSuccess = true;
                          } else {
                            _isSuccess = false;
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => MainPage()),
                          // );
                          _showDialog();
                        },

                        //   try {
                        //     // UserCredential userCredential = await FirebaseAuth
                        //     //     .instance
                        //     //     .createUserWithEmailAndPassword(
                        //     //   email: _emailController.text,
                        //     //   password: _passwordController.text,
                        //     // );

                        //     // User is signed up, navigate to main page
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => MainPage()),
                        //     );
                        //   } on FirebaseAuthException catch (e) {
                        //     if (e.code == 'weak-password') {
                        //       print('The password provided is too weak.');
                        //     } else if (e.code == 'email-already-in-use') {
                        //       print(
                        //           'The account already exists for that email.');
                        //     }
                        //   } catch (e) {
                        //     print(e);
                        //   }
                        // },
                        child: const Text("Register"),
                      ),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _showPasswordMatch() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Passwords do not Match'),
          content: Text('Password and Confirm Password do not match'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_isSuccess ? 'Success' : 'Error'),
          content: Text(_isSuccess
              ? 'Sign up was successful.'
              : 'Failed to sign up.\n\n$_errorMessage'),
          actions: [
            TextButton(
              onPressed: () {
                if (_isSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
