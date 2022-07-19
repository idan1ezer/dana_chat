import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

                  child: const TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
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
                  child: const TextField(
                    textAlign: TextAlign.right,
                    obscureText: true,
                    decoration: InputDecoration(
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
                onPressed: () {},
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
                      onPressed: () {},
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
}
