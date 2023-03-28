import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularFormField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  const CustomCircularFormField({
    super.key,
    this.hintText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 17.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        border: OutlineInputBorder(
          gapPadding: 2,
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }
}
