import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PConsult extends StatefulWidget {
  const PConsult({Key? key}) : super(key: key);

  @override
  State<PConsult> createState() => _PConsultState();
}

class _PConsultState extends State<PConsult> {
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
        title: Text("Patient Lists"),
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
                      'Consult History',
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
                      .collection('consultations')
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
                                  doc['docname'],
                                  doc['docimgUrl'].toString(),
                                  doc['docdegree'],
                                  doc['docspecial'],
                                  doc['docmobno'],
                                  doc['p_name'],
                                  doc['p_gender'],
                                  doc['p_age'],
                                  doc['p_email'],
                                  doc['p_issue'],
                                  doc['p_mobno'],
                                  doc['p_date'],
                                  doc['p_time'],
                                  doc['p_symp'],
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
    String docname,
    String docimgUrl,
    String docdegree,
    String docspecial,
    String docmobno,
    String p_name,
    String p_gender,
    String p_age,
    String p_email,
    String p_issue,
    String p_mobno,
    String p_date,
    String p_time,
    String p_symp,
  ) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/d_detail', arguments: {
          'docname': docname,
          'docimgUrl': docimgUrl,
          'docdegree': docdegree,
          'docspecial': docspecial,
          'docmobno': docmobno,
          'p_name': p_name,
          'p_age': p_age,
          'p_email': p_email,
          'p_gender': p_gender,
          'p_mobno': p_mobno,
          'p_issue': p_issue,
          'p_date': p_date,
          'p_time': p_time,
          'p_symp': p_symp,
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
              height: 130,
              width: 60,
              child: Image.network(
                docimgUrl,
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
                      "Doctor : $docname",
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
                      "Degree: $docdegree",
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