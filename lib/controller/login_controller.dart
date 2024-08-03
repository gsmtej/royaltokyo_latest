import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class LoginController extends GetxController {
  
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  RxBool loading = false.obs ;


  void  loginBackendApi() async{
    loading.value = true ;
    try{

      final response = await post(Uri.parse('https://restauranthub.be/api/login'),
      body: {
        "email": emailController.value.text.toString(),
        "password": passwordController.value.text.toString()
      });

      var data = jsonDecode(response.body);

      if(response.statusCode ==200){
        loading.value = false ;
        print(data);
        Get.snackbar('Login',  'login successfully');

      }else {
        loading.value = false ;
        Get.snackbar('Login',  data['error']);
      }
    }
    catch(e){
      loading.value = false ;
      Get.snackbar('Error', e.toString());
    }
  }
}