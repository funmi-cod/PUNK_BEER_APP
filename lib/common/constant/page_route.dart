import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:punk_beer_app/common/constant/route_constant.dart';
import 'package:punk_beer_app/data/models/brewery_model.dart';
import 'package:punk_beer_app/presentation/screens/home/detail_screen.dart';
import 'package:punk_beer_app/presentation/screens/home/home_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLiterals.homeScreen:
        return CupertinoPageRoute(
            builder: (_) => HomeScreen(),
            settings: RouteSettings(name: settings.name));

      case RouteLiterals.detailScreen:
        BreweryHistory data = settings.arguments as BreweryHistory;
        return CupertinoPageRoute(
            builder: (_) => DetailScreen(
                  data: data,
                ),
            settings: RouteSettings(name: settings.name));

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route specified for ${settings.name}'),
                  ),
                ));
    }
  }
}
