import 'package:flutter/material.dart';

class PHomeScreen extends StatefulWidget {
  const PHomeScreen({Key? key}) : super(key: key);

  @override
  _PHomeScreenState createState() => _PHomeScreenState();
}

class _PHomeScreenState extends State<PHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Panel"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Text("Welcome"),
              ),
              SizedBox(height: 10),
              Text(
                "Name",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              Text(
                "Email",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              ActionChip(label: Text("Logout"), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
