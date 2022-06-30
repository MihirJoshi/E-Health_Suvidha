import 'dart:async';
import 'package:e_suvidha/utils/app_themes.dart';
import 'package:e_suvidha/utils/routes.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 110.0),
              child: Center(
                child: Wrap(
                  spacing: 15.0,
                  runSpacing: 25.0,
                  children: <Widget>[
                    SizedBox(
                      width: 140.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 139, 176, 255),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MyRoutes.adddocRoute);
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/consult.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Add Doctor",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 139, 176, 255),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, MyRoutes.blood_home);
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/blood.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Apply Blood",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 139, 176, 255),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, MyRoutes.blood_home);
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/blood.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Donate Blood",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 139, 176, 255),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, MyRoutes.blood_home);
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/lab_texh.jpg',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Technician",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 139, 176, 255),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, MyRoutes.lab_home);
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/lab.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Pathology Lab",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 139, 176, 255),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/settings.png',
                                width: 64.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
