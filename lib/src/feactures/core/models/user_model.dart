import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? displayName;
  final String? email;
  final String? phoneNo;
  final String? password;
  final String? photoURL;
  final String? uid;

  const UserModel({
    this.id,
    this.photoURL,
    this.uid,
    this.displayName,
    this.email,
    this.phoneNo,
    this.password,
  });

  toJson() {
    return {
      "DisplayName": displayName,
      "Email": email,
      "Phone": phoneNo,
      "Photo": photoURL,
      "Password": password,
      "UID": uid,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
      id: document.id,
        displayName: data["DisplayName"],
        email: data["Email"],
        phoneNo: data["Phone"],
        password: data["Password"],
        photoURL: data["Photo"],
        uid: data["UID"],
    );
  }
}