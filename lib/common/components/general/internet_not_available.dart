import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punk_beer_app/common/constant/text_constant.dart';
import 'package:punk_beer_app/common/constant/util.dart';
import 'package:punk_beer_app/common/themes/app_colors.dart';
import 'package:punk_beer_app/helpers/styles.dart';

class InternetNotAvailable extends StatelessWidget {
  const InternetNotAvailable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: scaledWidth(context).w,
      color: AppColors.primaryRed,
      child: Center(
          child: Styles.medium(TextLiterals.noInternet,
              color: AppColors.white,
              fontSize: scaledFontSize(12.sp, context))),
    );
  }
}
