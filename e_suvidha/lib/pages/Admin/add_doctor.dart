// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_suvidha/common/theme_helper.dart';
import 'package:e_suvidha/widgets/custom_button.dart';
//import 'package:e_suvidha/widgets/custom_formfield.dart';
import 'package:e_suvidha/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  File? _imageFile;
  bool? isLoading;
  final ImagePicker _picker = ImagePicker();

  // Image Picker
  ImagePicker image = ImagePicker();
  String url = "";

  final _usernameController = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _mobno = TextEditingController();
  final _degree = TextEditingController();
  final _exp = TextEditingController();
  final _gender = TextEditingController();
  final _special = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _passwordVisible = true;

  String get email => _emailController.text.trim();

  String get password => _passwordController.text.trim();

  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // All Validators

  String? CheckPass(String? fieldContent) {
    RegExp regex = new RegExp(r'^.{6,}$');

    if (fieldContent!.isEmpty) {
      return ("Password is required for login");
    }
    if (!regex.hasMatch(fieldContent)) {
      return ("Enter Valid Password(Min. 6 Character)");
    }
    return null;
  }

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

  String? CheckUsername(String? value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return ("Please Enter your Username");
    } else {
      if (!regex.hasMatch(value))
        return ("Enter Valid Password(Min. 6 Character)");
    }
    return null;
  }

  String? CheckFirst(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter the First Name");
    }
    return null;
  }

  String? CheckLast(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter the Last Name");
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

  String? CheckDegree(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter the Degree");
    }
    return null;
  }

  String? CheckGender(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter the Gender");
    }
    return null;
  }

  String? CheckSpecial(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter the Specialization");
    }
    return null;
  }

  String? CheckExp(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter the Experience");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
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
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 0.5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      //blurRadius: 20,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 60.0,
                                        backgroundImage: _imageFile == null
                                            ? AssetImage(
                                                "assets/images/camera.jpg")
                                            : FileImage(File(_imageFile!.path))
                                                as ImageProvider,
                                      ),
                                    ),
                                    Positioned(
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) =>
                                                bottomSheet()),
                                          );
                                        },
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.teal,
                                          size: 28.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _usernameController,
                            validator: CheckUsername,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            decoration: ThemeHelper().textInputDecoration(
                                'Username', 'Enter Username'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: _firstname,
                            validator: CheckFirst,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            decoration: ThemeHelper().textInputDecoration(
                                'First Name', 'Enter your first name'),
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
                            controller: _lastname,
                            validator: CheckLast,
                            autovalidateMode: AutovalidateMode.always,
                            textInputAction: TextInputAction.next,
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Name', 'Enter your last name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.always,
                            validator: CheckEmail,
                            controller: _emailController,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number", "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            autovalidateMode: AutovalidateMode.always,
                            validator: CheckMobno,
                            controller: _mobno,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            validator: CheckGender,
                            controller: _gender,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            autofocus: false,
                            keyboardType: TextInputType.name,
                            decoration: ThemeHelper()
                                .textInputDecoration('Gender', 'Enter Gender'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _degree,
                            validator: CheckDegree,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            decoration: ThemeHelper()
                                .textInputDecoration('Degree', 'Enter Degree'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _special,
                            validator: CheckSpecial,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            decoration: ThemeHelper().textInputDecoration(
                                'Specialization', 'Enter Specialization'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            validator: CheckExp,
                            controller: _exp,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            decoration: ThemeHelper().textInputDecoration(
                                'Experience', 'Enter Experience'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            autovalidateMode: AutovalidateMode.always,
                            validator: CheckPass,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthButton(
                          onTap: () {
                            uploadFile(_emailController.text,
                                _passwordController.text);
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

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text("Choose Profile Image", style: TextStyle(fontSize: 20.0)),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final img = await image.getImage(source: source);
    setState(() {
      _imageFile = File(img!.path);
    });
  }

  //Upload Image on Firbase Storage

  void uploadFile(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirbase()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
        print(error.code);
      }
    }
  }

  postDetailsToFirbase() async {
    // calling firestore
    // calling doctor model
    // sending the values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? doctor = _auth.currentUser;

    DoctorModel doctorModel = DoctorModel();

    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference imageFile =
        FirebaseStorage.instance.ref().child('images').child('users$imgId');
    UploadTask task = imageFile.putFile(_imageFile!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    // writing all values

    doctorModel.email = doctor!.email;
    doctorModel.uid = doctor.uid;
    doctorModel.username = _usernameController.text;
    doctorModel.first = _firstname.text;
    doctorModel.last = _lastname.text;
    doctorModel.gender = _gender.text;
    doctorModel.mobno = _mobno.text;
    doctorModel.degree = _degree.text;
    doctorModel.exp = _exp.text;
    doctorModel.special = _special.text;
    doctorModel.imageUrl = url;
    doctorModel.t1 = " ";
    doctorModel.t2 = " ";
    doctorModel.t3 = " ";
    doctorModel.t4 = " ";
    doctorModel.t5 = " ";
    doctorModel.userType = "Doctor";

    // for downloading url of image

    await FirebaseFirestore.instance
        .collection("doctors")
        .doc(doctor.uid)
        .set(doctorModel.toMap());
    print(url);
    Fluttertoast.showToast(msg: "Doctor Added Successfully!!!");
  }

  void _resetform() {
    _formKey.currentState?.reset();
  }
}
