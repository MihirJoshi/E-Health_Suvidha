import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/pages/Patient/consult_form.dart';
import 'package:flutter/material.dart';

import '../../widgets/patient_navigation_widget.dart';

class CommonDocotrPage extends StatefulWidget {
  const CommonDocotrPage({Key? key}) : super(key: key);

  @override
  State<CommonDocotrPage> createState() => _CommonDocotrPageState();
}

class _CommonDocotrPageState extends State<CommonDocotrPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: PNavigationHomeScreen(),
      appBar: AppBar(
        title: Text("Common Issues Doctors"),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                      'Category',
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
                      .collection('doctors')
                      .where('special', isEqualTo: 'Physician')
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
                                doc['uid'],
                                doc['imageUrl'].toString(),
                                doc['first'],
                                doc['degree'],
                                doc['special'],
                                doc['mobno'],
                                doc['exp'],
                                doc['t1'] ?? 0,
                                doc['t2'] ?? 0,
                                doc['t3'] ?? 0,
                                doc['t4'] ?? 0,
                                doc['t5'] ?? 0,
                                ""))
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
      String uid,
      String img,
      String name,
      String degree,
      String speciality,
      String mobno,
      String exp,
      String t1,
      String t2,
      String t3,
      String t4,
      String t5,
      String distance) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print("Tapped!!!!!!!!!$uid, ${name}, ${speciality}, ${degree} ,$t1");
        Navigator.pushNamed(context, '/consult_form', arguments: {
          'uid': uid,
          'img': img,
          'mobno': mobno,
          'name': name,
          'speciality': speciality,
          'degree': degree,
          't1': t1,
          't2': t2,
          't3': t3,
          't4': t4,
          't5': t5
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
                img,
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
                      name,
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
                      degree,
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
                          speciality,
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
                          "Price ₹ 200",
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
                  Container(
                    margin: EdgeInsets.only(left: 130, top: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "${exp} years exp",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

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
