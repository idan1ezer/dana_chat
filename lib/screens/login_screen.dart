import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dana_chat/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        centerTitle: true,
        title: const Text(
          "התחברות",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Image.asset('images/Dana.png'),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "!ברוכים השבים",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "אפליקציית דנה - עוזרת הסוכרת הרשמית",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
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
                    controller: emailCtrl,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.emailAddress,
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
                    controller: passwordCtrl,
                    textAlign: TextAlign.right,
                    obscureText: true,
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
                onPressed: () {login(emailCtrl.text, passwordCtrl.text);},
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                child: const Text(
                  "התחברות",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                      },
                      child: const Text(
                        "!הירשם עכשיו",
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      )),
                  const Text(
                    "?לא רשום",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(String emailCtrl, String passwordCtrl) async{
    if (validate(emailCtrl,passwordCtrl)) {
      //login
      try {
        final credential = await _auth.signInWithEmailAndPassword(email: emailCtrl, password: passwordCtrl)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }

    }
  }

  bool validate(String email, String password) {
    if(!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email) || email.isEmpty) {
      // Please enter your email
      // Please enter valid email
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
