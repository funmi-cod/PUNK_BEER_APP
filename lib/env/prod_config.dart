import 'package:punk_beer_app/env/base_config.dart';

class ProdConfig implements BaseConfig {
  String get BASE_URL => "https://api.openbrewerydb.org";
}
