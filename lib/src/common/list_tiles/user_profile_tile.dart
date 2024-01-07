import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../tc_circular_image.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';

class TcUserProfileTile extends StatelessWidget {
  const TcUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TcCircularImage(
        image: TcImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        'Tharun',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TcColors.white),
      ),
      subtitle: Text(
        'hfdgf@gmail.com',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: TcColors.white),
      ),
      trailing: IconButton(
          onPressed:onPressed,
          icon: Icon(
            Iconsax.edit,
            color: TcColors.white,
          )),
    );
  }
}
