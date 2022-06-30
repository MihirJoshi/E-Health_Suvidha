import 'package:flutter/material.dart';

class RenalLab extends StatefulWidget {
  const RenalLab({Key? key}) : super(key: key);

  @override
  State<RenalLab> createState() => _RenalLabState();
}

class _RenalLabState extends State<RenalLab> {
  bool _expanded = false;
  var _test = "Full Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Advanced Renal Package"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: ListView(
              shrinkWrap: true,
              children: [
                demoTopRatedDr("assets/images/drawer_logo.png",
                    "Advanced Renal Package", "Covers 8 Tests", "₹625"),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(15.0)),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Test Requirements",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 35.0),
            child: Text(
              "Sample Type: Blood",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 35.0),
            child: Text(
              "Fasting Required: 10-12 Hrs",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Lab Contents",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              color: Colors.green,
              child: ExpansionPanelList(
                animationDuration: Duration(milliseconds: 2000),
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(
                          'Package Includes 8 tests',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    },
                    body: ListTile(
                      title: Text(
                          '• Serum Electrolytes\n\n     • Serum Sodium (Na) \n\n     • Chloride (Cl)\n\n'
                          '• BUN/Creatinine Ratio\n\n'
                          '• Blood Urea Nitrogen (BUN)\n\n'
                          '• Calcium (Ca)\n\n'
                          '• Creatinine\n\n'
                          '• Uric Acid\n\n'
                          '• Serum Phosphorus (Ph)',
                          style: TextStyle(color: Colors.black)),
                    ),
                    isExpanded: _expanded,
                    canTapOnHeader: true,
                  ),
                ],
                dividerColor: Colors.grey,
                expansionCallback: (panelIndex, isExpanded) {
                  _expanded = !_expanded;
                  setState(() {});
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: InkWell(
              splashColor: Colors.red,
              onTap: () {
                Navigator.pushNamed(context, '/book_lab_form', arguments: {
                  'lab_name': "Advanced Renal Package",
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
                    'Book Lab',
                    style: TextStyle(color: Colors.indigo[700], fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget demoTopRatedDr(
      String img, String name, String subtitle, String price) {
    var size = MediaQuery.of(context).size;
    return Container(
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
                    subtitle,
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
                        price,
                        style: TextStyle(
                          color: Color(0xffababab),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 105)),
                      Icon(Icons.keyboard_arrow_right),
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
    );
  }
}
