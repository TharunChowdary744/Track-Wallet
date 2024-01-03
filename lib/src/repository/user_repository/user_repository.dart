import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/glober/logger.dart';
import 'package:expense_tracker/src/features/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    // Check if the user is already exists
    QuerySnapshot existingUsers = await _db
        .collection("users")
        .where("Email",
            isEqualTo: user.email) // Assuming 'email' is a unique identifier
        .get();
    // User does not exist, proceed with creating a new user
    if (existingUsers.docs.isEmpty){
      await _db
          .collection("users")
          .add(user.toJson())
          .whenComplete(() => Get.snackbar(
              "Success", "You account has been created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green))
          .catchError((error, stackTrace) {
        Get.snackbar("Error", "Something went wrong. Try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        logger.e(error.toString());
      });}
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db.collection("Users").where("Email",isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }
}
