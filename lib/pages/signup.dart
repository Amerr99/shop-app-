import 'package:crud_app/components/textfield_widget.dart';
import 'package:crud_app/pages/log_in.dart';
import 'package:crud_app/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  TextEditingController myemail = TextEditingController();
  TextEditingController mypassword = TextEditingController();
  TextEditingController myphone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 10, 4, 114)),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: 200,
              child: Column(
                children: const [
                  Text(
                    "Create Account",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "please fill the input below here",
                    style: TextStyle(color: Colors.white60, fontSize: 20),
                  ),
                ],
              ),
            ),
            reusableTextField("Email", Icons.email, false, myemail),
            reusableTextField("Password", Icons.key, true, mypassword),
            // MyTextField(label: "Phone", myicon: Icons.phone_android, myphone),
            // MyTextField(label: "Email", myicon: Icons.email, myemail),
            // MyTextField(label: "Password", myicon: Icons.key, mypassword),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(200, 60),
                      backgroundColor: Colors.purple,
                      shadowColor: Colors.purpleAccent),
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: myemail.text, password: mypassword.text)
                        .then((value) {
                      print("Created new account");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Log_in()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
