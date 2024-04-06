import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:punk_beer_app/common/components/general/app_header.dart';
import 'package:punk_beer_app/common/components/general/spacing.dart';
import 'package:punk_beer_app/common/constant/size_constant.dart';
import 'package:punk_beer_app/common/constant/text_constant.dart';
import 'package:punk_beer_app/common/constant/util.dart';
import 'package:punk_beer_app/common/themes/app_colors.dart';
import 'package:punk_beer_app/data/models/brewery_model.dart';
import 'package:punk_beer_app/helpers/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final BreweryHistory data;

  DetailScreen({required this.data, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightRed,
      body: Padding(
          padding: EdgeInsets.only(
              left: Sizes.dimen_15.w,
              right: Sizes.dimen_15.w,
              top: Sizes.dimen_20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalSpacing(Sizes.dimen_30.h),
              AppHeader(
                title: TextLiterals.breweryHistory,
                hasLeading: true,
                onClick: () {
                  Navigator.pop(context);
                },
              ),
              VerticalSpacing(Sizes.dimen_30.h),
              Container(
                padding: EdgeInsets.all(Sizes.dimen_10.r),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(Sizes.dimen_5.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(Sizes.dimen_10.h),
                    Styles.medium(
                      '${TextLiterals.name}: ${widget.data.name}',
                      fontSize: scaledFontSize(Sizes.dimen_14.sp, context),
                    ),
                    VerticalSpacing(Sizes.dimen_10.h),
                    Styles.medium(
                      '${TextLiterals.breweryType}: ${widget.data.breweryType}',
                      fontSize: scaledFontSize(Sizes.dimen_12.sp, context),
                    ),
                    VerticalSpacing(Sizes.dimen_10.h),
                    Styles.medium('${TextLiterals.phone}: ${widget.data.phone}',
                        fontSize: scaledFontSize(Sizes.dimen_12.sp, context),
                        color: AppColors.mediumGray),
                    VerticalSpacing(Sizes.dimen_10.h),
                    Styles.medium(
                        '${TextLiterals.address}: ${widget.data.address1}',
                        fontSize: scaledFontSize(Sizes.dimen_12.sp, context),
                        color: AppColors.mediumGray),
                    VerticalSpacing(Sizes.dimen_10.h),
                    Styles.medium(
                        '${TextLiterals.province}: ${widget.data.stateProvince}',
                        fontSize: scaledFontSize(Sizes.dimen_12.sp, context),
                        color: AppColors.mediumGray),
                    VerticalSpacing(Sizes.dimen_10.h),
                    Styles.medium(
                        '${TextLiterals.postalCode}: ${widget.data.postalCode}',
                        fontSize: scaledFontSize(Sizes.dimen_12.sp, context),
                        color: AppColors.mediumGray),
                    VerticalSpacing(Sizes.dimen_10.h),
                    InkWell(
                      onTap: () async {
                        debugPrint("Urlll: ${widget.data.websiteUrl}");
                        String url = widget.data.websiteUrl ?? '';

                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {}
                      },
                      child: Styles.medium(TextLiterals.viewWebsite,
                          fontSize: scaledFontSize(Sizes.dimen_12.sp, context),
                          color: AppColors.primaryRed),
                    ),
                    VerticalSpacing(Sizes.dimen_10.h),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
