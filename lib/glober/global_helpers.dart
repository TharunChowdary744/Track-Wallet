// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../sdk/functions/user_functions.dart';
//
// Future<void> _initializeSdk() async {
//   await loadCurrentUser();
//
//   final _fRef = await FirebaseFirestore.instance
//       .collection('users')
//       .where(
//         'id',
//         isEqualTo: _globalUser.id,
//       )
//       .get();
//
//   final _docRef = _fRef.docs[0].reference;
//
//   // await loadFriends(_docRef);
//   // await loadGroups(_docRef);
//   // await loadExpenses(_docRef);
//
//   // reloadTotalBalance;
// }
//
// Future<void> loadCurrentUser() async {
//   _globalUser = await UserFunctions.getCurrentUser();
// }
//
// /// Load friends list when a new friend is added or when the app is started
// // Future<void> loadFriends([DocumentReference? documentReference]) async {
// //   _friends = await FriendFunctions.getFriends(documentReference!);
// // }
//
// /// Load groups initially or when new group is added
// // Future<void> loadGroups([DocumentReference? documentReference]) async {
// //   _groups = await GroupFunctions.getGroups(documentReference!);
// // }
//
// /// Load expenses initiallu or when an expense is creared or updated
// // Future<void> loadExpenses([DocumentReference? documentReference]) async {
// //   _expenses = await ExpensesFunctions.getExpenses(documentReference!);
// //   reloadTotalBalance;
// // }
//
// /// Reload total balance for the user
// // void _reloadTotalBalance() {
// //   _totalBalance = 0.0;
// //
// //   for (var expense in _expenses) {
// //     if (expense.groupId == null) {
// //       _totalBalance += expense.owedShare;
// //     } else if (expense.groupId != null) {
// //       final _expenseUsers = expense.expenseUsers;
// //       if (_expenseUsers != null) {
// //         final _expenseUser = _expenseUsers.where((element) => element.userId == globalUser.id);
// //         _totalBalance += _expenseUser.first.netBalance;
// //       }
// //     }
// //   }
// // }
//
// /// Comments need to be initialized separately inorder to minimize data usage
// /// by not calling network calls for updating comments when [initializeSdk] is called.
// /// These will not change frequently
// // Future<void> _initializeComments() async {
// //   final _comList = await CommentFunctions.getComments();
// //   _comments = _comList;
// // }
//
// Future<void> _disposeSdk() async {
//   // _friends = [];
//   // _expenses = [];
//   // _groups = [];
//   // _totalBalance = 0.0;
// }
//
// // A global user so that sdk calls are not called repeatedly
// User _globalUser = User(id: '', firstName: '', lastName: '', pictureUrl: '', email: '', defaultCurrency: '', registrationStatus: '', phoneNumber: '');
// // List<Friend> _friends = [];
// // List<Expense> _expenses = [];
// // List<Group> _groups = [];
// // List<Comment> _comments = [];
// double _totalBalance = 0.00;
// // String currencySymbol;
//
// String currencySymbol = '\$';
// /// Getters
// ///
// User get globalUser => _globalUser;
// set setGlobalUser(User user) => _globalUser = user;
// // List<Friend> get getCurrentFriends => _friends;
// // List<Expense> get getCurrentExpenses => _expenses;
// // List<Group> get getCurrentGroups => _groups;
// // List<Comment> get getCurrentComments => _comments;
// double get totalBalance => _totalBalance;
// // Future<void> get initializeSdk => _initializeSdk();
// Future<void> get initializeSdk async {
//   await _initializeSdk();
// }
// // Future<void> get initializeComments => _initializeComments();
// // void get reloadTotalBalance => _reloadTotalBalance();
// Future<void> get disposeSdk => _disposeSdk();
