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

String? CheckDegree(String? value) {
  if (value!.isEmpty) {
    return ("Please Enter the Degree");
  }
  return null;
}

class AddTech extends StatefulWidget {
  const AddTech({Key? key}) : super(key: key);

  @override
  State<AddTech> createState() => _AddTechState();
}

List<String> genderItem = ["Male", "Female", "Others"];
String? genderChoose = "Male";

class _AddTechState extends State<AddTech> {
  final _firestore = FirebaseFirestore.instance;
  String date = "";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobnoController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailCOntroller = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // All Controllers related to form
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Technicians",
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
              child: TimerHeaderWidget(100, true, " Add Technicians "),
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
                            validator: CheckDegree,
                            controller: _degreeController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            decoration: ThemeHelper()
                                .textInputDecoration('Degree', 'Enter Degree'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthButton(
                          onTap: () {
                            _firestore.collection('lab_techs').add({
                              't_name': _nameController.text,
                              't_age': _ageController.text,
                              't_mobno': _mobnoController.text,
                              't_email': _emailCOntroller.text,
                              't_gender': genderChoose,
                              't_degree': _degreeController.text,
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
}
