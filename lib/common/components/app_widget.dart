import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget {
  static Widget loadingIndicator({double? radius, Color? color}) {
    return SizedBox(
      height: radius ?? 25.h,
      width: radius ?? 25.w,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: color ?? Colors.transparent,
      ),
    );
  }
}
