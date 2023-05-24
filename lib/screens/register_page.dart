import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
                        onPressed: () {},
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
}
