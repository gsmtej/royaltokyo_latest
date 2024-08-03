import 'dart:convert';

import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/network_repository.dart';
import 'package:buyer_app/RestaurantScreen/model/RestaurantProductModel.dart';
import 'package:buyer_app/models/restaurant_list_model.dart';
import 'package:flutter/material.dart';

import '../models/gift_card_data_model.dart';
import '../models/user_gift_cards_model.dart';


class RestaurantProductProvider with ChangeNotifier{
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  RestaurantProductModel? _restaurantProductModel;
  RestaurantProductModel? get restaurantProductModel => _restaurantProductModel;
  int selectedCategoryIndexSet = 0;
  int get selectedCategoryIndex => selectedCategoryIndexSet;

  //Gift Cards
  bool _isFetchingGiftCards = false;
  bool get isFetchingGiftCards => _isFetchingGiftCards;
  GiftCardDataModel? _giftCardDataModel;
  GiftCardDataModel? get giftCardDataModel => _giftCardDataModel;

  //purchase
  bool _isPurchaseLoading = false;
  bool get isPurchaseLoading => _isPurchaseLoading;

  //user gift cards
  UserGiftCardsModel? _userGiftCardDataModel;
  UserGiftCardsModel? get userGiftCardDataModel => _userGiftCardDataModel;

  Future<void> getRestaurantProductCategories(BuildContext context,String restaurantId) async {
    _isFetching = true;
    notifyListeners();

    /*try {*/
      String url = AppConfig.GET_PRODUCT_CATEGORIES + restaurantId.toString();
      var response = await callGetMethod(url);
      print('========restaurantProduct===${json.decode(response)}');

      _restaurantProductModel = RestaurantProductModel.fromJson(json.decode(response));
      print('===restaurantProduct===${_restaurantProductModel?.results}');
      // print('==restaurantProduct===${_restaurantProductModel?.results?.length}');

      if (_restaurantProductModel != null && _restaurantProductModel?.results != null) {

        print('========length${_restaurantProductModel?.results?.category?.length}');
        // print('========rep${restaurantProductModel?.results!.first}');
        // print('========rep${restaurantProductModel?.results?[1].categories}');

      } else {
        _restaurantProductModel =
            RestaurantProductModel(
                status: false,
                msg: _restaurantProductModel?.errors?.errorMessage.toString() ?? ""
              // 'Internal Server Issue'
            );
      }
    /*} catch (e) {

      print(e.toString()+"=----catch");
      _isFetching=false;
      _restaurantProductModel =
          RestaurantProductModel(
              status: false,
              msg: _restaurantProductModel?.errors?.errorMessage.toString() ?? ""
            // 'Internal Server Issue'
          );
    }*/

    _isFetching = false;
    notifyListeners();
  }

  Future<void> getRestaurantGiftCards(BuildContext context,String restaurantId) async {
    _isFetchingGiftCards = true;
    notifyListeners();

    /*try {*/
    String url = AppConfig.GET_RESTAURANT_GIFT_CARDS + restaurantId.toString();
    var response = await callGetMethod(url);
    print('========giftCards===${json.decode(response)}');

    _giftCardDataModel = GiftCardDataModel.fromJson(json.decode(response));

    if (_giftCardDataModel != null && _giftCardDataModel?.results != null) {
    } else {
      _giftCardDataModel =
          GiftCardDataModel(
              status: false,
              msg: _giftCardDataModel?.errors?.errorMessage.toString() ?? ""
          );
    }

    _isFetchingGiftCards = false;
    notifyListeners();
  }

  Future<dynamic> purchaseGiftCards(BuildContext context, Map<String, dynamic> body) async {
    _isPurchaseLoading = true;
    notifyListeners();

    print('========pramas==${body}');
    try {
      var response = await callPostMethodWithAuth(AppConfig.PURCHASE_GIFT_CARDS, body);
      print('purchase==>${json.decode(response)}');
      _isPurchaseLoading = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print("$e=----catchadd");
      _isPurchaseLoading = false;
      notifyListeners();
      return null;
      // return result;
    }
  }

  Future<void> getUserGiftCards(BuildContext context) async {
    _isFetchingGiftCards = true;
    notifyListeners();

    String url = AppConfig.GET_USER_GIFT_CARDS;
    var response = await callGetMethodWitAuth(url);
    print('========giftCards===${json.decode(response)}');

    _userGiftCardDataModel = UserGiftCardsModel.fromJson(json.decode(response));

    if (_userGiftCardDataModel != null && _userGiftCardDataModel?.results != null) {
    } else {
      _userGiftCardDataModel =
          UserGiftCardsModel(
              status: false,
              msg: _userGiftCardDataModel?.errors?.errorMessage.toString() ?? ""
          );
    }
    _isFetchingGiftCards = false;
    notifyListeners();
  }

  Future<dynamic> transferGiftCards(BuildContext context, Map<String, dynamic> body) async {
    _isPurchaseLoading = true;
    notifyListeners();

    print('========pramas==${body}');
    try {
      var response = await callPostMethodWithAuth(AppConfig.USER_TRANSFER_GIFT_CARDS, body);
      print('purchase==>${json.decode(response)}');
      _isPurchaseLoading = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print("$e=----catchadd");
      _isPurchaseLoading = false;
      notifyListeners();
      return null;
    }
  }
}