import 'package:expense_tracker/src/utils/constants/colors.dart';
import 'package:expense_tracker/src/utils/constants/sizes.dart';
import 'package:expense_tracker/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TcCircularImage extends StatelessWidget {
  const TcCircularImage(
      {super.key,
      this.fit = BoxFit.cover,
      required this.image,
      this.isNetworkImage = false,
      this.overlayColor,
      this.backgroundColor,
      this.width = 56,
      this.height = 56,
      this.padding = TcSizes.sm});

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor ??
              (TcHelperFunctions.isDarkMode(context)
                  ? TcColors.black
                  : TcColors.white),
          borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Image(
          fit: fit,
          image: isNetworkImage
              ? NetworkImage(image)
              : AssetImage(image) as ImageProvider,
          color: overlayColor,
        ),
      ),
    );
  }
}
