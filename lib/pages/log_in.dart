import 'package:crud_app/components/textfield_widget.dart';
import 'package:crud_app/pages/home.dart';
import 'package:crud_app/pages/signup.dart';
import 'package:crud_app/pages/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Log_in extends StatefulWidget {
  const Log_in({super.key});

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  TextEditingController mypassword = TextEditingController();
  TextEditingController myemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration:const  BoxDecoration(color: Color.fromARGB(255, 10, 4, 114)),
        child: ListView(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/3.jpg"), fit: BoxFit.fill)),
            ),
           const  Padding(
              padding:  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
           const  Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "please sign in to continue",
                style: TextStyle(fontSize: 15, color: Colors.white60),
              ),
            ),
            reusableTextField("Email", Icons.email, false, myemail),
            reusableTextField("Password", Icons.key, false, mypassword),
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
                        .signInWithEmailAndPassword(
                            email: myemail.text, password: mypassword.text)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SignUP();
                      },
                    ));
                  },
                  child: const Text("Don't have an account? Sign up")),
            )
          ],
        ),
      ),
    );
  }
}
