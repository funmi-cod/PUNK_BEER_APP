import 'package:provider/provider.dart';
import 'package:punk_beer_app/providers/brewery_provider.dart';

final allProviders = [
  ChangeNotifierProvider<BreweryProvider>(
    create: (_) => BreweryProvider(),
  ),
];
