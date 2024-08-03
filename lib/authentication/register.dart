import 'dart:io';

import 'package:buyer_app/controller/image_picker_controller.dart';
import 'package:buyer_app/global/AppConfig.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/route.dart';
import 'package:buyer_app/models/LoginModel.dart';
import 'package:buyer_app/providers/LoginProvider.dart';
import 'package:buyer_app/widgets/custom_text_field.dart';
import 'package:buyer_app/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import '../global/constants.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressRegiserController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController cityRegisterController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referrelCodeController = TextEditingController();

  bool isLoading = false;

  ImagePickerController controller = Get.put(ImagePickerController());

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String userImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

   Future<void> formValidation() async {
     final isValid = _formKey.currentState!.validate();
     if (!isValid) {
       return;
     }

     _formKey.currentState!.save();
     FocusManager.instance.primaryFocus?.unfocus();
     authenticateUserAndSignUp();

    // if (imageXFile == null) {
    //   showDialog(
    //       context: context,
    //       builder: (c) {
    //         return ErrorDialog(
    //           message: AppString.please_select_image,
    //         );
    //       }
    //       );
    // } else {
     /* if(passwordController.text == confirmPasswordController.text)
      {
        if(confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty)
        {
          //start uploading image
          // showDialog(
          //   context: context,
          //   builder: (c)
          //   {
          //     return const LoadingDialog(
          //       message: "Registering Account",
          //     );
          //   }
          // );
          //
          // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          // fStorage.Reference reference = fStorage.FirebaseStorage.instance
          //     .ref()
          //     .child("users")
          //     .child(fileName);
          // fStorage.UploadTask uploadTask =
          //     reference.putFile(File(imageXFile!.path));
          // fStorage.TaskSnapshot taskSnapshot =
          //     await uploadTask.whenComplete(() {});
          // await taskSnapshot.ref.getDownloadURL().then((url) {
          //   userImageUrl = url;

            //save info to firestore

          if(nameController.text.length >= 5){
            if(phoneController.text.length == 10){
              if(addressRegiserController.text.length >= 5){
                authenticateUserAndSignUp();

              }
              else{
                showDialog(
                    context: context,
                    builder: (c) {
                      return ErrorDialog(
                        message:
                        AppString.address_must_be_validate,
                      );
                    });
              }
            }
            else{
              showDialog(
                  context: context,
                  builder: (c) {
                    return ErrorDialog(
                      message:
                      AppString.please_enter_ten_digits_number,
                    );
                  });
            }
          }
          else{
            showDialog(
                context: context,
                builder: (c) {
                  return ErrorDialog(
                    message:
                    AppString.name_must_be_validate,
                  );
                });
          }

          // });
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorDialog(
                  message:
                      AppString.please_write_require_info_for_registeration,
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: AppString.passwrod_does_not_match,
              );
            });
      }
    // }*/
  }

  void authenticateUserAndSignUp() async {
    isLoading = true;
   /* User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
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
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        //send user to homePage
        Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }*/

    setState(() {
      isLoading = true;
    });


    LoginModel signUpModel =  await LoginProvider.registerUser(
        name: nameController.text.toString() ,
        email: emailController.text.toString(),
        phone: phoneController.text.toString(),
        address_register: addressRegiserController.text.toString(),
        postcode_register: postcodeController.text.toString(),
        city_register: cityRegisterController.text.toString(),
        password: passwordController.text.toString(),
        password_confirmation: confirmPasswordController.text.toString(),
        referral_code: referrelCodeController.text.trim().toString(),
        context: context);

    if (signUpModel.status == true) {
      // userInfo = signUpModel.results?.user;
      // print('====userInfo${userInfo!.email}');
      // PreferenceHelper.setBool(PreferenceHelper.IS_LOGIN, true);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      // RouteName.home, arguments: false, (route) => false);
      // print('====userInfo${userInfo!.email}');
      // PreferenceHelper.setString(PreferenceHelper.NAME,);
      // nameController.clear();
      // emailController.clear();
      // passwordController.clear();
      // Navigator.pop(context);

      PreferenceHelper.setString("name", signUpModel.results!.user!.name ?? "");
      PreferenceHelper.setString(PreferenceHelper.PHOTO_URL, signUpModel.results!.user!.profilePhotoPath ?? "");
      AppUtils.showMessage(
          context: context,
          message: signUpModel.results!.message.toString(),
          backgroundColor: AppColor.colorGreen);

    /*  if(signUpModel.errors?.validationMessage != []){
        AppUtils.showMessage(
            context: context,
            message: signUpModel.errors?.validationMessage?[0].email.toString(),
            backgroundColor: AppColor.colorRedLight);
      }
      else{

        AppUtils.showMessage(
            context: context,
            message: signUpModel.results!.message.toString(),
            backgroundColor: AppColor.colorGreen);

        nameController.clear();
        emailController.clear();
        passwordController.clear();
        Navigator.pop(context);

      }*/
    } else {
      Constants.showToast(signUpModel.errors?.validationMessage![0].email ?? signUpModel.errors?.validationMessage![0].password ?? "");
      /*AppUtils.showMessage(
          context: context,
          message: "signUpModel.errors?.validationMessage?[0].email.toString()",
          backgroundColor: AppColor.colorRedLight);*/
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState()
  {
    //TODO : implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
         /* const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage:
                  imageXFile == null ? null : FileImage(File(imageXFile!.path)),
              child: imageXFile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      size: MediaQuery.of(context).size.width * 0.20,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),*/
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.person,
                  controller: nameController,
                  hintText: AppString.name,
                  isObsecre: false,
                  validator: (value) {
                    if (value != null) {
                      if (value.trim() == "") {
                        return "Please enter valid name";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter valid name";
                    }
                  },
                ),
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
                CustomphoneField(
                  data: Icons.phone,
                  controller: phoneController,
                  hintText: AppString.phone,
                  isObsecre: false,
                  validator: (value) {
                    if (value != null) {
                      if (value.trim() == "") {
                        return "Please enter valid phone number";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter valid phone number";
                    }
                  },
                ),
                CustomTextField (
                  data: Icons.place,
                  controller: addressRegiserController,
                  hintText: AppString.address,
                  isObsecre: false,
                  validator: (value) {
                    if (value != null) {
                      if (value.trim() == "") {
                        return "Please enter valid address";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter valid address";
                    }
                  },
                ),
                CustomphoneField(
                  data: Icons.place,
                  controller: postcodeController,
                  hintText: AppString.postcode,
                  isObsecre: false,
                  validator: (value) {
                    if (value != null) {
                      if (value.trim() == "") {
                        return "Please enter valid postcode";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter valid postcode";
                    }
                  },
                ),
                CustomTextField (
                  data: Icons.place,
                  controller: cityRegisterController,
                  hintText:AppString.city,
                  isObsecre: false,
                  validator: (value) {
                    if (value != null) {
                      if (value.trim() == "") {
                        return "Please enter valid city";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter valid city";
                    }
                  },
                ),
                CustomTextField (
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
                CustomTextField (
                  data: Icons.lock,
                  controller: confirmPasswordController,
                  hintText:  AppString.confirm_password,
                  isObsecre: true,
                  validator: (value) {
                    if (value != null) {
                      if (value.trim() == "") {
                        return "Please enter valid confirm password";
                      } else if (value.trim() != passwordController.text.trim()) {
                        return "Confirm password doesn't match";
                      } else {
                        return null;
                      }
                    } else {
                      return "Confirm password doesn't match";
                    }
                  },
                ),
                CustomTextField (
                  data: Icons.egg_alt_rounded,
                  controller: referrelCodeController,
                  hintText:AppString.referralCode,
                  isObsecre: false,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {
              formValidation();
            },
            child: isLoading ? const CupertinoActivityIndicator(color: Colors.white, radius: 10,) : const Text(
              AppString.sign_up,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
