import 'package:expense_tracker/src/common/widgets/appbar/appbar.dart';
import 'package:expense_tracker/src/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:expense_tracker/src/section_heading.dart';
import 'package:expense_tracker/src/tc_circular_image.dart';
import 'package:expense_tracker/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/image_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TcAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TcSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TcCircularImage(
                      image: TcImages.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('Change Profile Picture')),
                  ],
                ),
              ),
              SizedBox(
                height: TcSizes.spaceBtwItems / 2,
              ),
              Divider(),
              SizedBox(
                height: TcSizes.spaceBtwItems,
              ),
              TcSectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              SizedBox(
                height: TcSizes.spaceBtwItems,
              ),
              TcProfileMenu(onPressed: () {  }, title: 'Name', value: 'akhsegfkashdf',),
              TcProfileMenu(onPressed: () {  }, title: 'Username', value: 'akhsegfkashdf',),

              SizedBox(
                height: TcSizes.spaceBtwItems / 2,
              ),
              Divider(),
              SizedBox(
                height: TcSizes.spaceBtwItems,
              ),
              TcSectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              SizedBox(
                height: TcSizes.spaceBtwItems,
              ),
              TcProfileMenu(onPressed: () {  }, title: 'User ID', value: 'akhsegfkashdf',icon: Iconsax.copy_copy,),
              TcProfileMenu(onPressed: () {  }, title: 'E-mail', value: 'akhsegfkashdf',),
              TcProfileMenu(onPressed: () {  }, title: 'Phone Number', value: 'akhsegfkashdf',),

            ],
          ),
        ),
      ),
    );
  }
}

