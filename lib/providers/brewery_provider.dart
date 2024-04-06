import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:punk_beer_app/common/constant/text_constant.dart';
import 'package:punk_beer_app/common/core/api_constant.dart';
import 'package:punk_beer_app/common/core/req_client.dart';
import 'package:punk_beer_app/data/enums/view_state.dart';
import 'package:punk_beer_app/data/models/brewery_model.dart';
import 'package:punk_beer_app/env/environment.dart';
import 'package:punk_beer_app/helpers/utilities.dart';

class BreweryProvider with ChangeNotifier {
  ReqClient requestClient = ReqClient();
  //model
  Brewery? _brewery;
  Brewery get brewery => _brewery!;
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  bool _isLoadingMoreBrewery = false;

  bool get isLoadingMoreBrewery {
    return _isLoadingMoreBrewery;
  }

//states
  ViewState _breweryListViewState = ViewState.idle;
  ViewState get breweryListViewState => _breweryListViewState;
  setBeerListViewState(ViewState viewState) {
    _breweryListViewState = viewState;
    notifyListeners();
  }

//get the list of data from the API
  Future<Null> getBreweryHistories({
    int page = 1,
    int per_page = 10,
    isLoadingMore = false,
  }) async {
    try {
      if (isLoadingMore) {
        _isLoadingMoreBrewery = true;
        notifyListeners();
      } else {
        setBeerListViewState(ViewState.busy);
      }
      Response response;

      response = await requestClient.getWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.BREWERIES}?page=$page&per_page=$per_page');

      debugPrint("Breweries data: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Brewery history: ${response.data}");
        if (isLoadingMore == true) {
          Brewery brewery = Brewery.fromJson(response.data);
          if (brewery.data!.isNotEmpty) {
            for (var item in brewery.data!) {
              _brewery!.data!.add(item);
            }
          }
        } else {
          _brewery = Brewery.fromJson(response.data);
        }
        _isLoadingMoreBrewery = false;
        setBeerListViewState(ViewState.completed);
      } else {
        _errorMessage = TextLiterals.serverErrorMsg;
        _isLoadingMoreBrewery = false;

        setBeerListViewState(ViewState.error);
      }
    } on DioError catch (e) {
      _errorMessage = Utilities.dioErrorHandler(e);
      _isLoadingMoreBrewery = false;

      setBeerListViewState(ViewState.error);
    }
  }
}
