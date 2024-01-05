import '../../../utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? username;
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
    this.username,
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
      'Username':username,
      "Photo": photoURL,
      "Password": password,
      "UID": uid,
    };
  }

  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => TcFormatter.formatPhoneNumber(phoneNo!);

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName){
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length>1?nameParts[1].toLowerCase():'';

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;

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