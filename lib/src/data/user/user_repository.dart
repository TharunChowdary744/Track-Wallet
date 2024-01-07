import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/src/exceptions/firebase_exceptions.dart';
import 'package:expense_tracker/src/exceptions/format_exceptions.dart';
import 'package:expense_tracker/src/exceptions/platform_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../features/personalization/modals/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void>saveUserRecord(UserModel user) async {
    try{
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e){
      throw TcFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw TcFormatException();
    } on PlatformException catch (e){
      throw TcPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserModel>fetchUserDetails() async {
    try{
      final documentSnapshot = await _db.collection("Users").doc().get();
      if(documentSnapshot.exists){
        return UserModel;
      }
    } on FirebaseException catch (e){
      throw TcFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw TcFormatException();
    } on PlatformException catch (e){
      throw TcPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
}
