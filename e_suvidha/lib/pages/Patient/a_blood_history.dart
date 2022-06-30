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

class ApplyBloodHistory extends StatefulWidget {
  const ApplyBloodHistory({Key? key}) : super(key: key);

  @override
  State<ApplyBloodHistory> createState() => _ApplyBloodHistoryState();
}

class _ApplyBloodHistoryState extends State<ApplyBloodHistory> {
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
        title: Text("Blood Apply History"),
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
                      'Blood Apply History',
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
                      .collection('apply_blood')
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
                                  doc['address'],
                                  doc['age'],
                                  doc['blood_bank'],
                                  doc['blood_group'],
                                  doc['blood_unit'],
                                  doc['date'],
                                  doc['doc_mobno'],
                                  doc['doc_name'],
                                  doc['email'],
                                  doc['gender'],
                                  doc['mobno'],
                                  doc['name'],
                                  doc['patient_id'],
                                  doc['pin_code'],
                                  doc['request'],
                                  doc['time'],
                                  doc['weight'],
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
    String address,
    String age,
    String blood_bank,
    String blood_group,
    String blood_unit,
    String date,
    String doc_mobno,
    String doc_name,
    String email,
    String gender,
    String mobno,
    String name,
    String patient_id,
    String pin_code,
    String request,
    String time,
    String weight,
  ) {
    var size = MediaQuery.of(context).size;
    p_id = patient_id;
    print("Tapped............$p_id");
    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, '/a_blood_detail', arguments: {
          'address': address,
          'age': age,
          'blood_bank': blood_bank,
          'blood_group': blood_group,
          'blood_unit': blood_unit,
          'date': date,
          'doc_mobno': doc_mobno,
          'doc_name': doc_name,
          'email': email,
          'gender': gender,
          'mobno': mobno,
          'name': name,
          'patient_id': patient_id,
          'pin_code': pin_code,
          'request': request,
          'time': time,
          'weight': weight,
        });
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
              height: 100,
              width: 50,
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
                      "Patient: $name",
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
                      "Gender: $gender",
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
                          date,
                          style: TextStyle(
                            color: Color(0xffababab),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900,
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
                          time,
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
