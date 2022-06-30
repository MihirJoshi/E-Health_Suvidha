import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HairPage extends StatefulWidget {
  const HairPage({Key? key}) : super(key: key);

  @override
  State<HairPage> createState() => _HairPageState();
}

class _HairPageState extends State<HairPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("images").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("No Value");
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        return ListView(
            children: documents
                .map((doc) => Card(
                      child: Image.network(doc['imageUrl']),
                    ))
                .toList());
      },
    );
  }
}
