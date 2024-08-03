import 'dart:convert';

import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/network_repository.dart';
import 'package:buyer_app/global/route.dart';
import 'package:buyer_app/models/LoginModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {
  bool _isFetching = false;
  bool _isUploading = false;

  bool get isFetching => _isFetching;

  bool get isUploading => _isUploading;

  LoginModel? _loginModel;

  LoginModel? get loginModel => _loginModel;

  static Future<LoginModel> loginUser(
      {String? email, String? pass, required BuildContext context}) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": pass,
      "device_token": PreferenceHelper.getString(PreferenceHelper.FCM_TOKEN),
    };
    try {
      String endPoint = AppConfig.LOGIN;
      var response = await callPostMethod(endPoint, body);
      LoginModel result = LoginModel.fromJson(json.decode(response));
      print('===sass${response}');
      if (result.status == true) {
        PreferenceHelper.setString(PreferenceHelper.USER_DATA, result.results!.user.toString());
        PreferenceHelper.setBool(PreferenceHelper.IS_LOGIN, true);
        PreferenceHelper.setString(PreferenceHelper.AUTH_TOKEN, result.results!.token.toString());
        PreferenceHelper.setString(PreferenceHelper.MOLLIE_KEY, result.results!.mollieKey.toString());
        PreferenceHelper.setString(PreferenceHelper.NAME,"${result.results?.user?.name.toString()}");
        PreferenceHelper.setString(PreferenceHelper.ID,"${result.results?.user?.id.toString()}");

        print("userData---"+PreferenceHelper.USER_DATA);
      } else {
         LoginModel(status: false,msg: result.errors!.errorMessage!.toString());
        // ,: 'Internal Server Issue'
      }
      return result;
    } catch (e) {
      print('=======${e.toString()}');
      LoginModel result = LoginModel(status: false, errors : Errors(errorMessage: "Credentials are wrong"), msg: "Internal Server Issue");
      return result;
    }
  }

/*  googleLogin(
      {String? google_id,
        String? name,
        String? email,
        String? firebase_token,
        required BuildContext context}) async {
    Map<String, dynamic> body = {
      "google_id": google_id,
      "name": name,
      "email": email,
      "firebase_token": firebase_token,
    };
    try {
      String endPoint = AppConfig.GOOGLE_LOGIN;
      var response = await callPostMethod(endPoint, body);
      print('===sass${response}');
      LoginModel loginModel = LoginModel.fromJson(json.decode(response));
      //
      if (loginModel.success == true) {
        print('===dddddddd${response}');
        PreferenceHelper.setBool(PreferenceHelper.IS_LOGIN, true);
        PreferenceHelper.setString(PreferenceHelper.NAME,'${loginModel.data?.name.toString()}');
        PreferenceHelper.setString(PreferenceHelper.ID,"${loginModel.data?.id.toString()}");
        PreferenceHelper.setString(PreferenceHelper.AUTH_TOKEN,
            loginModel.data?.accessToken??'');
        PreferenceHelper.setString(
            PreferenceHelper.USER_DATA, response.toString());

      } else {
        LoginModel result =
        LoginModel(success: false, message: 'Internal Server Issue');
      }
      return loginModel;
    } catch (e) {
      print('=======${e.toString()}');
      LoginModel result =
      LoginModel(success: false, message: 'Internal Server Issue');
      return result;
    }
  }*/

  static Future<LoginModel> registerUser(
      {String? name,
      String? email,
      String? phone,
      String? address_register,
      String? postcode_register,
      String? city_register,
      String? password,
      String? password_confirmation,
      String? referral_code,
      required BuildContext context}) async {
    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "phone": phone,
      "address_register": address_register,
      "postcode_register": postcode_register,
      "city_register": city_register,
      "password": password,
      "password_confirmation": password_confirmation,
      "referral_code": referral_code,
      "device_token": PreferenceHelper.getString(PreferenceHelper.FCM_TOKEN),
    };
    try {
      String endPoint = AppConfig.REGISTER;
      var response = await callPostMethod(endPoint, body);
      LoginModel result = LoginModel.fromJson(json.decode(response));
      print('===sass${response}');
      print('===sass${{json.decode(response)}}');
      if (result.status == true) {
        PreferenceHelper.setBool(PreferenceHelper.IS_LOGIN, true);
        // PreferenceHelper.setString(PreferenceHelper.USER_DATA, response.toString());
        // PreferenceHelper.setString(PreferenceHelper.USER_DATA, result.results!.user.toString());
        // PreferenceHelper.setString(PreferenceHelper.AUTH_TOKEN, result.results!.token.toString());
        // PreferenceHelper.setString(PreferenceHelper.NAME,"${result.results?.user?.name.toString()}");
        // PreferenceHelper.setString(PreferenceHelper.ID,"${result.results?.user?.id.toString()}");
        //
        // print("userData---"+PreferenceHelper.USER_DATA);
        AppUtils.showMessage(
            context: context,
            message: result.results?.message.toString(),
            backgroundColor: AppColor.colorGreen);

        Navigator.pop(context);
        return result;
        }
      // else {
      //     LoginModel(status: false,msg: result.msg.toString());
      //     // ,: 'Internal Server Issue'
      //   }
        return result;
      } catch (e) {
      print('=======${e.toString()}');
      LoginModel result = LoginModel(status: false, errors : Errors(errorMessage: "Something went wrong. Please try again later."), msg: "Internal Server Issue");
      return result;
    }
  }
}
