import 'dart:convert';

import 'package:buyer_app/RestaurantScreen/model/ProductViewModel.dart';
import 'package:buyer_app/address/model/address_details_model.dart';
import 'package:buyer_app/address/model/restaurant_timing_model.dart';
import 'package:buyer_app/cart/model/AddtoCartModel.dart';
import 'package:buyer_app/cart/model/CartModel.dart';
import 'package:buyer_app/cart/model/RemoveCartModel.dart';
import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/network_repository.dart';
import 'package:flutter/material.dart';

import '../models/change_delivery_address_model.dart';
import '../models/discount_model.dart';

 ValueNotifier<int> cartQuantity = ValueNotifier<int>(0);
class CartProvider with ChangeNotifier {
  bool _isFetching = false;
  bool _isLoading = false;
  bool _isCouponLoading = false;
  bool _isGiftCardLoading = false;

  bool get isFetching => _isFetching;
  bool get isLoading => _isLoading;
  bool get isCouponLoading => _isCouponLoading;
  bool get isGiftCardLoading => _isGiftCardLoading;
  CartModel? _cartModel;

  CartModel? get cartModel => _cartModel;
  AddtoCartModel? _addtoCartModel;

  AddtoCartModel? get addtoCart => _addtoCartModel;
  RemoveCartModel? _removeCartModel;

  RemoveCartModel? get removeCartModel => _removeCartModel;

  ProductViewModel? _productViewModel;

  ProductViewModel? get productViewModel => _productViewModel;

  AddressDetailsModel? _addressDetailsModel;
  AddressDetailsModel? get addressDetailsModel => _addressDetailsModel;

  RestaurantTimingModel? _restaurantTimingModel;
  RestaurantTimingModel? get restaurantTimingModel => _restaurantTimingModel;

  DiscountModel? _discountModel;
  DiscountModel? get discountModel => _discountModel;

  ChangeDeliveryAddressModel? setChangeDeliveryAddressModel;
  ChangeDeliveryAddressModel? get getChangeDeliveryAddressModel => setChangeDeliveryAddressModel;

  Future<void> getCartDetails(BuildContext context) async {
    _isFetching = true;
    notifyListeners();
    try {
      // String url = "${AppConfig.GET_CART}?cartToken=bb5ad13ff345f740a599f36ae3df0b";
      String url =
          "${AppConfig.GET_CART}?cartToken=${PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) != "null" && PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) != null ? PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) : ' '!}";
      // +"?"+"";
      var response = await callGetMethod(url);
      print('========_cartModel===${json.decode(response)}');

      _cartModel = CartModel.fromJson(json.decode(response));
      print('===_cartModel===${_cartModel?.results}');

      if (_cartModel != null && _cartModel?.results != null) {
        print('========Cart==length${_cartModel?.results?.carts?.length}');
        print('========CartQTY==length${_cartModel?.results?.cartQty}');

        cartQuantity.value = int.parse(_cartModel?.results?.cartQty == null ? "0":_cartModel?.results?.cartQty.toString() ?? "0");

        if (_cartModel?.results?.carts == null || _cartModel?.results?.carts?.length == 0) {
          PreferenceHelper.setString(PreferenceHelper.CART_TOKEN, "");
        }
      } else {
        _cartModel = CartModel(status: false, msg: _cartModel?.errors?.errorMessage.toString() ?? ""
            // 'Internal Server Issue'
            );
      }
    } catch (e) {
      print(e.toString() + "=----catchget cart");
      _isFetching = false;
      _cartModel = CartModel(status: false, msg: _cartModel?.errors?.errorMessage.toString() ?? ""
          // 'Internal Server Issue'
          );
    }

    _isFetching = false;
    notifyListeners();
  }

  Future<void> addToCart(
    BuildContext context,
    int? productId,
    String? productName,
    String qty,
    String? size,
    String saus,
  ) async {
    _isFetching = true;
    notifyListeners();
    Map<String, dynamic> body = {
      "product_id": productId ?? "",
      "product_name": productName ?? "",
      "quantity": qty ?? "",
      "size": size ?? "",
      "saus": saus ?? "",
      // "cartIdentifier": PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) != "" ? PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) : "",
      "cartIdentifier": PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) ?? ' ',
      // "cartIdentifier":  "050fdf7019cf1a67dc2f333de0438d",
      // "cartIdentifier": "",
    };

    print('========pramas==${body}');
    try {
      String url = AppConfig.ADD_TO_CART;
      var response = await callPostMethod(url, body);
      print('========_addtoCartModelrep${json.decode(response)}');
      _addtoCartModel = AddtoCartModel.fromJson(json.decode(response));
      print('========_addtoCartModel${_addtoCartModel?.results}');
      print('========_addtoCartModel${_addtoCartModel?.results?.message}');
      if (_addtoCartModel != null && _addtoCartModel?.results != null) {
        // print('========cartItems${_addtoCartModel?.results?.cartItems}');
        print('========returnCartToken${_addtoCartModel?.results?.returnCartToken}');
        // String? returnToken = _addtoCartModel?.results?.returnCartToken?.toString();
        // AppUtils.showMessage(
        //     context: context,
        //     message: "Successfully Added on Your Cart",
        //     backgroundColor: AppColor.colorGreen);
        /*  AppUtils.showMessage(
                        context: context,
                        message: '${postMdlCart.addtoCart?.results?.message}',
                        backgroundColor: AppColor.colorGreen);*/
        cartQuantity.value++;
      } else {
        _addtoCartModel = AddtoCartModel(status: false, msg: _addtoCartModel?.errors?.errorMessage.toString() ?? ""
            // 'Internal Server Issue'
            );

        // AppUtils.showMessage(
        //     context: context,
        //     message: _addtoCartModel?.errors!.errorMessage.toString(),
        //     backgroundColor: AppColor.colorRedLight);
      }
    } catch (e) {
      print(e.toString() + "=----catchadd");
      _isFetching = false;

      // return result;
    }
    _isFetching = false;
    notifyListeners();
  }

  Future<void> removeFromCart(BuildContext context, String? rowId) async {
    _isFetching = true;
    notifyListeners();
    Map<String, dynamic> body = {
      // ?cartToken=7c166de83d4a0123ac96c06a79dd0b&rowId=62045f5576df98e7af933e5ce1c768f8
      // "cartToken": "bb5ad13ff345f740a599f36ae3df0b",
      "cartToken": PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) ?? '',
      "rowId": rowId ?? "",
    };

    print('========pramas==${body}');
    print('========CART_TOKEN==${PreferenceHelper.getString(PreferenceHelper.CART_TOKEN)}');
    try {
      String url = AppConfig.REMOVE_CART;
      var response = await callDeleteMethod(url, body);
      print('========_removeCartModelrep${json.decode(response)}');
      _removeCartModel = RemoveCartModel.fromJson(json.decode(response));
      print('========_removeCartMode${_removeCartModel?.results}');
      print('========_Model${_removeCartModel?.results}');

      if (_removeCartModel != null && _removeCartModel?.results != null && _removeCartModel?.status == true) {
        AppUtils.showMessage(context: context, message: '${_removeCartModel?.results}', backgroundColor: AppColor.colorGreen);
        cartQuantity.value--;
      } else {
        // AppUtils.showMessage(
        //     context: context,
        //     message: _addtoCartModel?.errors!.errorMessage.toString(),
        //     backgroundColor: AppColor.colorRedLight);
      }
    } catch (e) {
      print(e.toString() + "=----catchremove");
      _isFetching = false;

      // return result;
    }
    _isFetching = false;
    notifyListeners();
  }

  Future<void> incrementToCart(BuildContext context, String? rowId) async {
    _isFetching = true;
    notifyListeners();
    Map<String, dynamic> body = {
      // ?cartToken=7c166de83d4a0123ac96c06a79dd0b&rowId=62045f5576df98e7af933e5ce1c768f8

      // "cartToken": "bb5ad13ff345f740a599f36ae3df0b",
      "cartToken": PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) ?? '',
      "rowId": rowId ?? "",
    };

    print('========pramas==${body}');
    print('========CART_TOKEN==${PreferenceHelper.getString(PreferenceHelper.CART_TOKEN)}');

    try {
      String url = AppConfig.INCREMENT_CART;
      var response = await callGetMethodwithParam(url, body);
      print('========_incrementtoCartModelrep${json.decode(response)}');

      // AppUtils.showMessage(
      //     context: context,
      //     message: "Item Increment",
      //     backgroundColor: AppColor.colorRedLight);

      // } else {
      //
      // }
    } catch (e) {
      print(e.toString() + "=----catchadd");
      _isFetching = false;

      // return result;
    }
    _isFetching = false;
    notifyListeners();
  }

  Future<void> decrementToCart(BuildContext context, String? rowId) async {
    _isFetching = true;
    notifyListeners();
    Map<String, dynamic> body = {
      // ?cartToken=7c166de83d4a0123ac96c06a79dd0b&rowId=62045f5576df98e7af933e5ce1c768f8

      // "cartToken": "bb5ad13ff345f740a599f36ae3df0b",
      "cartToken": PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) ?? '',
      "rowId": rowId ?? "",
    };

    print('========pramas==${body}');
    print('========CART_TOKEN==${PreferenceHelper.getString(PreferenceHelper.CART_TOKEN)}');

    try {
      String url = AppConfig.DECREMENT_CART;
      var response = await callGetMethodwithParam(url, body);
      print('========_decrementtoCartModelrep${json.decode(response)}');

      // AppUtils.showMessage(
      //     context: context,
      //     message: "Item Increment",
      //     backgroundColor: AppColor.colorRedLight);

      // } else {
      //
      // }
    } catch (e) {
      print(e.toString() + "=----catchadd");
      _isFetching = false;

      // return result;
    }
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getProductViewModelData(BuildContext context, String? productID) async {
    _isFetching = true;
    notifyListeners();
    try {
      String url =
          "${AppConfig.PRODUCT_VIEW_MODEL}$productID}";

      var response = await callGetMethod(url);
      print('========_cartModel===${json.decode(response)}');

      _productViewModel = ProductViewModel.fromJson(json.decode(response));
      print('===_productViewModel===${_productViewModel?.results}');

      if (_productViewModel != null && _productViewModel?.results != null) {

      } else {
        _productViewModel = ProductViewModel(status: false, msg: _productViewModel?.errors?.errorMessage.toString() ?? ""
          // 'Internal Server Issue'
        );
      }
    } catch (e) {
      print(e.toString() + "=----catchget cart");
      _isFetching = false;
      _productViewModel = ProductViewModel(status: false, msg: _productViewModel?.errors?.errorMessage.toString() ?? ""
      );
    }

    _isFetching = false;
    notifyListeners();
  }

  Future<void> getAddressDetails(BuildContext context) async {
    _isFetching = true;
    // notifyListeners();
    try {

      var response = await callGetMethodWitAuth(AppConfig.GET_ADDRESS_DETAILS);
      print('getAddress==>${json.decode(response)}');

      _addressDetailsModel = AddressDetailsModel.fromJson(json.decode(response));

      if (_addressDetailsModel != null && _addressDetailsModel?.results != null) {

      } else {
        _addressDetailsModel = AddressDetailsModel(status: false, msg: _addressDetailsModel?.errors?.errorMessage.toString() ?? ""
        );
      }
    } catch (e) {
      print(e.toString() + "=----catchget address");
      _isFetching = false;
      _addressDetailsModel = AddressDetailsModel(status: false, msg: _addressDetailsModel?.errors?.errorMessage.toString() ?? ""
      );
    }

    _isFetching = false;
    notifyListeners();
  }

  Future<dynamic> addAddressDetails(BuildContext context, Map<String, dynamic> body) async {
    _isFetching = true;
    notifyListeners();

    print('========pramas==${body}');
    try {
      var response = await callPostMethodWithAuth(AppConfig.ADD_NEW_ADDRESS, body);
      print('addAddress==>${json.decode(response)}');
      _isFetching = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print(e.toString() + "=----catchadd");
      _isFetching = false;
      notifyListeners();
      return null;
      // return result;
    }
    // _isFetching = false;
    // notifyListeners();
  }

  Future<dynamic> changeDeliveryAddress(BuildContext context, String addressId, {String? orderType}) async {
    _isFetching = true;
    notifyListeners();
    try {
      final bodyParams = {
        "address_id" : addressId,
        "resturant_id" : cartModel!.results!.restaurantId,
        "order_type" : orderType == "Delivery" ? "is_delivery":"is_takeaway",
      };
      var response = await callPostMethodWithAuth("${AppConfig.CHANGE_DELIVERY_ADDRESS}", bodyParams);
      print('changeAddress==>${(response)}');
      setChangeDeliveryAddressModel = ChangeDeliveryAddressModel.fromJson(json.decode(response));

      if (setChangeDeliveryAddressModel != null && setChangeDeliveryAddressModel?.results != null) {

      } else {
        setChangeDeliveryAddressModel = ChangeDeliveryAddressModel(status: false, msg: setChangeDeliveryAddressModel?.errors?.errorMessage.toString() ?? ""
        );
      }
      _isFetching = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print(e.toString() + "=----catch change address");
      _isFetching = false;
      notifyListeners();
      setChangeDeliveryAddressModel = ChangeDeliveryAddressModel(status: false, msg: setChangeDeliveryAddressModel?.errors?.errorMessage.toString() ?? ""
      );
      return null;
    }

  }

  Future<void> getRestaurantTimingDetails(BuildContext context, String restoId) async {
    _isFetching = true;
    // notifyListeners();
    try {

      var response = await callGetMethod(AppConfig.GET_TIME_SLOT+"/$restoId");
      print('getTiming==>${json.decode(response)}');

      _restaurantTimingModel = RestaurantTimingModel.fromJson(json.decode(response));

      if (_restaurantTimingModel != null && _restaurantTimingModel?.results != null) {

      } else {
        _restaurantTimingModel = RestaurantTimingModel(status: false, msg: _restaurantTimingModel?.errors?.errorMessage.toString() ?? ""
        );
      }
    } catch (e) {
      print(e.toString() + "=----catchget timing");
      _isFetching = false;
      _restaurantTimingModel = RestaurantTimingModel(status: false, msg: _restaurantTimingModel?.errors?.errorMessage.toString() ?? ""
      );
    }

    _isFetching = false;
    notifyListeners();
  }


  Future<void> calculateDiscount(BuildContext context, String restoId) async {
    _isFetching = true;
    // notifyListeners();
    try {
      final bodyParams = {
        "restaurant_id": restoId
      };
      print("bodyParams==>$bodyParams");
      var response = await callPostMethodWithAuth(AppConfig.CALCULATE_DISCOUNT, bodyParams, accept:"application/json");
      print('discount==>${response}');
      print('discount==>${json.decode(response)}');

      _discountModel = DiscountModel.fromJson(json.decode(response));

      if (_discountModel != null && _discountModel?.results != null) {

      } else {
        _discountModel = DiscountModel(status: false, msg: _discountModel?.errors?.errorMessage.toString() ?? ""
        );
      }
    } catch (e) {
      print(e.toString() + "=----catchget timing");
      _isFetching = false;
      _discountModel = DiscountModel(status: false, msg: _discountModel?.errors?.errorMessage.toString() ?? ""
      );
    }

    _isFetching = false;
    notifyListeners();
  }

  Future<dynamic> codPaymentOrder(BuildContext context, Map<String, dynamic> body) async {
    _isLoading = true;
    notifyListeners();

    print('========pramas==${body}');
    try {
      var response = await callPostMethodWithAuth(AppConfig.COD_PAYMENT, body);
      print('cod==>${json.decode(response)}');
      _isLoading = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print(e.toString() + "=----catchadd");
      _isLoading = false;
      notifyListeners();
      return null;
      // return result;
    }
    // _isFetching = false;
    // notifyListeners();
  }

  Future<dynamic> molliePaymentOrder(BuildContext context, Map<String, dynamic> body) async {
    _isLoading = true;
    notifyListeners();

    print('========pramas==${body}');
    try {
      var response = await callPostMethodWithAuth(AppConfig.MOLLIE_PAYMENT, body);
      print('mollie==>${json.decode(response)}');
      _isLoading = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print(e.toString() + "=----catchadd");
      _isLoading = false;
      notifyListeners();
      return null;
      // return result;
    }
    // _isFetching = false;
    // notifyListeners();
  }

  Future<dynamic> applyCouponCode(BuildContext context, Map<String, dynamic> body) async {
    _isCouponLoading = true;
    notifyListeners();

    print('========pramas==${body}');
    try {
      var response = await callPostMethodWithAuth(AppConfig.APPLY_CART_COUPON, body);
      print('cod==>${json.decode(response)}');
      _isCouponLoading = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print(e.toString() + "=----catchadd");
      _isCouponLoading = false;
      notifyListeners();
      return null;
      // return result;
    }
    // _isFetching = false;
    // notifyListeners();
  }


  Future<dynamic> applyGiftCouponCode(BuildContext context, Map<String, dynamic> body) async {
    _isGiftCardLoading = true;
    notifyListeners();

    print('========pramas==${body}');
    try {
      var response = await callPostMethodWithAuth(AppConfig.APPLY_CART_GIFT_COUPON, body);
      print('cod==>${json.decode(response)}');
      _isGiftCardLoading = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print(e.toString() + "=----catchadd");
      _isGiftCardLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<dynamic> changeOrderType(BuildContext context, String restoId, String type) async {
    _isFetching = true;
    notifyListeners();
    try {
      final bodyParams = {
        "restaurant_id" : restoId,
        "type" : type
      };
      print('changeOrderType==>${bodyParams}');
      var response = await callPostMethodWithAuth(AppConfig.CHANGE_ORDER_TYPE, bodyParams);
      print('changeOrderType==>${json.decode(response)}');
      _isFetching = false;
      notifyListeners();
      return json.decode(response);
    } catch (e) {
      print(e.toString() + "=----catchget changeOrderType");
      _isFetching = false;
      return null;
    }
  }
}
