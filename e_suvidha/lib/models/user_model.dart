class UserModel {
  String? uid;
  String? email;
  String? firstname;
  String? secondname;
  String? userType;

  UserModel(
      {this.uid, this.email, this.firstname, this.secondname, this.userType});

  // recieving data from the server

  factory UserModel.fromMap(map) {
    return UserModel(
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
