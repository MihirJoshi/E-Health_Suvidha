import 'package:firebase_auth/firebase_auth.dart';

class TechModel {
  String? uid;
  String? first;
  String? last;
  String? email;
  String? gender;
  String? mobno;
  String? degree;
  String? imageUrl;

  TechModel({
    this.uid,
    this.email,
    this.first,
    this.last,
    this.gender,
    this.degree,
    this.mobno,
    this.imageUrl,
  });

  // recieving data from the server

  factory TechModel.fromMap(map) {
    return TechModel(
      uid: map['uid'],
      email: map['email'],
      first: map['first'],
      last: map['last'],
      gender: map['gender'],
      mobno: map['mobno'],
      degree: map['degree'],
      imageUrl: map['imageUrl'],
    );
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'first': first,
      'last': last,
      'degree': degree,
      'gender': gender,
      'mobno': mobno,
      'imageUrl': imageUrl,
    };
  }
}
