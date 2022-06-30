import 'package:firebase_auth/firebase_auth.dart';

class DoctorModel {
  String? uid;
  String? username;
  String? first;
  String? last;
  String? email;
  String? gender;
  String? mobno;
  String? degree;
  String? exp;
  String? special;
  String? imageUrl;
  String? t1;
  String? t2;
  String? t3;
  String? t4;
  String? t5;
  String? userType;

  DoctorModel({
    this.uid,
    this.email,
    this.first,
    this.last,
    this.gender,
    this.username,
    this.degree,
    this.exp,
    this.mobno,
    this.special,
    this.imageUrl,
    this.t1,
    this.t2,
    this.t3,
    this.t4,
    this.t5,
    this.userType,
  });

  // recieving data from the server

  factory DoctorModel.fromMap(map) {
    return DoctorModel(
      uid: map['uid'],
      email: map['email'],
      first: map['first'],
      last: map['last'],
      username: map['username'],
      gender: map['gender'],
      mobno: map['mobno'],
      degree: map['degree'],
      exp: map['exp'],
      special: map['special'],
      imageUrl: map['imageUrl'],
      t1: map['t1'],
      t2: map['t2'],
      t3: map['t3'],
      t4: map['t4'],
      t5: map['t5'],
      userType: map['userType'],
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
      'exp': exp,
      'special': special,
      'gender': gender,
      'mobno': mobno,
      'imageUrl': imageUrl,
      'username': username,
      't1': t1,
      't2': t2,
      't3': t3,
      't4': t4,
      't5': t5,
      'userType': userType,
    };
  }
}
