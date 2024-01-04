import 'package:flutter/material.dart';

import '../../../../common/blueButton.dart';
import '../../../../utils/utils.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.072916667), // 30
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.222363405, // 200
                // child: Builder(
                //   builder: (context) => FlareActor(
                //     'assets/flare/verification_loading.flr',
                //     alignment: Alignment.center,
                //     animation: 'loading',
                //     fit: BoxFit.contain,
                //   ),
                // ),
              ),
              SizedBox(height: screenHeight * 0.044472681), // 40
              Text(
                "Waiting for Verification",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: screenHeight * 0.03001906, // 27
                ),
              ),
              SizedBox(height: screenHeight * 0.03001906), // 27
              Text(
                "A verification email has been sent to your email",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: screenHeight * 0.015565438, // 14
                ),
              ),
              Text(
                "Verify by clicking on the link provided",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: screenHeight * 0.015565438, // 14
                ),
              ),
              SizedBox(height: screenHeight * 0.050031766), // 45
              BlueButton(
                title: "Confirm Verification",
                onPressed: (){},
              ),
              SizedBox(height: screenHeight * 0.025031766), // 45
              BlueButton(
                title: "Resend Verification Link",
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
