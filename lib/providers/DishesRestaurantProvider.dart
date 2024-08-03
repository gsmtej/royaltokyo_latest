import 'dart:convert';

import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/network_repository.dart';
import 'package:buyer_app/DishesScreen/model/DishesRestaurantModel.dart';
import 'package:buyer_app/RestaurantScreen/model/RestaurantProductModel.dart';
import 'package:buyer_app/models/restaurant_list_model.dart';
import 'package:flutter/material.dart';


class DishesRestaurantProvider with ChangeNotifier{
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  DishesRestaurantModel? _dishesRestaurantModel;
  DishesRestaurantModel? get dishesRestaurantModel => _dishesRestaurantModel;

  Future<void> getRestaurantByDishes(BuildContext context,String dishesId) async {
    _isFetching = true;
    notifyListeners();

    try {
      String url = AppConfig.GET_DISHES_RESTAURANT + dishesId.toString();
      var response = await callGetMethod(url);
      print('========url===${url}');
      print('========restaurantDishes===${json.decode(response)}');

      _dishesRestaurantModel = DishesRestaurantModel.fromJson(json.decode(response));
      print('===restaurantDishes===${_dishesRestaurantModel?.results}');
      // print('==restaurantProduct===${_restaurantProductModel?.results?.length}');

      if (_dishesRestaurantModel != null && _dishesRestaurantModel?.results != null) {

        print('========lengthRestaurant-====${_dishesRestaurantModel?.results?.restaurants?.length}');
        // print('========rep${restaurantProductModel?.results!.first}');
        // print('========rep${restaurantProductModel?.results?[1].categories}');

      } else {
        _dishesRestaurantModel =
            DishesRestaurantModel(
                status: false,
                msg: _dishesRestaurantModel?.errors?.errorMessage.toString() ?? ""
              // 'Internal Server Issue'
            );
      }
    } catch (e) {

      print(e.toString()+"=----catch");
      _isFetching=false;
      _dishesRestaurantModel =
          DishesRestaurantModel(
              status: false,
              msg: _dishesRestaurantModel?.errors?.errorMessage.toString() ?? ""
            // 'Internal Server Issue'
          );
    }

    _isFetching = false;
    notifyListeners();
  }
}