// ignore_for_file: use_build_context_synchronously

import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../firebase references/firebase_refs.dart';
import 'nav bar pages/achievements_page.dart';

// This class is used to create a login page for user to login.
// And it will lead the user to different page based on their position and
// the status of the first time login.
class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Achievementpage achievementpage = Achievementpage();

  LoginPage({super.key});

  Future handleLogin(BuildContext context) async {
    // get the information
    String username = usernameController.text;
    String password = passwordController.text;

    try {
      //Implement the login function
      await fireAuth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successfully.'),
          duration: Duration(seconds: 1),
        ),
      );

      checkUserPosition(context);

      debugPrint('Username: $username, Password: $password');
      // If the authentication is successful, the user is logged in.
    } catch (e) {
      // If there's an error, show an error message.
      if (username.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter both username and password.'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password.'),
            duration: Duration(seconds: 1),
          ),
        );
        debugPrint('Error during login');
      }
    }
    //
  }

  // Check user position
  void checkUserPosition(context) async {
    // instance pulled from references
    User? user = fireAuth.currentUser;
    if (user != null) {
      String uid = user.uid;

      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('User').doc(uid).get();
        if (snapshot.exists) {
          String position = snapshot.data()!['position'];

          // Determin logic based on position
          if (position == 'developer') {
            bool isFirstLogin = snapshot.data()!['firstlog'];
            debugPrint('User is a developer.');
            // Update the 'firstlog' field if it's the first login
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MainScreen()));
            if (isFirstLogin) {
              debugPrint("go to the teaser page");
              Get.toNamed('/teaser')?.then((value) => Get.toNamed('/help'));

              //update the status of firstlog in firestone
              await FirebaseFirestore.instance
                  .collection('User')
                  .doc(uid)
                  .update({'firstlog': false});

              achievementpage.updateAchievement(context, "First time login!");
            } else {
              Get.off("/mainScreen");
            }
          } else if (position == 'manager') {
            debugPrint('User is a manager.');
            //handle the manager mode below.
            Get.offAndToNamed("/manager");
          } else {
            debugPrint('User position unknown.');
          }
        } else {
          debugPrint('User data not found in Firestore.');
        }
      } catch (e) {
        debugPrint('Error retrieving user data: $e');
      }
    } else {
      debugPrint('User not logged in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: fiservColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Fiserv_logo.png',
                    width: 400,
                    height: 100,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome to Firserv',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: fiservColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the login event
                      handleLogin(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: fiservColor,
                    ),
                    child: const Text('Login',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
