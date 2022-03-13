class DoctorModel {
  String? uid;
  String? email;
  String? firstname;
  String? secondname;
  String? userType;

  DoctorModel(
      {this.uid, this.email, this.firstname, this.secondname, this.userType});

  // recieving data from the server

  factory DoctorModel.fromMap(map) {
    return DoctorModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstname'],
      secondname: map['secondname'],
      userType: map['userType'],
    );
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'secondname': secondname,
      'userType': userType,
    };
  }
}
