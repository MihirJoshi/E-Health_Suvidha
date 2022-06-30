import 'package:e_suvidha/common/women_data_model.dart';
import 'package:e_suvidha/pages/Patient/period_symptoms.dart';
import 'package:flutter/material.dart';

class WomenPage extends StatefulWidget {
  const WomenPage({Key? key}) : super(key: key);

  @override
  State<WomenPage> createState() => _WomenPageState();
}

class _WomenPageState extends State<WomenPage> {
  static List<String> women = [
    'Perioad Issues',
    'Pregnancy Issues',
    'Breast Scan',
    'Excessive Bleeding',
    'Thyroid Problems'
  ];

  static List url = [
    "assets/symptoms/fever.png",
    "assets/symptoms/period.png",
    "assets/symptoms/pregnancy.png",
    "assets/symptoms/breast.png",
    "assets/symptoms/excessive.png"
  ];

  final List<WomenDataModel> WomenData = List.generate(women.length,
      (index) => WomenDataModel('${women[index]}', '${url[index]}'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Women's Isses"),
      ),
      body: ListView.builder(
          itemCount: women.length,
          itemBuilder: (context, index) {
            return new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PeriodPage(),
                        settings: RouteSettings(arguments: women[index])));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Card(
                  child: ListTile(
                    title: Text(WomenData[index].name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(WomenData[index].imageUrl),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
