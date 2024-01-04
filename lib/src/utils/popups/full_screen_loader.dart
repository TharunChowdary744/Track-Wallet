import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/loader/animation_loader.dart';

class TcFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(child: Container(
          // color: TcHelperFunctions.isDarkMode(Get.context!)? TcColors.dark:TcColors.whike,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 250,),
              TcAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        )));
  }
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}
