import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:e_suvidha/common/theme_helper.dart';
import 'package:e_suvidha/models/user_model.dart';
import 'package:e_suvidha/pages/Patient/blood_home.dart';
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

String? CheckPin(String? value) {
  RegExp regex = new RegExp(r'^[1-9]{1}[0-9]{2}\\s{0, 1}[0-9]{3}$');
  if (value!.isEmpty) {
    return ("Please Enter the Pin Code.");
  }
  if (!regex.hasMatch(value)) {
    return ("Enter Valid Pin Code");
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

class DonateBlood extends StatefulWidget {
  const DonateBlood({Key? key}) : super(key: key);

  @override
  State<DonateBlood> createState() => _DonateBloodState();
}

List<String> listItem = [
  "Sanjeevani Blood Bank Centre, Kopargaon",
  "Reynolds Memorial Hospital, Washim",
  "Swa. Tukaramji Kanade Memorial Blood Bank, Ahmednagar",
  "Dr. Lokhande Blood Bank, Akola",
  "Dr. Hedgewar Rakta Pedhi Blood Bank, Akola",
  "Desai Blood Bank, Khar",
  "Holy Spirit Hospital, Mumbai",
  "	L.T.M.G., Municipal Hospital, Sion",
  "	Govt. Medical College, Nagpur",
  "Mure Memorial Hospital, Nagpur",
  "	M/s Nanded, Nanded",
  "Jankalyan Rakta Pedhi Blood Bank, Nandurbar",
  "Civil Hospital, Nasik",
  "NDMVPS Hospital, Nasik",
  "Sankalp Blood Bank, Kalyan",
  "Arpan Blood Bank, Kalyan",
  "Terna Blood Bank, Nerul",
  "Navi Mumbai Municipal Corporation, NaviMumbai"
];
String? valueChoose = "Sanjeevani Blood Bank Centre, Kopargaon";

List<String> genderItem = ["Male", "Female", "Others"];
String? genderChoose = "Male";

List<String> sympItem = [
  "Cardiac Arrest",
  "Hypertension",
  "Blood Pressure",
  "Cancer",
  "Epilepsy",
  "Kidney ailments",
  "Diabetes",
  "None of Above"
];
String? sympChoose = "Cardiac Arrest";

List<String> groupItem = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
String? groupChoose = "A+";

List<String> hivItem = [
  "Yes",
  "No",
];
String? hivChoose = "Yes";

List<String> immuneItem = [
  "Yes",
  "No",
];
String? immuneChoose = "Yes";

List<String> alcoholItem = [
  "Yes",
  "No",
];
String? alcoholChoose = "Yes";

class _DonateBloodState extends State<DonateBlood> {
  final _firestore = FirebaseFirestore.instance;
  String date = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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

  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobnoController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailCOntroller = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _monthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    _timeController.text =
        "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} ${selectedTime.period.toString().split('.')[1]}";
    // All Controllers related to form
    _dateController.text =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blood Donation Form",
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
              MaterialPageRoute(builder: (context) => BloodHome())),
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
                              'Blood Bank Center', 'Choose Blood Bank Center'),
                          value: valueChoose,
                          isExpanded: true,
                          items: listItem
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.visible,
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
                          decoration: ThemeHelper().textInputDecoration(
                              'Symptomes', 'Choose Symptomes'),
                          value: sympChoose,
                          items: sympItem
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => setState(() {
                            sympChoose = item;

                            print(item);
                          }),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField<String>(
                          decoration: ThemeHelper().textInputDecoration(
                              'Hiv Positive', 'Choose Options'),
                          value: hivChoose,
                          items: hivItem
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => setState(() {
                            hivChoose = item;

                            print(item);
                          }),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField<String>(
                          decoration: ThemeHelper().textInputDecoration(
                              'Consumed Alcohol', 'Choose Options'),
                          value: alcoholChoose,
                          items: alcoholItem
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => setState(() {
                            alcoholChoose = item;

                            print(item);
                          }),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField<String>(
                          decoration: ThemeHelper().textInputDecoration(
                              'Undergone immunization in past 1 Months',
                              'Choose Options'),
                          value: immuneChoose,
                          items: immuneItem
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => setState(() {
                            immuneChoose = item;

                            print(item);
                          }),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField<String>(
                          decoration: ThemeHelper().textInputDecoration(
                              'Blood Group', 'Choose Blood Group'),
                          value: groupChoose,
                          items: groupItem
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => setState(() {
                            groupChoose = item;

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
                            //validator: CheckPin,
                            decoration: ThemeHelper().textInputDecoration(
                                'Pin Code', 'Enter Pin Code'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            //validator: CheckAge,
                            controller: _monthController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Blood Donation',
                                'Enter Last Blood Donation (In Months)'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            //validator: CheckIssue,
                            controller: _weightController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.number,
                            autofocus: false,

                            decoration: ThemeHelper().textInputDecoration(
                                'Weight', 'Enter Weight in KG'),
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
                        TextFormField(
                          decoration: ThemeHelper().textInputDecoration(
                              'Select Time', 'Click here to Select Time'),
                          readOnly: true,
                          controller: _timeController,
                          onTap: () {
                            _selectTime(context);
                            print(_timeController);
                          },
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
                            _firestore.collection('donate_blood').add({
                              'name': _nameController.text,
                              'age': _ageController.text,
                              'mobno': _mobnoController.text,
                              'email': _emailCOntroller.text,
                              'gender': genderChoose,
                              'pin_code': _pinController.text,
                              'address': _addressController.text,
                              'blood_bank': valueChoose,
                              'request': sympChoose,
                              'hiv': hivChoose,
                              'immune': immuneChoose,
                              'alcohol': alcoholChoose,
                              'last_donate': _monthController.text,
                              'date': _dateController.text,
                              'time': _timeController.text,
                              'weight': _weightController.text,
                              'blood_group': groupChoose,
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

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        print(timeOfDay);
      });
    }
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
