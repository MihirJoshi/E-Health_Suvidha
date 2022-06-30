import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:e_suvidha/common/theme_helper.dart';
import 'package:e_suvidha/models/user_model.dart';
import 'package:e_suvidha/pages/Patient/common_issues_doctor.dart';
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

class ConsultForm extends StatefulWidget {
  const ConsultForm({Key? key}) : super(key: key);

  @override
  State<ConsultForm> createState() => _ConsultFormState();
}

List<String> listItem = [timer1, timer2, timer3];
String? valueChoose = timer1;
List<String> genderItem = ["Male", "Female", "Others"];
String? genderChoose = "Male";

String name = "";
String speciality = "";
String degree = "";
String timer1 = "";
String timer2 = "";
String timer3 = "";
String timer4 = "";
String timer5 = "";
String docimg = "";
String docmobno = "";

class _ConsultFormState extends State<ConsultForm> {
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
  TextEditingController _issueController =
      TextEditingController(text: "Common Issues");
  TextEditingController _sympController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String id = args['uid'];
    docimg = args['img'];
    docmobno = args['mobno'];
    name = args['name'];
    speciality = args['speciality'];
    degree = args['degree'];
    timer1 = args['t1'];
    timer2 = args['t2'];
    timer3 = args['t3'];
    timer4 = args['t4'];
    timer5 = args['t5'];
    print(id);

    //doctor uid
    var docid = id;

    TextEditingController _docnameController =
        TextEditingController(text: "$name");
    TextEditingController _docdegreeController =
        TextEditingController(text: "$degree");
    TextEditingController _docspecialController =
        TextEditingController(text: "$speciality");

    // All Controllers related to form
    _dateController.text =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doctor Consultation Form",
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
              MaterialPageRoute(builder: (context) => CommonDocotrPage())),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: TimerHeaderWidget(100, false, " Doctor Conslutation "),
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
                        Container(
                          child: TextFormField(
                            controller: _docnameController,
                            //validator: CheckUsername,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            readOnly: true,
                            decoration: ThemeHelper()
                                .textInputDecoration('Name', 'Doctor Name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: _docspecialController,
                            readOnly: true,
                            //validator: CheckName,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            decoration: ThemeHelper().textInputDecoration(
                                'Specialization', 'Doctor Specialization'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            keyboardType: TextInputType.name,
                            readOnly: true,
                            controller: _docdegreeController,
                            //validator: CheckLast,
                            autovalidateMode: AutovalidateMode.always,
                            textInputAction: TextInputAction.next,
                            decoration: ThemeHelper()
                                .textInputDecoration('Degree', 'Doctor Degree'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField<String>(
                          decoration: ThemeHelper().textInputDecoration(
                              'Time', 'Choose Consult Time'),
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
                            decoration: ThemeHelper().textInputDecoration(
                                "Name", "Enter Patient Name"),
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
                                "Mobile Number", "Enter Patient mobile number"),
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
                            decoration: ThemeHelper().textInputDecoration(
                                'Age', 'Enter Patient Age'),
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
                            decoration: ThemeHelper().textInputDecoration(
                                'Email', 'Enter Patient Email'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            //validator: CheckIssue,
                            controller: _issueController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            readOnly: true,
                            decoration: ThemeHelper()
                                .textInputDecoration('Issue', 'Common Issues'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            validator: CheckSymp,
                            controller: _sympController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: ThemeHelper().textInputDecoration(
                                'Symptomes', 'Enter Symptomes'),
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
                            _firestore.collection('consultations').add({
                              'docname': _docnameController.text,
                              'docdegree': _docdegreeController.text,
                              'docspecial': _docspecialController.text,
                              'p_name': _nameController.text,
                              'p_age': _ageController.text,
                              'p_mobno': _mobnoController.text,
                              'p_email': _emailCOntroller.text,
                              'p_gender': genderChoose,
                              'p_issue': _issueController.text,
                              'p_symp': _sympController.text,
                              'p_time': valueChoose,
                              'p_date': _dateController.text,
                              "docid": docid,
                              "patient_id": patient.uid,
                              "docimgUrl": docimg,
                              "docmobno": docmobno
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
