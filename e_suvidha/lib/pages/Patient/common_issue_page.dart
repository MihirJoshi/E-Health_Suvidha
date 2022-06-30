import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/common/data.dart';
import 'package:e_suvidha/models/doctor_model.dart';
import 'package:e_suvidha/models/user_model.dart';
import 'package:e_suvidha/pages/Patient/common_issues_doctor.dart';
import 'package:e_suvidha/pages/Patient/women_page.dart';
import 'package:e_suvidha/widgets/patient_navigation_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../utils/routes.dart';

class CommonPage extends StatefulWidget {
  const CommonPage({Key? key}) : super(key: key);

  @override
  State<CommonPage> createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  Material MyItems(String img, String heading, int color, int color1) {
    return Material(
      color: Colors.white,
      elevation: 10.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        img,
                        width: 20.0,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        heading,
                        style:
                            TextStyle(color: new Color(color1), fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Common Symptomes"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommonDocotrPage()));
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          MyItems("assets/symptoms/fever.png", "Fever", 0xFF00B0FF, 0xFF000000),
          MyItems("assets/symptoms/gas.png", "Gas", 0xFF00B0FF, 0xFF000000),
          MyItems("assets/symptoms/cough.png", "Cough", 0xFF00B0FF, 0xFF000000),
          MyItems("assets/symptoms/runny.png", "Runny Nose", 0xFF00B0FF,
              0xFF000000),
          MyItems("assets/symptoms/headech.png", "Headache", 0xFF00B0FF,
              0xFF000000),
          MyItems("assets/symptoms/pain.png", "Abdominal Pain ", 0xFF00B0FF,
              0xFF000000),
          MyItems("assets/symptoms/throat_pain.png", "Throat Pain", 0xFF00B0FF,
              0xFF000000),
          MyItems("assets/symptoms/vomating.png", "Vomating", 0xFF00B0FF,
              0xFF000000),
          MyItems(
              "assets/symptoms/obasity.png", "Obasity", 0xFF00B0FF, 0xFF000000),
          MyItems("assets/symptoms/rapid.png", "Rapid Breathing", 0xFF00B0FF,
              0xFF000000),
          MyItems(
              "assets/symptoms/lowbp.png", "Low BP", 0xFF00B0FF, 0xFF000000),
          MyItems(
              "assets/symptoms/lowbp.png", "High BP", 0xFF00B0FF, 0xFF000000),
          MyItems("assets/symptoms/skin_spots.png", "Skin Spots", 0xFF00B0FF,
              0xFF000000),
          MyItems("assets/symptoms/rash.png", "Rash", 0xFF00B0FF, 0xFF000000),
          /*MyItems("assets/symptoms/skin_spots.png", "Skin Spots", 0xFF00B0FF,
              0xFF000000),
          MyItems("assets/symptoms/dark_circle.png", "Dark Circles", 0xFF00B0FF,
              0xFF000000),
          MyItems("assets/symptoms/weight_loss.png", "Weight Loss", 0xFF00B0FF,
              0xFF000000),
          MyItems("assets/symptoms/rash.png", "Rash", 0xFF00B0FF, 0xFF000000),
          MyItems(
              "assets/symptoms/itching.png", "Itching", 0xFF00B0FF, 0xFF000000),
          MyItems("assets/symptoms/diper.png", "Diaper Rash", 0xFF00B0FF,
              0xFF000000),
          MyItems(
              "assets/symptoms/nausea.png", "Nausea", 0xFF00B0FF, 0xFF000000),*/
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          /*StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),
          StaggeredTile.extent(1, 90.0),*/
        ],
      ),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Next'),
    );
  }

  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Previous'),
    );
  }
}
