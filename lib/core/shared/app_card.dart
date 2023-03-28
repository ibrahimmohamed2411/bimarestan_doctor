import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';


class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.padding,
    required this.child,
  });
  final EdgeInsetsGeometry? padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 10.h,
          ),
      decoration: BoxDecoration(
        color: ColorManager.card.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
