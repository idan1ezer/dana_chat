import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dana_chat/widgets/regWidgets/regWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  _RegisterScreenState() {
    _genderSelectedVal = _genderList[0];
    _educationSelectedVal = _educationList[0];
  }

  final nameCtrl = TextEditingController();
  //final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  //final passwordCtrl = TextEditingController();
  final employeeCtrl = TextEditingController();

  final _genderList = ["זכר", "נקבה"];
  String? _genderSelectedVal = "";
  final _educationList = ["ללא", "12 שנות לימוד", "תואר ראשון", "תואר שני"];
  String? _educationSelectedVal = "";
  final _languageList = ["עברית", "אנגלית", "רוסית", "ערבית", "ספרדית"];
  String? _lang1SelectedVal = "";
  String? _lang2SelectedVal = "";

  DateTime? _dateTime;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  int _activeStepIndex = 0;

  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: Text("שלב"),
            content: Center(
              child: Column(
                children: [
                  RegTextField(
                    textCtrl: nameCtrl,
                    icon: CupertinoIcons.person_circle_fill,
                    hint: "שם מלא",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField(
                            value: _educationList[0],
                            items: _educationList
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                textAlign: TextAlign.right,
                              ),
                            ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _educationSelectedVal = val as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "השכלה",
                              labelStyle: TextStyle(color: Colors.purple),
                              prefixIcon: Icon(
                                CupertinoIcons.pencil,
                                color: Colors.purple,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent)),
                              //border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField(
                            value: _genderList[0],
                            items: _genderList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        textAlign: TextAlign.right,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _genderSelectedVal = val as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "מין",
                              labelStyle: TextStyle(color: Colors.purple,),
                              prefixIcon: Icon(
                                Icons.accessibility_new,
                                color: Colors.purple,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              //border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2099))
                                .then((date) {
                              setState(() {
                                _dateTime = date;
                              });
                            });
                          },
                          child: Text(
                            _dateTime == null
                                ? 'בחר תאריך לידה'
                                : formatter.format(_dateTime!),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: phoneCtrl,
                          icon: CupertinoIcons.phone_fill,
                          hint: "נייד",
                          inputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField(
                            value: _languageList[0],
                            items: _languageList
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                textAlign: TextAlign.right,
                              ),
                            ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _lang2SelectedVal = val as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "שפה שניה",
                              labelStyle: TextStyle(color: Colors.purple,),
                              prefixIcon: Icon(
                                Icons.translate,
                                color: Colors.purple,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent)),
                              //border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField(
                            value: _languageList[0],
                            items: _languageList
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                textAlign: TextAlign.right,
                              ),
                            ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _lang1SelectedVal = val as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "שפת אם",
                              labelStyle: TextStyle(color: Colors.purple),
                              prefixIcon: Icon(
                                Icons.translate,
                                color: Colors.purple,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent)),
                              //border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RegTextField(textCtrl: employeeCtrl, icon: Icons.cases_rounded, hint: "תעסוקה", maxLines: 3,)
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: Text("שלב"),
            content: Center(
              child: Text("שלב 2"),
            )),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: Text("שלב"),
            content: Center(
              child: Text("שלב 3"),
            ))
      ];

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
          "הרשמה",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            _activeStepIndex += 1;
          }
          setState(() {});
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          _activeStepIndex -= 1;
          setState(() {});
        },
      ),
      // body: SafeArea(
      //   child: Center(
      //     child: Column(
      //       children: [
      //         const SizedBox(
      //           height: 25,
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 25),
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: Colors.grey[200],
      //               border: Border.all(color: Colors.white),
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //             child: TextField(
      //               controller: nameCtrl,
      //               textAlign: TextAlign.right,
      //               decoration: const InputDecoration(
      //                 suffixIcon: Icon(CupertinoIcons.person_circle_fill),
      //                 border: InputBorder.none,
      //                 hintText: "שם מלא",
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 25),
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: Colors.grey[200],
      //               border: Border.all(color: Colors.white),
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //             child: TextField(
      //               controller: emailCtrl,
      //               textAlign: TextAlign.right,
      //               decoration: const InputDecoration(
      //                 suffixIcon: Icon(CupertinoIcons.mail_solid),
      //                 border: InputBorder.none,
      //                 hintText: "אימייל",
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 25),
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: Colors.grey[200],
      //               border: Border.all(color: Colors.white),
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //             child: TextField(
      //               controller: phoneCtrl,
      //               textAlign: TextAlign.right,
      //               decoration: const InputDecoration(
      //                 suffixIcon: Icon(CupertinoIcons.phone_fill),
      //                 border: InputBorder.none,
      //                 hintText: "נייד",
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 25),
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: Colors.grey[200],
      //               border: Border.all(color: Colors.white),
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //             child: TextField(
      //               controller: passwordCtrl,
      //               textAlign: TextAlign.right,
      //               obscureText: true,
      //               decoration: const InputDecoration(
      //                 suffixIcon: Icon(CupertinoIcons.lock_fill),
      //                 border: InputBorder.none,
      //                 hintText: "סיסמא",
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         ElevatedButton(
      //           onPressed: () {signUp(nameCtrl.text, emailCtrl.text, phoneCtrl.text, passwordCtrl.text);},
      //           style: ElevatedButton.styleFrom(primary: Colors.purple),
      //           child: const Text(
      //             "רישום",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void signUp(String name, String email, String phone, String password) async {
    if (validate(name, email, phone, password)) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //final user = UserModel(id: _auth.currentUser.toString(), name: name, imageUrl: "");
        final user = {
          "id": _auth.currentUser?.uid.toString(),
          "name": name,
          "image_url": " "
        };
        db
            .collection("users")
            .doc(user["id"])
            .set(user)
            .onError((error, stackTrace) => errorMessage = error.toString());
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
    if (!RegExp(r"^.{3,}$").hasMatch(name)) {
      // Enter Valid name(Min. 3 Character)
      return false;
    }
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email) ||
        email.isEmpty) {
      // Please enter your email
      // Please enter valid email
      return false;
    }
    if (!RegExp(r"^[0-9]{10}$").hasMatch(phone)) {
      // Enter Valid phone(10 numbers)
      return false;
    }
    if (!RegExp(r"^.{6,}$").hasMatch(password) || password.isEmpty) {
      //"Enter Valid Password(Min. 6 Character)"
      //"Password is required for login"
      return false;
    }
    return true;
  }
}
