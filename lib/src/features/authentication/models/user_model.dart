import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? displayName;
  final String? firstName;
  final String? lastName;
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
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNo,
    this.password,
  });

  Map<String, dynamic>toJson() {
    return {
      "DisplayName": displayName,
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
      "Phone": phoneNo,
      "Photo": photoURL,
      "Password": password,
      "UID": uid,
    };
  }

  // factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
  //   if(document.data()!=null){
  //     final data = document.data()!;
  //     return UserModel(
  //       id: document.id,
  //       displayName: data["DisplayName"],
  //       firstName: data["FirstName"],
  //       lastName: data["LastName"],
  //       email: data["Email"],
  //       phoneNo: data["Phone"],
  //       password: data["Password"],
  //       photoURL: data["Photo"],
  //       uid: data["UID"],
  //     );
  //   }
  // }
}