import 'package:e_suvidha/widgets/navigation_drawer_widget.dart';
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
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("E-Health Suvidha"),
        centerTitle: true,
      ),
    );
  }
}
