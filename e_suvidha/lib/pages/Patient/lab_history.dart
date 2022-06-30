import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/models/doctor_model.dart';
import 'package:e_suvidha/models/user_model.dart';
import 'package:e_suvidha/widgets/doctor_navigation_widget.dart';
import 'package:e_suvidha/widgets/patient_navigation_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var p_id;
var check_data;

class LabHistory extends StatefulWidget {
  const LabHistory({Key? key}) : super(key: key);

  @override
  State<LabHistory> createState() => _LabHistoryState();
}

class _LabHistoryState extends State<LabHistory> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel patient = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.patient = UserModel.fromMap(value.data());

      setState(() {});
    });
    print(patient.firstname);
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab History"),
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
                      'Lab History',
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
                      .collection('lab_tests')
                      .where('patient_id', isEqualTo: patient.uid)
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
                            .map((doc) => demoTopRatedDr(
                                  doc['lab_type'],
                                  doc['p_name'],
                                  doc['p_gender'],
                                  doc['p_age'],
                                  doc['p_email'],
                                  doc['p_issue'],
                                  doc['p_mobno'],
                                  doc['p_date'],
                                  doc['p_time'],
                                  doc['p_symp'],
                                  doc['patient_id'],
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
    String lab_type,
    String p_name,
    String p_gender,
    String p_age,
    String p_email,
    String p_issue,
    String p_mobno,
    String p_date,
    String p_time,
    String p_symp,
    String patient_id,
  ) {
    var size = MediaQuery.of(context).size;
    p_id = patient_id;
    print("Tapped............$p_id");
    return GestureDetector(
      onTap: () async {
        var collection = FirebaseFirestore.instance
            .collection('assign_tech')
            .where('p_t_id', isEqualTo: p_id);
        var querySnapshot = await collection.get();
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          check_data = data['p_t_id'];
        }
        if (check_data == patient_id) {
          print("Enter!!!!!");
          var collection = FirebaseFirestore.instance
              .collection('assign_tech')
              .where('p_t_id', isEqualTo: p_id);
          var querySnapshot = await collection.get();
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            var tech_name = data['tech_name'];
            var tech_age = data['tech_age'];
            var tech_email = data['tech_email'];
            var tech_gender = data['tech_gender'];
            var tech_mobno = data['tech_mobno'];
            var tech_degree = data['tech_degree'];

            Navigator.pushNamed(context, '/show_lab_history', arguments: {
              'patient_id': patient_id,
              'lab_type': lab_type,
              'p_name': p_name,
              'p_age': p_age,
              'p_email': p_email,
              'p_gender': p_gender,
              'p_mobno': p_mobno,
              'p_issue': p_issue,
              'p_date': p_date,
              'p_time': p_time,
              'p_symp': p_symp,
              'tech_name': tech_name,
              'tech_age': tech_age,
              'tech_gender': tech_gender,
              'tech_email': tech_email,
              'tech_mobno': tech_mobno,
              'tech_degree': tech_degree,
            });
          }
        } else {
          print("Else Enter !!");
          Fluttertoast.showToast(msg: "Technician not assigned yet !!");
        }
      },
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
                      "Patient: $p_name",
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
                      "Gender: $p_gender",
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
                          p_date,
                          style: TextStyle(
                            color: Color(0xffababab),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 105)),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Text(
                          p_time,
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
}