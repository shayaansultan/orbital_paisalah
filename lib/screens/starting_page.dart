import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_page.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 24, 51, 81),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(height: 100), // Add spacing to move the Logo down
            const Center(
                child: Image(image: AssetImage('lib/assets/Logo.png'))),
            //SizedBox(height: 10), // Add spacing between the Logo and text
            const Text(
              'PaisaLah!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(
                height: 10), // Add spacing between the title and caption
            const Text(
              'Your one-stop personal finance solution',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(
              height: 50,
            ), // Add spacing between the caption and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 24, 51, 81)),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(100, 40)),
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.white)),
                  ),
                  onPressed: () async {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // User is logged in, navigate to main page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    } else {
                      // User is not logged in, navigate to login page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  },
                  child: const Text('Login',
                      style: TextStyle(color: Colors.white)),
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
                  child: const Text('Register',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//   //   //   bottomNavigationBar: BottomAppBar(
//   //   //     child: Row(
//   //   //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //   //       children: [
//   //   //         OutlinedButton(
//   //   //           style: ButtonStyle(
//   //   //             backgroundColor: MaterialStateProperty.all<Color>(
//   //   //                 const Color.fromARGB(255, 24, 51, 81)),
//   //   //             minimumSize:
//   //   //                 MaterialStateProperty.all<Size>(const Size(100, 40)),
//   //   //             side: MaterialStateProperty.all<BorderSide>(
//   //   //                 const BorderSide(color: Colors.white)),
//   //   //           ),
//   //   //           onPressed: () {
//   //   //             Navigator.push(
//   //   //               context,
//   //   //               MaterialPageRoute(builder: (context) => LoginPage()),
//   //   //             );
//   //   //           },
//   //   //           child: const Text('Login', style: TextStyle(color: Colors.white)),
//   //   //         ),
//   //   //         OutlinedButton(
//   //   //           style: ButtonStyle(
//   //   //             backgroundColor: MaterialStateProperty.all<Color>(
//   //   //                 const Color.fromARGB(255, 24, 51, 81)),
//   //   //             minimumSize: MaterialStateProperty.all<Size>(Size(100, 40)),
//   //   //             side: MaterialStateProperty.all<BorderSide>(
//   //   //                 const BorderSide(color: Colors.white)),
//   //   //           ),
//   //   //           onPressed: () {
//   //   //             Navigator.push(
//   //   //               context,
//   //   //               MaterialPageRoute(builder: (context) => RegisterPage()),
//   //   //             );
//   //   //           },
//   //   //           child:
//   //   //               const Text('Register', style: TextStyle(color: Colors.white)),
//   //   //         ),
//   //   //       ],
//   //   //     ),
//   //   //   ),
//   //   // );
//   // }
// }
