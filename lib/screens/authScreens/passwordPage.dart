import 'package:chat_iq/screens/authScreens/otpPage.dart';
import 'package:chat_iq/shared/widgets/authWidgets/customSignUp.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_elevated_button.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_textfield.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_timelinelisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Password extends StatelessWidget {
  const Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomSignUp(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 51.w),
            child: Container(
              height: 53.h,
              width: 297.w,
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  BuildTimeLinetile(
                    isSelected: true,
                    text: 'Email',
                  ),
                  BuildTimeLinetile(
                    isSelected: true,
                    text: 'Name',
                  ),
                  BuildTimeLinetile(
                    isSelected: true,
                    text: 'Birthday',
                  ),
                  BuildTimeLinetile(
                    isSelected: true,
                    text: 'Gender',
                  ),
                  BuildTimeLinetile(
                    text: 'Pass',
                    isSelected: false,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 45.h,
          ),
          CustomTextField(
            title: 'Password',
            hintText: '',
            keyboardType: TextInputType.text,
            obsecureText: true,
          ),
          SizedBox(
            height: 16.h,
          ),
          CustomTextField(
            title: 'Confirm Password',
            hintText: '',
            keyboardType: TextInputType.text,
            obsecureText: true,
          ),
          SizedBox(
            height: 26.h,
          ),
          CustomElevatedButton(
              buttonName: 'Finish',
              onTab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OTP()));
              })
        ],
      ),
    );
  }
}
