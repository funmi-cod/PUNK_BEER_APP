import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punk_beer_app/common/themes/app_colors.dart';

class Loader extends StatelessWidget {
  final double? radius;
  final Color? color;
  final String? text;

  const Loader(
      {Key? key,
      this.radius,
      this.color = AppColors.primaryRed,
      this.text = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: radius ?? 35.w,
          height: radius ?? 35.h,
          child: Platform.isAndroid
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(color!))
              : CupertinoActivityIndicator(
                  color: color,
                  radius: radius ?? 20.r,
                ),
          // : Image.asset(loadingGif, width: 40, height: 40)
        ),
        text != "" ? Text(text!) : SizedBox.shrink()
      ],
    );
  }
}
