import 'package:flutter/material.dart';

class AHomeScreen extends StatefulWidget {
  const AHomeScreen({Key? key}) : super(key: key);

  @override
  State<AHomeScreen> createState() => _AHomeScreenState();
}

class _AHomeScreenState extends State<AHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("E-Health Suvidha"),
        centerTitle: true,
      ),
    );
  }
}
