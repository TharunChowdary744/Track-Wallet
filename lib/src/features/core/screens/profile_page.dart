import 'package:expense_tracker/src/features/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/form_fields/custom_form_field.dart';
import '../../../utils/utils.dart';
import '../../../utils/validators/validators.dart';
import '../../../common/form_fields/currency_form_field.dart';
import '../../authentication/models/user_model.dart';

class ProfilePage extends StatelessWidget {
  static const String id = "profile_page";
  @override
  Widget build(BuildContext context) {
    return ProfilePageBody();
  }
}

class ProfilePageBody extends StatefulWidget {
  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _defaultCurrencyController = TextEditingController();
  final _photoUrlController = TextEditingController();
  late AnimationController _animationController;
  late Animation _opacityAnimation;
  bool editable = false;
  Map<String, dynamic> _currencyData = {};

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    final _curve =
    CurvedAnimation(parent: _animationController, curve: Curves.ease);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 0.25).animate(_curve);
    _photoUrlController.addListener(() {
      setState(() {
      });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _currencyData = await getCurrencyData(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
        return Scaffold(
          appBar: AppBar(
            title: Text("My Profile"),
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).cardColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          floatingActionButton: FloatingActionButton(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 2 ,
                  child: Opacity(
                    opacity: _animationController.value == 1
                        ? 1.0
                        : 1 - (_animationController.value * 0.5),
                    child: child,
                  ),
                );
              },
              child: Icon(Icons.edit,
                // state is EditableProfilePage ? Icons.save : Icons.edit,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            onPressed: () {
              // if (state is EditableProfilePage) {
              //   if (!_formKey.currentState.validate()) return;
              //   BlocProvider.of<ProfileBloc>(context).add(
              //     ProfileSaved(
              //       firstName: _firstNameController.text,
              //       lastName: _lastNameController.text,
              //       defaultCurrency: _defaultCurrencyController.text,
              //       phoneNumber: _phoneNumberController.text,
              //       pictureUrl: _photoUrlController.text,
              //     ),
              //   );
              // } else if (state is ProfilePageLoaded ||
              //     state is ProfileChangeSuccess) {
              //   _animationController.forward();
              //   BlocProvider.of<ProfileBloc>(context).add(EditProfile());
              // }
            },
          ),
          body: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
              if(snapshot.connectionState ==ConnectionState.done){
                if(snapshot.hasData){
                  UserModel userData = snapshot.data as UserModel;
                   return ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(35.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: screenHeight * 0.064472681),
                            GestureDetector(
                              onTap: false
                                  ? () {
                                Feedback.forTap(context);
                                // showDialog(
                                //   barrierDismissible: false,
                                //   builder: (context) {
                                //     return AvatarPicker(
                                //         pictureUrlController:
                                //         _photoUrlController);
                                //   },
                                //   context: context,
                                // );
                              }
                                  : null,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).primaryColorDark,
                                      width: 1.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(0.25),
                                        blurRadius: 15.0,
                                        offset: Offset(5.0, 5.0),
                                        spreadRadius: 2.0,
                                      )
                                    ]),
                                child: Hero(
                                  tag: "profile",
                                  child: CircleAvatar(
                                    radius: screenHeight * 0.055590851, // 50
                                    child: FadeInImage(
                                      placeholder:
                                      AssetImage('assets/icons/misc/loader.png'),
                                      image:  AssetImage('assets/icons/misc/loader.png'),//FirebaseImage(_photoUrlController.text),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.075),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) => Opacity(
                          opacity: _opacityAnimation.value + 0.75,
                          child: child,
                        ),
                        child:Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.075),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: screenHeight * 0.044472681), // 40
                                CustomTextFormField(
                                  currentNode: FocusNode(),
                                  nextNode: FocusNode(),
                                  textInputAction: TextInputAction.next,
                                  enabled: editable,
                                  maxLines: 1,
                                  fieldController: _firstNameController,
                                  hintText: 'First Name',
                                  prefixImage: 'assets/icons/auth_icons/firstName.svg',
                                  keyboardType: TextInputType.text,
                                  validator: (value)=>TcValidator.validateEmptyText('First Name', value!),
                                ),
                                SizedBox(height: screenHeight * 0.024459975), // 22
                                // MyProfileForm(
                                //   enabled: editable,
                                //   formKey: _formKey,
                                //   defaultCurrencyController: _defaultCurrencyController,
                                //   firstNameController: _firstNameController,
                                //   lastNameController: _lastNameController,
                                //   phoneNumberController: _phoneNumberController,
                                // ),
                                CustomTextFormField(
                                  initialValue: userData.displayName,
                                  currentNode: FocusNode(),
                                  nextNode: FocusNode(),
                                  textInputAction: TextInputAction.next,
                                  enabled: editable,
                                  maxLines: 1,
                                  fieldController: _lastNameController,
                                  hintText: 'Last Name',
                                  prefixImage: 'assets/icons/auth_icons/lastName.svg',
                                  keyboardType: TextInputType.text,
                                  validator: (value)=>TcValidator.validateEmptyText('Last Name', value!),
                                ),
                                // SizedBox(height: screenHeight * 0.024459975), // 22
                                // CustomTextFormField(
                                //   currentNode: FocusNode(),
                                //   nextNode: FocusNode(),
                                //   textInputAction: TextInputAction.next,
                                //   enabled: editable,
                                //   maxLines: 1,
                                //   fieldController: _phoneNumberController,
                                //   hintText: 'Phone Number',
                                //   prefixImage: 'assets/icons/auth_icons/phone.svg',
                                //   keyboardType: TextInputType.phone,
                                //   validator: Validator().validatePhoneNumber,
                                //   inputFormatters: isInternational
                                //       ? []
                                //       : [DialCodeFormatter(Locale('en', 'IN'))],
                                // ),
                                SizedBox(height: screenHeight * 0.024459975), // 22
                                CurrencyFormField(
                                  defaultCurrencyCodeController: _defaultCurrencyController,
                                  currentNode: FocusNode(),
                                  enabled: editable,
                                )
                              ],
                            ),
                          ),
                        ),


                      ),
                    ],
                  );
                } else if (snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()),);
                } else {
                  return const Center(child: Text('Something went wrong'),);
                }
              } else{
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );


  }
}

