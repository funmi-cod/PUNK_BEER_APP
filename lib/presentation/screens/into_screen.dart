import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punk_beer_app/common/components/app_button.dart';
import 'package:punk_beer_app/common/components/fade_in_down.dart';
import 'package:punk_beer_app/common/constant/route_constant.dart';
import 'package:punk_beer_app/common/constant/size_constant.dart';
import 'package:punk_beer_app/common/constant/text_constant.dart';
import 'package:punk_beer_app/common/constant/util.dart';
import 'package:punk_beer_app/common/themes/app_colors.dart';
import 'package:punk_beer_app/helpers/styles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryRed,
      body: SafeArea(
          child: SizedBox(
        width: scaledWidth(context).w,
        height: scaledHeight(context).h,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.dimen_10, vertical: Sizes.dimen_80),
          child: Column(
            children: [
              Expanded(
                child: Center(
                    child: Align(
                  alignment: Alignment.center,
                  child: FadeInDown(
                    child: Styles.bold(TextLiterals.appName,
                        fontSize: scaledFontSize(40.sp, context),
                        color: AppColors.white),
                  ),
                )),
              ),
              Container(
                width: double.infinity,
                child: AppButton(
                  text: TextLiterals.getStarted,
                  onPressed: () async {
                    Navigator.pushReplacementNamed(
                        context, RouteLiterals.homeScreen);
                  },
                  enabled: true,
                  fontWeight: FontWeight.w600,
                  backgroundColor: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  mainAxisAlignment: MainAxisAlignment.center,
                  height: Sizes.dimen_58.h,
                  fontSize: scaledFontSize(16.sp, context),
                  fontColor: AppColors.black,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
