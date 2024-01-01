import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../glober/global_helpers.dart';


class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.pictureUrl,
    required this.email,
    required this.defaultCurrency,
    required this.registrationStatus,
    required this.phoneNumber,
  });

  String id;
  String firstName;
  String lastName;
  String pictureUrl;
  String email;
  String defaultCurrency;
  String registrationStatus;
  String phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      pictureUrl: json['pictureUrl'],
      email: json['email'],
      defaultCurrency: json['defaultCurrency'],
      registrationStatus: json['registrationStatus'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'pictureUrl': pictureUrl,
      'email': email,
      'defaultCurrency': defaultCurrency,
      'registrationStatus': registrationStatus,
      'phoneNumber': phoneNumber,
    };
  }
}
enum RegistrationStatus {
  registered,
  invited,
  dummy,
}

class UserFunctions {
  static final _firestore = FirebaseFirestore.instance;

  static Future<DocumentSnapshot> getUserDocument({required String id}) async {
    final querySnapshots =
    await _firestore.collection('users').where('id', isEqualTo: id).get();
    return querySnapshots.docs[0];
  }

  static Future<User> getCurrentUser() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    final email = firebaseUser?.email;
    final queryList =
    await _firestore.collection('users').where('email', isEqualTo: email).get();
    final doc = queryList.docs[0];
    final data = doc.data;

    return User.fromJson(data as Map<String, dynamic>);
  }

  static Future<void> updateUserDetails(User user) async {
    final docId = user.id;

    final updatedUser = User(
      id: user.id,
      email: user.email,
      registrationStatus: user.registrationStatus,
      firstName: user.firstName,
      lastName: user.lastName,
      defaultCurrency: user.defaultCurrency,
      pictureUrl: user.pictureUrl,
      phoneNumber: user.phoneNumber,
    );

    await _firestore.collection('users').doc(docId).set(
      updatedUser.toJson(),
      SetOptions(merge: true),
    );

    // Update friends
    // for (var friend in getCurrentFriends) {
    //   await _firestore
    //       .collection('users')
    //       .doc(friend.id)
    //       .collection('friends')
    //       .doc(user.id)
    //       .set(
    //     {
    //       "friend": updatedUser.toJson(),
    //     },
    //     SetOptions(merge: true),
    //   );
    // }
  }

  static Future<void> createUser(User user) async {
    final queryList = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: user.phoneNumber)
        .get();

    final docList = queryList.docs;

    if (docList.isEmpty) {
      final docId = _firestore.collection('users').doc().id;
      user.id = docId;
      user.registrationStatus = "${RegistrationStatus.registered}";

      await _firestore.collection('users').doc(docId).set(
        user.toJson(),
        SetOptions(merge: true),
      );
    } else {
      final docId = docList[0].id;
      user.id = docId;
      user.registrationStatus = "${RegistrationStatus.registered}";

      await _firestore.collection('users').doc(docId).set(
        user.toJson(),
        SetOptions(merge: true),
      );

      final fQueryList = await _firestore
          .collection('users')
          .doc(docId)
          .collection('friends')
          .get();
      final fDocList = fQueryList.docs;

      for (var fDoc in fDocList) {
        await _firestore
            .collection('users')
            .doc(fDoc.data()['id'])
            .collection('friends')
            .doc(docId)
            .set(
          {
            'friend': user.toJson(),
          },
          SetOptions(merge: true),
        );
      }
    }
  }
}
