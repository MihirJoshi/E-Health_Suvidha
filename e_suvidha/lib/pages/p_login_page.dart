import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/models/user_model.dart';
import 'package:e_suvidha/pages/Patient/p_home_screen.dart';
import 'package:e_suvidha/pages/main_page.dart';
import 'package:e_suvidha/pages/p_home_screen.dart';
//import 'package:e_suvidha/pages/p_register_page.dart';
import 'package:e_suvidha/utils/routes.dart';
import 'package:e_suvidha/widgets/patient_navigation_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:velocity_x/velocity_x.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PLoginPage extends StatefulWidget {
  const PLoginPage({Key? key}) : super(key: key);

  @override
  _PLoginPageState createState() => _PLoginPageState();
}

class _PLoginPageState extends State<PLoginPage> {
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
  UserModel loggedInUser = UserModel();

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
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "No user Found with this Email Address");
      }
      if (e.code != password) {
        Fluttertoast.showToast(msg: "Password is not match");
      }
    }
    return user;
  }

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      User? user = await loginusingEmailPassword(
          email: _emailController.text,
          password: _passwordController.text,
          context: context);
      if (user != null) {
        try {
          CollectionReference db =
              FirebaseFirestore.instance.collection('users');
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get()
              .then((value) {
            this.loggedInUser = UserModel.fromMap(value.data());
            print(loggedInUser);
            if (loggedInUser.userType != "Patient" && loggedInUser.uid == []) {
              Fluttertoast.showToast(msg: "Malpractice found");
            } else {
              Fluttertoast.showToast(msg: "Login Successful");
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PNavigationHomeScreen()));
            }
          });
        } on NoSuchMethodError catch (e) {
          Fluttertoast.showToast(msg: "Entered id is not a Patient ID");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //email Field

    final emailField = TextFormField(
      autofocus: false,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
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
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Main_Page())),
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
                autovalidateMode: AutovalidateMode.always,
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
                              RotateAnimatedText("Patient Login",
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
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.reset_pass);
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MyRoutes.pregisterRoute);
                          },
                          child: Text(
                            "SignUp",
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

//----------------------------------------------------------------------------------------------------------------------------------------
/* void signIn(String email, String password) async {
      if (_formKey.currentState!.validate()) {
        User? user;
        try {
          UserCredential userCredential = await _auth
              .signInWithEmailAndPassword(email: email, password: password);
          user = userCredential.user;
          if (user != null) {
            CollectionReference db =
                FirebaseFirestore.instance.collection('users');
            FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .get()
                .then((value) {
              this.loggedInUser = UserModel.fromMap(value.data());
              print(user);
            });
            if (loggedInUser == "Patient") {
              Fluttertoast.showToast(msg: "Login Successful");
              Navigator.pushNamed(context, MyRoutes.phomeRoute);
            }
          }
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
              errorMessage =
                  "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          Fluttertoast.showToast(msg: errorMessage!);
          print(error.code);
        }
      }
    } */
/*static Future<User?> loginusingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("no user found with this credential");
      }
    }
    return user;
  }

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      User? user = await loginusingEmailPassword(
          email: email,
          password: password,
          context: context);
      if (user != null && loggedInUser == "Patient") {
        CollectionReference db = FirebaseFirestore.instance.collection('users');
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get()
            .then((value) {
          this.loggedInUser = UserModel.fromMap(value.data());
        });

        if (loggedInUser.userType == "Patient") {
          Navigator.pushNamed(context, MyRoutes.phomeRoute);
        }
      }
    }
  }*/
