import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 24, 51, 81),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            //SizedBox(height: 100), // Add spacing to move the Logo down
            Center(child: Image(image: AssetImage('lib/assets/Logo.png'))),
            SizedBox(height: 20), // Add spacing between the Logo and text
            Text(
              'PaisaLah!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Add spacing between the title and caption
            Text(
              'Your one-stop personal finance solution',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 24, 51, 81)),
                minimumSize: MaterialStateProperty.all<Size>(Size(100, 40)),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: Colors.white)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 24, 51, 81)),
                minimumSize: MaterialStateProperty.all<Size>(Size(100, 40)),
                side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: Colors.white)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child:
                  const Text('Register', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
