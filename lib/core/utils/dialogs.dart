import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../resources/color_manager.dart';

Future<void> showLoadingDialog([String? message]) {
  return EasyLoading.show(
    status: message,
    dismissOnTap: true,
    maskType: EasyLoadingMaskType.black,
    indicator: SizedBox(
      width: 200.w,
      height: 200.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FittedBox(
            child: SpinKitCubeGrid(
              duration: Duration(milliseconds: 1200),
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> dismissLoadingDialog() {
  return EasyLoading.dismiss();
}
