import 'package:buyer_app/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';


class LoginBackendScreen extends StatefulWidget {
  const LoginBackendScreen({Key? key}) : super(key: key);

  @override
  State<LoginBackendScreen> createState() => _LoginBackendScreenState();
}

class _LoginBackendScreenState extends State<LoginBackendScreen> {

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Login GetX'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.emailController.value,
                decoration: const InputDecoration(
                  hintText: 'Email'
                ),
              ),
              TextFormField(
                controller: controller.passwordController.value,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Password'
                ),
              ),
              const SizedBox(height: 40,),
              Obx(() => InkWell(
                onTap: (){
                  controller.loginBackendApi();
                },
                child: controller.loading.value ? const Center(child: CircularProgressIndicator()) :  Container(
                  height: 45,
                  color: Colors.green,
                  child: const Center(child: Text('Login')),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}