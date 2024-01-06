import 'package:expense_tracker/src/common/widgets/appbar/appbar.dart';
import 'package:expense_tracker/src/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:expense_tracker/src/utils/constants/colors.dart';
import 'package:expense_tracker/src/utils/constants/sizes.dart';
import 'package:expense_tracker/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/image_text_widgets/vertical_image_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TcPrimaryHeaderContainer(
                child: Column(
              children: [
                TcAppBar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TcColors.white),
                  ),
                ),
                SizedBox(
                  height: TcSizes.spaceBtwSections,
                ),
                ListTile(
                  // leading: TcVerticalImageText(image: '', title: '',),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

