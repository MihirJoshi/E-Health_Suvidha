import 'package:e_suvidha/utils/routes.dart';
import 'package:flutter/material.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Welcome",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Text(
                "Welcome to E-Health Suvidha",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Image.asset(
                'assets/images/welcome.png',
                height: 200,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(280, 50),
                    primary: Colors.blue,
                    shape: StadiumBorder(
                        side: BorderSide(width: 1, color: Colors.blue)),
                  ),
                  child: Text('Admin Login'),
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.aloginRoute);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(280, 50),
                    primary: Colors.blue,
                    shape: StadiumBorder(
                        side: BorderSide(width: 1, color: Colors.blue)),
                  ),
                  child: Text('Doctor Login'),
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.dloginRoute);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(280, 50),
                    primary: Colors.blue,
                    shape: StadiumBorder(
                        side: BorderSide(width: 1, color: Colors.blue)),
                  ),
                  child: Text('Patient Login'),
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.ploginRoute);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
