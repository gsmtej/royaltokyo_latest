import 'package:buyer_app/api_screens/restaurant_list_screen.dart';
import 'package:buyer_app/authentication/auth_screen.dart';
import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/AppImages.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/route.dart';
import 'package:buyer_app/home/home_screen.dart';
import 'package:buyer_app/models/LoginModel.dart';
import 'package:buyer_app/providers/LoginProvider.dart';
import 'package:buyer_app/widgets/custom_text_field.dart';
import 'package:buyer_app/widgets/error_dialog.dart';
import 'package:buyer_app/widgets/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/constants.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  formValidation() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();

    loginNow();

    /*if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login

    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: AppString.please_write_email_passwrod,
            );
          });
    }*/
  }

  loginNow() async {
/*
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingDialog(
            message: "Checking Credentials",
          );
        });

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }

*/

    setState(() {
      isLoading = true;
    });

    LoginModel loginModel = await LoginProvider.loginUser(
        email: emailController.text.toString(),
        pass: passwordController.text.toString(),
        context: context);

    if (loginModel.status != null && loginModel.status == true) {
      userInfo = loginModel.results?.user;
      print('====userInfo${userInfo?.email}');

      PreferenceHelper.setBool(PreferenceHelper.IS_LOGIN, true);
      PreferenceHelper.setString("name", userInfo?.name ?? "");
      PreferenceHelper.setString(PreferenceHelper.PHOTO_URL, userInfo?.profilePhotoPath ?? "");

      AppUtils.showMessage(
          context: context,
          message: loginModel.results?.message.toString(),
          backgroundColor: AppColor.colorGreen);
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeScreen(),
        ),
            (route) => false,
      );
     /* Navigator.pop(context);
      setState(() {

      });*/
      print("Login ");
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     RouteName.home, arguments: false, (route) => false);

    } else {
      AppUtils.showMessage(
          context: context,
          message: loginModel.errors!.errorMessage.toString(),
          backgroundColor: AppColor.colorRedLight);
    }
    setState(() {
      isLoading = false;
    });


  }


 /* Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!
            .setString("email", snapshot.data()!["email"]);
        await sharedPreferences!
            .setString("name", snapshot.data()!["name"]);
        await sharedPreferences!
            .setString("photoUrl", snapshot.data()!["photoUrl"]);

        List<String> userCartList = snapshot.data()!["userCart"].cast<String>();
        await sharedPreferences!
            .setStringList("userCart", userCartList);

        Navigator.pop(context);
        Navigator.push(
            // context, MaterialPageRoute(builder: (c) => const HomeScreen()));
            context, MaterialPageRoute(builder: (c) => const RestaurantListScreen()));
      } else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AuthScreen()));

        showDialog(
            context: context,
            builder: (c) {

              return ErrorDialog(
                message: "No Record Found.",
              );
            });
      }
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                AppImages.ic_login,
                height: 250,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: AppString.email,
                  isObsecre: false,
                  validator: (value) {
                    if (value != null && value.trim() != "") {
                      if (!Constants.isEmail(value.trim())) {
                        return "Please enter your valid email address";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter your valid email address";
                    }
                  },
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: AppString.password,
                  isObsecre: true,
                  validator: (value) {
                    if (value != null) {
                      if (value.trim() == "") {
                        return "Please enter valid password";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter valid password";
                    }
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            child:  isLoading ? const CupertinoActivityIndicator(color: Colors.white, radius: 10,) : Text(
              AppString.login,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {
              formValidation();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              AppString.click_to_register,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
