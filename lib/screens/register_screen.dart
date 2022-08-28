import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:dana_chat/models/clinic_model.dart';
//import 'package:dana_chat/models/doctor_model.dart';
import 'package:dana_chat/widgets/regWidgets/regWidgets.dart';
import 'package:dana_chat/models/residentialStatus.dart';
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

  late VoidCallback _onStepContinue;
  late VoidCallback _onStepCancel;

  final nameCtrl = TextEditingController();

  //final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  //final passwordCtrl = TextEditingController();
  final employeeCtrl = TextEditingController();

  final countryCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final zipCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  final caregiverNameCtrl = TextEditingController();
  final caregiverPhoneCtrl = TextEditingController();
  final caregiverEmailCtrl = TextEditingController();
  final caregiverRelationCtrl = TextEditingController();

  final exerciseDurationCtrl = TextEditingController();
  final exerciseFreqCtrl = TextEditingController();
  final exercisePowerCtrl = TextEditingController();
  final dietitianBMICtrl = TextEditingController();

  final fastDiabetesFromCtrl = TextEditingController();
  final fastDiabetesToCtrl = TextEditingController();
  final afterMealDiabetesFromCtrl = TextEditingController();
  final afterMealDiabetesToCtrl = TextEditingController();

  final medicationMorningCtrl = TextEditingController();
  final medicationNoonCtrl = TextEditingController();
  final medicationEveningCtrl = TextEditingController();
  final medicationNightCtrl = TextEditingController();

  final test1stCtrl = TextEditingController();
  final test2ndCtrl = TextEditingController();

  //final Clinic meir = Clinic("מאיר", 1);

  final _genderList = ["זכר", "נקבה"];
  String? _genderSelectedVal = "";
  final _educationList = ["ללא", "12 שנות לימוד", "תואר ראשון", "תואר שני"];
  String? _educationSelectedVal = "";
  final _languageList = ["עברית", "אנגלית", "רוסית", "ערבית", "ספרדית"];
  String? _lang1SelectedVal = "";
  String? _lang2SelectedVal = "";

  //final _clinicList = [Clinic("מאיר", 1), Clinic("איכילוב", 2), Clinic("העמק", 3)];
  final _clinics = {'מאיר': '1', 'איכילוב': '2', 'העמק': '3'};
  String? _clinicSelectedVal = "מאיר";
  final List _clinicList = [];

  //final _doctorList = [Doctor("רופא א'", 1), Doctor("רופא ב'", 1), Doctor("רופא ג'", 1), Doctor("רופא ד'", 2), Doctor("רופא ה'", 3)];
  final _doctors = {
    'אייל כהן': '1',
    'סיוון': '1',
    'יעל': '1',
    'שמעון': '2',
    'לירון': '3'
  };
  String? _doctorSelectedVal = "";
  final List _doctorList = [];

  //final List<dynamic> _doctorListUpdated = [Doctor("רופא א'", 1)];
  final _diseaseList = [
    "Diabetes",
    "Anthrax",
    "Brucellosis",
    "Congenital rubella",
    "Flu",
    "Giardiasis"
  ];
  String? _diseaseSelectedVal = "";
  final personalDiseases = {};
  final personalDiseasesKeyList = [];

  final _medicationList = [
    "Insulin",
    "Amylinomimetic",
    "Alpha-glucosidase",
    "Biguanides",
    "Dopamine agonist",
    "Meglitinides"
  ];
  String? _medicationSelectedVal = "";
  final personalMedications = {};
  final personalMedicationsKeyList = [];

  final _testList = [
    "Bicarbonate Test",
    "Bilirubin Test",
    "Insulin Test",
    "Globulin Test",
    "HBsAg Test",
    "Iron Test"
  ];
  String? _testSelectedVal = "";
  final personalTests = {};
  final personalTestsKeyList = [];

  @override
  void initState() {
    super.initState();
    clinicToList();
    //doctorToList();
  }

  DateTime? _birthDate;
  DateTime? _dietitianDate;
  DateTime? _diseaseDate;
  DateTime? _testDate;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  List<ResidentialStatus> residentialStatus = [
    ResidentialStatus("Value 1", "info info info", false),
    ResidentialStatus("Value 2", "info info info", false),
    ResidentialStatus("Value 3", "info info info", false),
    ResidentialStatus("Value 4", "info info info", false),
    //ResidentialStatus("Value 5", "info info info", false),
  ];
  List<ResidentialStatus> selectedStatus = [];

  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  int _activeStepIndex = 0;

  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text(""),
            content: Center(
              child: Column(
                children: [
                  RegTextField(
                    textCtrl: nameCtrl,
                    icon: CupertinoIcons.person_circle_fill,
                    hint: "שם מלא",
                  ),
                  const SizedBox(
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
                      const SizedBox(
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
                              labelStyle: TextStyle(
                                color: Colors.purple,
                              ),
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
                  const SizedBox(
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
                                _birthDate = date;
                              });
                            });
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.purple),
                          child: Text(
                            _birthDate == null
                                ? 'בחר תאריך לידה'
                                : formatter.format(_birthDate!),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                  const SizedBox(
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
                              labelStyle: TextStyle(
                                color: Colors.purple,
                              ),
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
                      const SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  RegTextField(
                    textCtrl: employeeCtrl,
                    icon: Icons.cases_rounded,
                    hint: "תעסוקה",
                    maxLines: 3,
                  )
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text(""),
            content: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RegTextField(
                          textCtrl: zipCtrl,
                          icon: Icons.numbers,
                          hint: "זיפ",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: cityCtrl,
                          icon: Icons.location_city,
                          hint: "עיר",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: countryCtrl,
                          icon: Icons.flag,
                          hint: "מדינה",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RegTextField(
                    textCtrl: addressCtrl,
                    icon: Icons.home,
                    hint: "כתובת",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: residentialStatus.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _residentialItem(
                            residentialStatus[index].title,
                            residentialStatus[index].info,
                            residentialStatus[index].isSelected,
                            index);
                      }),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text(""),
            content: Center(
              child: Column(
                children: [
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
                            value: _doctorSelectedVal,
                            onChanged: (val) {
                              setState(() {
                                //_doctorList.clear();
                                //doctorToList(_clinics[val]);
                                //debugPrint(_clinics[val]);
                                _doctorSelectedVal = val as String;
                              });
                            },
                            items: _doctorList.map((doctor) {
                              return DropdownMenuItem(
                                value: doctor,
                                child: Text(doctor, textAlign: TextAlign.right),
                              );
                            }).toList(),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "רופא",
                              labelStyle: TextStyle(
                                color: Colors.purple,
                              ),
                              prefixIcon: Icon(
                                Icons.healing,
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
                      const SizedBox(
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
                            value: _clinicSelectedVal,
                            onChanged: (val) {
                              setState(() {
                                _doctorList.clear();
                                doctorToList(_clinics[val]);
                                _clinicSelectedVal = val as String;
                              });
                            },
                            items: _clinicList.map((clinic) {
                              return DropdownMenuItem(
                                value: clinic,
                                child: Text(clinic, textAlign: TextAlign.right),
                              );
                            }).toList(),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "קליניקה",
                              labelStyle: TextStyle(color: Colors.purple),
                              prefixIcon: Icon(
                                Icons.local_hospital,
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("איש קשר"),
                  const SizedBox(
                    height: 20,
                  ),
                  RegTextField(
                    textCtrl: caregiverNameCtrl,
                    icon: CupertinoIcons.person_circle_fill,
                    hint: "שם מלא",
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RegTextField(
                    textCtrl: caregiverPhoneCtrl,
                    icon: CupertinoIcons.phone_fill,
                    hint: "נייד",
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RegTextField(
                    textCtrl: caregiverEmailCtrl,
                    icon: CupertinoIcons.mail_solid,
                    hint: "אימייל",
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RegTextField(
                    textCtrl: caregiverRelationCtrl,
                    icon: Icons.family_restroom,
                    hint: "קירבה",
                    inputType: TextInputType.name,
                  ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 3 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 3,
            title: const Text(""),
            content: Center(
              child: Column(
                children: [
                  const Text("פעילות גופנית - מומלצת"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RegTextField(
                          textCtrl: exercisePowerCtrl,
                          icon: Icons.sports_gymnastics,
                          hint: "עוצמה (1-3)",
                          inputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: exerciseFreqCtrl,
                          icon: Icons.timeline_sharp,
                          hint: "תדירות",
                          inputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: exerciseDurationCtrl,
                          icon: Icons.timer,
                          hint: "משך זמן",
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("תזונה - מומלצת"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2099))
                              .then((date) {
                            setState(() {
                              _dietitianDate = date;
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        child: Text(
                          _dietitianDate == null
                              ? 'ביקור אחרון'
                              : formatter.format(_dietitianDate!),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: dietitianBMICtrl,
                          icon: Icons.health_and_safety,
                          hint: "יעד BMI",
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("מחלות רקע"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2099))
                              .then((date) {
                            setState(() {
                              _diseaseDate = date;
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        child: Text(
                          _diseaseDate == null
                              ? 'תאריך אבחון'
                              : formatter.format(_diseaseDate!),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
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
                            value: _diseaseList[0],
                            items: _diseaseList
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
                                _diseaseSelectedVal = val as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "מחלת רקע",
                              labelStyle: TextStyle(color: Colors.purple),
                              prefixIcon: Icon(
                                Icons.medication_liquid,
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
                  const SizedBox(
                    height: 10,
                  ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addDiseaseToList(_diseaseSelectedVal,
                              formatter.format(_diseaseDate!));
                        });
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      child: const Text(
                        "הוסף מחלת רקע",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.purple[50],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        itemCount: personalDiseasesKeyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(personalDiseasesKeyList[index]),
                                Text(personalDiseases[
                                    personalDiseasesKeyList[index]]),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        removeDiseaseFromList(
                                            personalDiseasesKeyList[index]);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.grey,
                                      size: 15,
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 4 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 4,
            title: const Text(""),
            content: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("טווח סוכר בצום"),
                        Text("טווח סוכר אחרי ארוחה"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RegTextField(
                          textCtrl: fastDiabetesToCtrl,
                          icon: Icons.numbers,
                          hint: "עד",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: fastDiabetesFromCtrl,
                          icon: Icons.numbers,
                          hint: "מ",
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: afterMealDiabetesToCtrl,
                          icon: Icons.numbers,
                          hint: "עד",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RegTextField(
                          textCtrl: afterMealDiabetesFromCtrl,
                          icon: Icons.numbers,
                          hint: "מ",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("תרופות סכרת"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField(
                            value: _medicationList[0],
                            items: _medicationList
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
                                _medicationSelectedVal = val as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "תרופה",
                              labelStyle: TextStyle(color: Colors.purple),
                              prefixIcon: Icon(
                                Icons.medication_liquid,
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: medicationNightCtrl,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "לילה",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: medicationEveningCtrl,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "ערב",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: medicationNoonCtrl,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "צהריים",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: medicationMorningCtrl,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "בוקר",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        addMedicationToList(_medicationSelectedVal, medicationNightCtrl.text, medicationEveningCtrl.text, medicationNoonCtrl.text, medicationMorningCtrl.text);
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.purple),
                    child: const Text(
                      "הוסף תרופה",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      itemCount: personalMedicationsKeyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(personalMedicationsKeyList[index]),
                              Text(personalMedications[
                              personalMedicationsKeyList[index]]),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      removeMedicationFromList(
                                          personalMedicationsKeyList[index]);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.grey,
                                    size: 15,
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("בדיקות"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField(
                            value: _testList[0],
                            items: _testList
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
                                _testSelectedVal = val as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              //color: Colors.purple,
                            ),
                            dropdownColor: Colors.deepPurple.shade50,
                            decoration: const InputDecoration(
                              labelText: "בדיקה",
                              labelStyle: TextStyle(color: Colors.purple),
                              prefixIcon: Icon(
                                Icons.health_and_safety,
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: test2ndCtrl,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "ערך 2",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: test1stCtrl,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "ערך 1",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2099))
                              .then((date) {
                            setState(() {
                              _testDate = date;
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        child: Text(
                          _testDate == null
                              ? 'תאריך בדיקה'
                              : formatter.format(_testDate!),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        addTestToList(_testSelectedVal, test1stCtrl.text, test2ndCtrl.text, formatter.format(_testDate!));
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.purple),
                    child: const Text(
                      "הוסף בדיקה",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      itemCount: personalTestsKeyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(personalTestsKeyList[index]),
                              Text(personalTests[
                              personalTestsKeyList[index]]),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      removeDiseaseFromList(
                                          personalTestsKeyList[index]);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.grey,
                                    size: 15,
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ))
      ];

  // string for displaying the error Message
  String? errorMessage;

  Widget _residentialItem(
      String title, String info, bool isSelected, int index) {
    return ListTile(
      trailing: isSelected
          ? const Icon(
              Icons.check_circle,
              color: Colors.purple,
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w500),
          textAlign: TextAlign.right),
      subtitle: Text(info, textAlign: TextAlign.right),
      onTap: () {
        setState(() {
          residentialStatus[index].isSelected =
              !residentialStatus[index].isSelected;
          if (residentialStatus[index].isSelected == true) {
            selectedStatus.add(ResidentialStatus(title, info, true));
          } else if (residentialStatus[index].isSelected == false) {
            selectedStatus.removeWhere(
                (element) => element.title == selectedStatus[index].title);
          }
        });
      },
    );
  }

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
        controlsBuilder: (BuildContext context, ControlsDetails dtl) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: dtl.onStepContinue,
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  child: const Text(
                    'הבא',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: dtl.onStepCancel,
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  child: const Text(
                    'חזור',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
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

  // void updateDoctorList() {
  //   _doctorListUpdated.clear();
  //   for (Doctor doc in _doctorList) {
  //     if (doc.clinicCode.toString() == _clinicSelectedVal) {
  //       _doctorListUpdated.add(doc);
  //     }
  //   }
  // }

  void clinicToList() {
    _clinics.forEach((key, value) {
      _clinicList.add(key);
    });
    //_doctorList.add('1');
  }

  doctorToList(clinicCode) {
    _doctors.forEach((key, value) {
      debugPrint(clinicCode + " - " + value);
      if (clinicCode == value) {
        _doctorList.add(key);
      }
    });
    _doctorSelectedVal = _doctors[0];
  }

  void addDiseaseToList(name, date) {
    personalDiseases[name] = date;
    if (!personalDiseasesKeyList.contains(name)) {
      personalDiseasesKeyList.add(name);
    }
  }

  void removeDiseaseFromList(name) {
    personalDiseases.remove(name);
    personalDiseasesKeyList.remove(name);
  }

  void addMedicationToList(name, night, evening, noon, morning) {
    personalMedications[name] = [night, evening, noon, morning].toString();
    if (!personalMedicationsKeyList.contains(name)) {
      personalMedicationsKeyList.add(name);
    }
  }

  void removeMedicationFromList(name) {
    personalMedications.remove(name);
    personalMedicationsKeyList.remove(name);
  }

  void addTestToList(name, test1st, test2nd, date) {
    personalTests[name] = [test1st, test2nd, date].toString();
    if (!personalTestsKeyList.contains(name)) {
      personalTestsKeyList.add(name);
    }
  }

  void removeTestFromList(name) {
    personalTests.remove(name);
    personalTestsKeyList.remove(name);
  }

}
