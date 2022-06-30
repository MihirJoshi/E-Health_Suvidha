import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:e_suvidha/common/theme_helper.dart';
import 'package:e_suvidha/models/user_model.dart';
import 'package:e_suvidha/pages/Patient/common_issues_doctor.dart';
import 'package:e_suvidha/pages/Patient/lab_home.dart';
import 'package:e_suvidha/utils/themes.dart';
import 'package:e_suvidha/widgets/custom_button.dart';
import 'package:e_suvidha/widgets/patient_navigation_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/timer_header_widget.dart';

enum SingingCharacter { lafayette, jefferson }
int _groupValue = -1;

String? CheckEmail(String? value) {
  if (value!.isEmpty) {
    return ("Please Enter your Email");
  }
  //reg expression for email
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
    return ("Please Enter the valid Email");
  }
  return null;
}

String? CheckName(String? value) {
  if (value!.isEmpty) {
    return ("Please Enter the First Name");
  }
  return null;
}

String? CheckMobno(String? value) {
  RegExp regex = new RegExp(r'^[6-9]\d{9}$');
  if (value!.isEmpty) {
    return ("Please Enter the Mobile No.");
  }
  if (!regex.hasMatch(value)) {
    return ("Enter Valid Mobile Number");
  }
  return null;
}

String? CheckAge(String? value) {
  if (value!.isEmpty) {
    return ("Please Enter the Age");
  }
  return null;
}

String? CheckSymp(String? value) {
  if (value!.isEmpty) {
    return ("Please Enter the Symptoms");
  }
  return null;
}

class LabForm extends StatefulWidget {
  const LabForm({Key? key}) : super(key: key);

  @override
  State<LabForm> createState() => _LabFormState();
}

List<String> listItem = [
  "5:00-5:30",
  "5:30-6:00",
  "6:00-6:30",
  "6:30-7:00",
  "7:00-7:30",
  "7:30-8:00",
  "8:00-8:30",
  "8:30-9:00",
  "9:00-9:30",
  "9:30-10:00",
  "10:00-10:30",
  "10:30-11:00",
  "11:00-11:30",
  "11:30-12:00",
  "12:00-12:30",
  "12:30-13:00",
  "13:00-13:30",
  "13:30-14:00"
];
String? valueChoose = "5:00-5:30";
List<String> genderItem = ["Male", "Female", "Others"];
String? genderChoose = "Male";

class _LabFormState extends State<LabForm> {
  final _firestore = FirebaseFirestore.instance;
  String date = "";
  DateTime selectedDate = DateTime.now();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel patient = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.patient = UserModel.fromMap(value.data());

      setState(() {});
    });
    print(patient.uid);
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  TextEditingController _nameController = TextEditingController();

  TextEditingController _mobnoController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailCOntroller = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String lab_name = args['lab_name'];
    TextEditingController _labnameController =
        TextEditingController(text: "$lab_name");
    print(lab_name);

    // All Controllers related to form
    _dateController.text =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Lab",
          style: TextStyle(fontSize: 19.0, color: Colors.white),
        ),
        backgroundColor: MyThemes.navbar,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_sharp,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LabHome())),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: TimerHeaderWidget(100, true, " Book Lab "),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: ThemeHelper().textInputDecoration(
                              'Time', 'Choose Collect Time'),
                          value: valueChoose,
                          items: listItem
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => setState(() {
                            valueChoose = item;

                            print(item);
                          }),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField<String>(
                          decoration: ThemeHelper()
                              .textInputDecoration('Gender', 'Choose Gender'),
                          value: genderChoose,
                          items: genderItem
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => setState(() {
                            genderChoose = item;
                            print(item);
                          }),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper()
                                .textInputDecoration("Name", "Enter Name"),
                            keyboardType: TextInputType.name,
                            autovalidateMode: AutovalidateMode.always,
                            validator: CheckName,
                            controller: _nameController,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number", "Enter mobile number"),
                            keyboardType: TextInputType.phone,
                            autovalidateMode: AutovalidateMode.always,
                            validator: CheckMobno,
                            controller: _mobnoController,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            validator: CheckAge,
                            controller: _ageController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            decoration: ThemeHelper()
                                .textInputDecoration('Age', 'Enter Age'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _emailCOntroller,
                            //validator: CheckDegree,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            validator: CheckEmail,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration: ThemeHelper()
                                .textInputDecoration('Email', 'Enter Email'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            //validator: CheckIssue,
                            controller: _pinController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.number,
                            autofocus: false,

                            decoration: ThemeHelper().textInputDecoration(
                                'Pin Code', 'Enter Pin Code'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            validator: CheckSymp,
                            controller: _addressController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.multiline,
                            autofocus: false,
                            decoration: ThemeHelper().textInputDecoration(
                                'Address', 'Enter Address'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper()
                                .textInputDecoration("Name", "Enter Lab Name"),
                            keyboardType: TextInputType.name,
                            autovalidateMode: AutovalidateMode.always,
                            validator: CheckName,
                            controller: _labnameController,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: ThemeHelper().textInputDecoration(
                              'Select Date', 'Click here to select date'),
                          readOnly: true,
                          controller: _dateController,
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthButton(
                          onTap: () {
                            _firestore.collection('lab_tests').add({
                              'p_name': _nameController.text,
                              'p_age': _ageController.text,
                              'p_mobno': _mobnoController.text,
                              'p_email': _emailCOntroller.text,
                              'p_gender': genderChoose,
                              'p_issue': _pinController.text,
                              'p_symp': _addressController.text,
                              'p_time': valueChoose,
                              'p_date': _dateController.text,
                              'lab_type': _labnameController.text,
                              "patient_id": patient.uid,
                            });
                            Fluttertoast.showToast(msg: "Added !!!!!!! ");
                          },
                          text: 'Submit',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}
