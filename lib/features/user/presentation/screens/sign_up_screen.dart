import 'package:bimarestan_doctors/constants/assets.dart';
import 'package:bimarestan_doctors/core/resources/color_manager.dart';
import 'package:bimarestan_doctors/core/shared/app_elevated_button.dart';
import 'package:bimarestan_doctors/core/utils/functions/show_image_bottom_sheet.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/custom_circular_form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              // Container(
              //   height: 200.h,
              //   width: double.infinity,
              //   color: ColorManager.card,
              //   child: Image.asset(
              //     Assets.assetsImagesLogoWhite,
              //   ),
              // ),
              // SizedBox(
              //   width: 100.w,
              //   height: 105.h,
              //   child: Stack(
              //     children: [
              //       Container(
              //         width: 96.w,
              //         height: 96.h,
              //         decoration: BoxDecoration(
              //           color: ColorManager.primary,
              //           borderRadius: BorderRadius.circular(5.r),
              //         ),
              //       ),
              //       Align(
              //         alignment: Alignment.bottomRight,
              //         child: CircleAvatar(
              //           child: IconButton(
              //             onPressed: () {
              //               showImageBottomSheet(context);
              //             },
              //             icon: SizedBox(
              //               width: 20.w,
              //               height: 20.h,
              //               child: FittedBox(
              //                 child: Icon(
              //                   Icons.add,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  children: [
                    CustomCircularFormField(
                      hintText: 'First Name',
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomCircularFormField(
                      hintText: 'Last Name',
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomCircularFormField(
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomCircularFormField(
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomCircularFormField(
                      hintText: 'Doctor ID',
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomCircularFormField(
                      hintText: 'Professional practice certificate',
                      suffixIcon: Icon(Icons.add),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    AppElevatedButton(
                      height: 60.h,
                      width: 360.w,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(Routes.home);
                      },
                      child: Text('Sign Up'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
