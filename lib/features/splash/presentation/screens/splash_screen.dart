import 'package:bimarestan_doctors/constants/assets.dart';
import 'package:bimarestan_doctors/features/splash/presentation/providers/splash_provider.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashProvider>(
      create: (context) => locator()..init(),
      child: Consumer<SplashProvider>(
        builder: (context, value, child) => Scaffold(
          body: Center(
            child: Image.asset(
              Assets.assetsImagesLogo,
              width: 343.w,
              height: 314.h,
            ),
          ),
        ),
      ),
    );
  }
}
