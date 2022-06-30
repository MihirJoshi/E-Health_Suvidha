import 'package:e_suvidha/utils/routes.dart';
import 'package:flutter/material.dart';

class ShowLab extends StatefulWidget {
  const ShowLab({Key? key}) : super(key: key);

  @override
  State<ShowLab> createState() => _ShowLabState();
}

class _ShowLabState extends State<ShowLab> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String patient_id = args['patient_id'];
    String lab_type = args['lab_type'];
    String p_name = args['p_name'];
    String p_age = args['p_age'];
    String p_gender = args['p_gender'];
    String p_email = args['p_email'];
    String p_date = args['p_date'];
    String p_time = args['p_time'];
    String p_symp = args['p_symp'];
    String p_mobno = args['p_mobno'];
    String p_issue = args['p_issue'];
    var docVal = args['doc'];
    print(docVal['lab_type']);
    print(patient_id);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OrangeClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 250.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 106, 255),
              ),
            ),
          ),
          ClipPath(
            clipper: BlackClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width - 230.0,
              height: MediaQuery.of(context).size.height - 250.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 153, 0, 255),
              ),
            ),
          ),
          Center(
            child: Material(
              elevation: 30.0,
              color: Colors.white12,
              borderRadius: BorderRadius.circular(18.0),
              child: Container(
                width: 320.0,
                height: 450.0,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(18.0)),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: ClipPath(
                  clipper: ZigZagClipper(),
                  child: Container(
                    width: 330.0,
                    height: 600.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child:
                                  Image.asset('assets/images/drawer_logo.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Lab Details",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            width: 300.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: Colors.grey, width: 1.0)),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    'Lab Type: $lab_type',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 300.0,
                          color: Colors.grey,
                        ),
                        Container(
                          width: 300.0,
                          height: 310.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: Colors.grey, width: 1.0)),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Patient Name: $p_name",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " Gender: $p_gender",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " Age: $p_age",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " Pin Code: $p_issue",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " Email: $p_email",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Mobile No.: $p_mobno",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Collection Date: $p_date",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Collection Time: $p_time",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Address: $p_symp",
                                    style: TextStyle(
                                        color: Color(0xff363636),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    Navigator.pushNamed(context, '/assign_tech', arguments: {
                      'patient_id': patient_id,
                      'p_name': p_name,
                      'p_age': p_age,
                      'p_email': p_email,
                      'p_mobno': p_mobno,
                      'p_issue': p_issue,
                      'p_symp': p_symp,
                      'p_date': p_date,
                      'p_time': p_time,
                      'p_gender': p_gender,
                      'lab_type': lab_type,
                      'docVal': docVal
                    });
                  },
                  child: Container(
                    width: 300.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: Color.fromRGBO(48, 63, 159, 1), width: 1.5),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        'Assign Technician',
                        style: TextStyle(
                            color: Colors.indigo[700], fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(3.0, size.height - 10.0);

    var firstControlPoint = Offset(23.0, size.height - 40.0);
    var firstEndPoint = Offset(38.0, size.height - 5.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(58.0, size.height - 40.0);
    var secondEndPoint = Offset(75.0, size.height - 5.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(93.0, size.height - 40.0);
    var thirdEndPoint = Offset(110.0, size.height - 5.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    var fourthControlPoint = Offset(128.0, size.height - 40.0);
    var fourthEndPoint = Offset(150.0, size.height - 5.0);
    path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy,
        fourthEndPoint.dx, fourthEndPoint.dy);

    var fifthControlPoint = Offset(168.0, size.height - 40.0);
    var fifthEndPoint = Offset(185.0, size.height - 5.0);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fifthEndPoint.dx, fifthEndPoint.dy);

    var sixthControlPoint = Offset(205.0, size.height - 40.0);
    var sixthEndPoint = Offset(220.0, size.height - 5.0);
    path.quadraticBezierTo(sixthControlPoint.dx, sixthControlPoint.dy,
        sixthEndPoint.dx, sixthEndPoint.dy);

    var sevenControlPoint = Offset(240.0, size.height - 40.0);
    var sevenEndPoint = Offset(255.0, size.height - 5.0);
    path.quadraticBezierTo(sevenControlPoint.dx, sevenControlPoint.dy,
        sevenEndPoint.dx, sevenEndPoint.dy);

    var eightControlPoint = Offset(275.0, size.height - 40.0);
    var eightEndPoint = Offset(290.0, size.height - 5.0);
    path.quadraticBezierTo(eightControlPoint.dx, eightControlPoint.dy,
        eightEndPoint.dx, eightEndPoint.dy);

    var ninthControlPoint = Offset(310.0, size.height - 40.0);
    var ninthEndPoint = Offset(330.0, size.height - 5.0);
    path.quadraticBezierTo(ninthControlPoint.dx, ninthControlPoint.dy,
        ninthEndPoint.dx, ninthEndPoint.dy);

    path.lineTo(size.width, size.height - 10.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BlackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2, size.height - 50.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OrangeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 250.0, size.height - 50.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
