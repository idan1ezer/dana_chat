import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "הרשמה",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: nameCtrl,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.person_circle_fill),
                      border: InputBorder.none,
                      hintText: "שם מלא",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: emailCtrl,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.mail_solid),
                      border: InputBorder.none,
                      hintText: "אימייל",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: phoneCtrl,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.phone_fill),
                      border: InputBorder.none,
                      hintText: "נייד",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: passwordCtrl,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.lock_fill),
                      border: InputBorder.none,
                      hintText: "סיסמא",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {signUp(nameCtrl.text, emailCtrl.text, phoneCtrl.text, passwordCtrl.text);},
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                child: const Text(
                  "רישום",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp(String name, String email, String phone, String password) async {
    if(validate(name,email,phone,password)) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "weak-password":
            errorMessage = "The password provided is too weak.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "email-already-in-use":
            errorMessage = "The account already exists for that email..";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }

  bool validate(String name, String email, String phone, String password) {
    if(!RegExp(r"^.{3,}$").hasMatch(name)) {
      // Enter Valid name(Min. 3 Character)
      return false;
    }
    if(!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email) || email.isEmpty) {
      // Please enter your email
      // Please enter valid email
      return false;
    }
    if(!RegExp(r"^[0-9]{10}$").hasMatch(phone)) {
      // Enter Valid phone(10 numbers)
      return false;
    }
    if(!RegExp(r"^.{6,}$").hasMatch(password) || password.isEmpty) {
      //"Enter Valid Password(Min. 6 Character)"
      //"Password is required for login"
      return false;
    }
    return true;
  }
}
