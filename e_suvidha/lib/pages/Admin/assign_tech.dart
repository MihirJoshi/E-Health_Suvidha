// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/models/doctor_model.dart';
import 'package:e_suvidha/pages/Patient/show_lab_history.dart';
import 'package:e_suvidha/widgets/doctor_navigation_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String t_name = "";
var techGlobal;
var p_id;
var p_name;
var p_age;
var p_gender;
var p_email;
var p_mobno;
var p_issue;
var p_symp;
var p_date;
var p_time;
var p_lab_type;
var tech_name;
var tech_age;
var tech_gender;
var tech_email;
var tech_mobno;
var tech_degree;
var docVal;
var check_data;

class AssignTech extends StatefulWidget {
  const AssignTech({Key? key}) : super(key: key);

  @override
  State<AssignTech> createState() => _AssignTechState();
}

class _AssignTechState extends State<AssignTech> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    docVal = args['docVal'];
    print(docVal['lab_type']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Technician Lists"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Text(
                      'Technician List',
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('lab_techs')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Text("No Value");
                    }
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    ;

                    return ListView(
                        children: documents
                            .map((tech) => demoTopRatedDr(
                                  techGlobal = tech,
                                  tech['t_name'],
                                  tech['t_age'],
                                  tech['t_mobno'],
                                  tech['t_email'],
                                  tech['t_degree'],
                                  tech['t_gender'],
                                ))
                            .toList());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget demoTopRatedDr(
    var tech,
    t_name,
    String t_age,
    String t_mobno,
    String t_email,
    String t_degree,
    String t_gender,
  ) {
    var size = MediaQuery.of(context).size;
    var tech_name = techGlobal['t_name'];
    var tech_age = techGlobal['t_age'];
    var tech_mobno = techGlobal['t_mobno'];
    var tech_email = techGlobal['t_email'];
    var tech_degree = techGlobal['t_degree'];
    var tech_gender = techGlobal['t_gender'];
    p_id = docVal['patient_id'];
    print("Main ID: $p_id");
    print(techGlobal['t_name']);
    print(docVal['patient_id']);
    return GestureDetector(
      onTap: () => alertDialog(context, tech_name, tech_age, tech_email,
          tech_mobno, tech_gender, tech_degree),
      child: Container(
        height: 160,
        // width: size.width,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 130,
              width: 60,
              child: Image.asset(
                "assets/images/person.png",
                errorBuilder: ((context, error, stackTrace) {
                  return Text("My Image");
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Name: $t_name",
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Gender: $t_gender",
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Text(
                          "Degree: $t_degree",
                          style: TextStyle(
                            color: Color(0xffababab),
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Container(
                    margin: EdgeInsets.only(left: 130, top: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            docname,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/

                  /*Container(
                    margin: EdgeInsets.only(top: 10),
                    child: InkWell(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Text("Mihir Joshi");
                            },
                            child: Text(
                              "Know More",
                              style: TextStyle(
                                color: Color(0xffababab),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void alertDialog(BuildContext context, tech_name, tech_age, tech_email,
      tech_mobno, tech_degree, tech_gender) {
    var alert = AlertDialog(
      title: Text('Assign Technician.'),
      content: Text("Are You Sure Want To assign $tech_name?"),
      actions: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Padding(padding: EdgeInsets.only(left: 55.0)),
            FlatButton(
              child: Text(
                "Assign",
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                //Put your code here which you want to execute on Yes button click.
                _firestore.collection('assign_tech').add({
                  'tech_name': tech_name,
                  'tech_age': tech_age,
                  'tech_email': tech_email,
                  'tech_degree': tech_gender,
                  'tech_mobno': tech_mobno,
                  'tech_gender': tech_gender,
                  'p_t_id': docVal['patient_id'],
                  'p_t_name': docVal['p_name'],
                  'p_t_age': docVal['p_age'],
                  'p_t_mobno': docVal['p_mobno'],
                  'p_t_email': docVal['p_email'],
                  'p_t_gender': docVal['p_gender'],
                  'p_t_issue': docVal['p_issue'],
                  'p_t_symp': docVal['p_symp'],
                  'p_t_time': docVal['p_time'],
                  'p_t_date': docVal['p_date'],
                  'p_t_lab_type': docVal['lab_type'],
                });
                Navigator.pushNamed(context, '/show_assign_tech', arguments: {
                  'techGlobal': techGlobal,
                  'docVal': docVal,
                });
                print(docVal['p_age']);
              },
            ),
            FlatButton(
              child: Text(
                "Show",
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () async {
                //Put your code here which you want to execute on Cancel button click.
                var collection = FirebaseFirestore.instance
                    .collection('assign_tech')
                    .where('p_t_id', isEqualTo: p_id);
                var querySnapshot = await collection.get();
                for (var queryDocumentSnapshot in querySnapshot.docs) {
                  Map<String, dynamic> data = queryDocumentSnapshot.data();
                  check_data = data['p_t_id'];
                }
                if (check_data == p_id) {
                  var collection = FirebaseFirestore.instance
                      .collection('assign_tech')
                      .where('p_t_id', isEqualTo: p_id);
                  var querySnapshot = await collection.get();
                  for (var queryDocumentSnapshot in querySnapshot.docs) {
                    Map<String, dynamic> data = queryDocumentSnapshot.data();
                    var p_name = data['p_t_name'];
                    var p_age = data['p_t_age'];
                    var p_email = data['p_t_email'];
                    var p_mobno = data['p_t_mobno'];
                    var p_gender = data['p_t_gender'];
                    var p_issue = data['p_t_issue'];
                    var p_symp = data['p_t_symp'];
                    var p_lab_type = data['p_t_lab_type'];
                    var p_date = data['p_t_date'];
                    var p_time = data['p_t_time'];
                    var tech_name = data['tech_name'];
                    var tech_age = data['tech_age'];
                    var tech_email = data['tech_email'];
                    var tech_mobno = data['tech_mobno'];
                    var tech_gender = data['tech_gender'];
                    var tech_degree = data['tech_degree'];
                    print("Tapped!!11$tech_name");
                    Navigator.pushNamed(context, '/show_patient_tech',
                        arguments: {
                          'p_name': p_name,
                          'p_age': p_age,
                          'p_email': p_email,
                          'p_mobno': p_mobno,
                          'p_gender': p_gender,
                          'p_issue': p_issue,
                          'p_symp': p_symp,
                          'p_date': p_date,
                          'p_time': p_time,
                          'p_lab_type': p_lab_type,
                          'tech_name': tech_name,
                          'tech_age': tech_age,
                          'tech_gender': tech_gender,
                          'tech_email': tech_email,
                          'tech_mobno': tech_mobno,
                          'tech_degree': tech_degree,
                        });
                  }
                } else {
                  Fluttertoast.showToast(msg: "Technician Not Assigned yet !!");
                }
              },
            ),
            FlatButton(
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                //Put your code here which you want to execute on Cancel button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
