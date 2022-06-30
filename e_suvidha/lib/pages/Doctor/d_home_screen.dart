import 'dart:async';
import 'package:e_suvidha/utils/app_themes.dart';
import 'package:e_suvidha/utils/routes.dart';
import 'package:flutter/material.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage>
    with TickerProviderStateMixin {
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
              padding: const EdgeInsets.only(top: 100.0, left: 105.0),
              child: Container(
                width: 150.0,
                height: 150.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                  child: Image.asset('assets/images/drawer_logo.png'),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 25.0)),
            Padding(
              padding: EdgeInsets.all(20.0),
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
                              Navigator.pushNamed(context, MyRoutes.d_consult);
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
                                  " Consultation",
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
                              Navigator.pushNamed(context, MyRoutes.add_time);
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/timer.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Add Timer",
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
