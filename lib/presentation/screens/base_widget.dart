// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:provider/provider.dart';
import 'package:punk_beer_app/common/components/general/internet_not_available.dart';
import 'package:punk_beer_app/common/components/general/spacing.dart';
import 'package:punk_beer_app/common/constant/size_constant.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Visibility(
            visible: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected,
            child: Column(
              children: [
                VerticalSpacing(Sizes.dimen_20.h),
                const InternetNotAvailable(),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
