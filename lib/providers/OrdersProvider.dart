import 'dart:convert';

import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/network_repository.dart';
import 'package:buyer_app/models/my_orders_model.dart';
import 'package:flutter/material.dart';

class OrdersProvider with ChangeNotifier {
  bool _isFetching = false;
  bool _isLoading = false;

  bool get isFetching => _isFetching;
  bool get isLoading => _isLoading;

  MyOrdersModel? _myOrdersModel;

  MyOrdersModel? get myOrdersModel => _myOrdersModel;

  Future<void> getMyOrders(BuildContext context) async {
    _isFetching = true;
    // notifyListeners();
    try {

      var response = await callGetMethodWitAuth(AppConfig.MY_ORDERS);
      print('getMyOrders==>${json.decode(response)}');

      _myOrdersModel = MyOrdersModel.fromJson(json.decode(response));

      if (_myOrdersModel != null && _myOrdersModel?.results != null) {

      } else {
        _myOrdersModel = MyOrdersModel(status: false, msg: _myOrdersModel?.errors?.errorMessage.toString() ?? ""
        );
      }
    } catch (e) {
      print(e.toString() + "=----catch my orders");
      _isFetching = false;
      _myOrdersModel = MyOrdersModel(status: false, msg: _myOrdersModel?.errors?.errorMessage.toString() ?? ""
      );
    }

    _isFetching = false;
    notifyListeners();
  }
}