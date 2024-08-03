import 'dart:convert';

import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/network_repository.dart';
import 'package:buyer_app/models/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  bool _isFetching = false;
  bool _isLoading = false;

  bool get isFetching => _isFetching;
  bool get isLoading => _isLoading;

  ProfileModel? _profileModel;

  ProfileModel? get profileModel => _profileModel;

  Future<void> getMyProfile(BuildContext context) async {
    _isFetching = true;
    // notifyListeners();
    try {

      var response = await callGetMethodWitAuth(AppConfig.GET_MY_PROFILE);
      print('getMyProfile==>${json.decode(response)}');

      _profileModel = ProfileModel.fromJson(json.decode(response));

      if (_profileModel != null && _profileModel?.results != null) {

      } else {
        _profileModel = ProfileModel(status: false, msg: _profileModel?.errors?.errorMessage.toString() ?? ""
        );
      }
    } catch (e) {
      print(e.toString() + "=----catch my profile");
      _isFetching = false;
      _profileModel = ProfileModel(status: false, msg: _profileModel?.errors?.errorMessage.toString() ?? ""
      );
    }

    _isFetching = false;
    notifyListeners();
  }
}