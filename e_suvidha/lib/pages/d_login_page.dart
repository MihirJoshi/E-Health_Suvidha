import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/models/doctor_model.dart';
import 'package:e_suvidha/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DLoginPage extends StatefulWidget {
  const DLoginPage({Key? key}) : super(key: key);

  @override
  State<DLoginPage> createState() => _DLoginPageState();
}

class _DLoginPageState extends State<DLoginPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key

  final _formKey = GlobalKey<FormState>();

  //editing controller

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // firebase connection
  bool _passwordVisible = true;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DoctorModel loggedInUser = DoctorModel();

  // string for displaying the error Message
  String? errorMessage;

  // Login Function

  static Future<User?> loginusingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    print(email);
    print(password);
    FirebaseAuth auth = FirebaseAuth.instance;
    User? doctor;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      doctor = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "No user Found with this Email Address");
      }
      if (e.code != password) {
        Fluttertoast.showToast(msg: "Password is not match");
      }
    }
    return doctor;
  }

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      User? doctor = await loginusingEmailPassword(
          email: _emailController.text,
          password: _passwordController.text,
          context: context);
      if (doctor != null) {
        try {
          print(doctor.uid);
          CollectionReference db =
              FirebaseFirestore.instance.collection('doctors');
          FirebaseFirestore.instance
              .collection('doctors')
              .doc(doctor.uid)
              .get()
              .then((value) {
            this.loggedInUser = DoctorModel.fromMap(value.data());
            if (loggedInUser.userType == "Doctor") {
              Fluttertoast.showToast(msg: "Login Successful");
              Navigator.pushNamed(context, MyRoutes.dhomeRoute);
            }
          });
        } on NoSuchMethodError catch (e) {
          Fluttertoast.showToast(msg: "Entered id is not a Doctor ID");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter your Email");
        }
        //reg expression for email
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter the valid Email");
        }
        return null;
      },
      onSaved: (value) {
        _emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    // password Field

    final passwordField = TextFormField(
      autofocus: false,
      controller: _passwordController,
      obscureText: _passwordVisible,
      autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');

        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        _passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    // Login Button

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn();
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                //autovalidate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 30, color: Colors.redAccent),
                          child: AnimatedTextKit(
                            repeatForever: false,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              RotateAnimatedText("Doctor Login",
                                  rotateOut: false)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/images/login_new.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Forgot Password ? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MyRoutes.pregisterRoute);
                          },
                          child: Text(
                            "Click Here",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
