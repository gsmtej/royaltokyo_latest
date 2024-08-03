import 'dart:convert';

import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/network_repository.dart';
import 'package:buyer_app/home/model/DashboardDetailModel.dart';
import 'package:flutter/material.dart';


class DashboardProvider with ChangeNotifier{
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  DashboadrdDetailsModel? _dashboardDetailModel;
  DashboadrdDetailsModel? get dashboadrdDetailsModel => _dashboardDetailModel;

  bool setIsFilterApplied = false;
  bool get isFilterApplied => setIsFilterApplied;

  int setCategoriesId = 0;
  int get isCategoriesId => setCategoriesId;

  DashboadrdDetailsModel? _categoriesModel;
  DashboadrdDetailsModel? get categoriesModel => _categoriesModel;

  Future<void> getHomepageDetails(BuildContext context) async {
    _isFetching = true;
    notifyListeners();
    Map<String, dynamic> body = {
      "latitude":
      // "51.2269388",
      sharedPreferences!.getString("latitude") ?? "",
      "longitude":
      // "4.4439088",
    sharedPreferences!.getString("longitude") ?? "",
    };
   /* try {*/
      String url = AppConfig.GET_HOMEPAGE_DETAIL;
      var response = await callPostMethod(url,body);
      print('========rep${json.decode(response)}');

      _dashboardDetailModel = DashboadrdDetailsModel.fromJson(json.decode(response));
      _categoriesModel = DashboadrdDetailsModel.fromJson(json.decode(response));
      print('========rep${_dashboardDetailModel?.data}');
      print('========rep${_dashboardDetailModel?.data?.category!.length}');

      if (_dashboardDetailModel != null && _dashboardDetailModel?.data != null) {

        print('========rep${_dashboardDetailModel?.data?.category!.length}');

      } else {
        _dashboardDetailModel =
            DashboadrdDetailsModel(
                status: false,
                msg: _dashboardDetailModel?.errors!.errorMessage.toString() ?? ""
            // 'Internal Server Issue'
            );
        _categoriesModel =
            DashboadrdDetailsModel(
                status: false,
                msg: _dashboardDetailModel?.errors!.errorMessage.toString() ?? ""
              // 'Internal Server Issue'
            );
      }
    /*} catch (e) {

      print(e.toString()+"=----catch");
      _isFetching=false;
      _dashboardDetailModel =
          DashboadrdDetailsModel(status: false,
              msg: _dashboardDetailModel?.errors!.errorMessage.toString() ?? ""
          );
      // return result;
    }*/

    _isFetching = false;
    notifyListeners();
  }

  Future<void> getRestaurantByCategories(BuildContext context) async {
    _isFetching = true;
    notifyListeners();
    String url = AppConfig.GET_RESTAURANT_BY_CATEGORY+"/$isCategoriesId";
    print('========url$url');
    var response = await callGetMethod(url);
    print('========rep${json.decode(response)}');

    _dashboardDetailModel = DashboadrdDetailsModel.fromJson(json.decode(response));
    print('========rep${_dashboardDetailModel?.data}');
    print('========rep${_dashboardDetailModel?.data?.restaurants!.length}');

    if (_dashboardDetailModel != null && _dashboardDetailModel?.data != null) {

      print('========rep${_dashboardDetailModel?.data?.restaurants!.length}');

    } else {
      _dashboardDetailModel =
          DashboadrdDetailsModel(
              status: false,
              msg: _dashboardDetailModel?.errors!.errorMessage.toString() ?? ""
          // 'Internal Server Issue'
          );
    }
    _isFetching = false;
    notifyListeners();
  }

  void resetFilter(){
    setCategoriesId = 0;
    setIsFilterApplied = false;
    _dashboardDetailModel = _categoriesModel;
    notifyListeners();
  }
}