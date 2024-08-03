
import 'dart:io';

import 'package:buyer_app/controller/image_picker_controller.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/providers/ProfileProvider.dart';
import 'package:buyer_app/widgets/custom_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../global/AppConfig.dart';
import '../global/PreferenceHelper.dart';
import '../global/constants.dart';
import '../global/global.dart';
import '../global/responsive.dart';
import 'package:http/http.dart' as http;


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController confirmNewEmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  ImagePickerController controller = Get.put(ImagePickerController());

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String userImageUrl = "";

  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      imageXFile = null;
    });
    super.initState();
    getMyProfile();
  }

  Future<void> getMyProfile() async {
    final ordersProvider = Provider.of<ProfileProvider>(context, listen: false);
    await ordersProvider.getMyProfile(context).then((value){
      if(ordersProvider.profileModel != null && ordersProvider.profileModel!.results != null && ordersProvider.profileModel!.results!.user != null) {
        nameController.text = ordersProvider.profileModel!.results!.user!.name ?? "";
        emailController.text = ordersProvider.profileModel!.results!.user!.email ?? "";
        phoneController.text = ordersProvider.profileModel!.results!.user!.phone ?? "";
        referralCodeController.text = ordersProvider.profileModel!.results!.user!.referralCode ?? "";
        userImageUrl = ordersProvider.profileModel!.results!.user!.profilePhotoPath ?? "";
        PreferenceHelper.setString(PreferenceHelper.PHOTO_URL, userImageUrl);
      }
    });
  }

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
    userProfileUpdate();
  }


  Future userProfileUpdate() async {

    setState(() {
      isLoading = true;
    });

    var postUri = Uri.parse(AppConfig.UPDATE_MY_PROFILE);
    var request = http.MultipartRequest("POST", postUri);

    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${PreferenceHelper.getString(PreferenceHelper.AUTH_TOKEN)}' ?? '';
    request.fields['name'] = nameController.text.toString();
    request.fields['phone'] = phoneController.text.toString();
    request.fields['email'] = emailController.text.toString();
    if (imageXFile != null) {
      request.files.add(await http.MultipartFile.fromPath("image", imageXFile!.path));
    }

    request.send().then((response) {
      if (response.statusCode == 200) {
        getMyProfile();
        AppUtils.showMessage(
            context: context,
            message: "Profile saved successfully.",
            backgroundColor: AppColor.colorGreen);
      } else {
        AppUtils.showMessage(
            context: context,
            message: "Something went wrong. Please try again later.",
            backgroundColor: AppColor.colorGreen);
      }
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor:   Colors.white,
            body: provider.isFetching || provider.profileModel == null
                ? AppUtils.showLoaderList()
                :SingleChildScrollView(
              child:  Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orange
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 12,bottom: 5),
                            child: Text(
                              AppString.profile_update,
                              textAlign: TextAlign.left, style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,),),
                          ),
                          InkWell(
                            onTap: () {
                              // _getImage();
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                                ),
                                builder: ((builder) => bottomSheet(context)),
                              );
                            },
                            child: imageXFile == null ? CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.20,
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.20),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: userImageUrl,
                            width: MediaQuery.of(context).size.width * 0.4,
                            placeholder: (context, url) {
                              return Image.asset('assets/loading.gif', fit: BoxFit.cover);
                            },
                            errorWidget: (context, url, error) => Image.asset('assets/loading.gif', fit: BoxFit.cover),
                          ),
                        ),
                      ) : CircleAvatar(
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
                          ),
                          const SizedBox(
                            height: 10,
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

                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 12,top: 10,bottom: 5),
                                  child: Text(
                                    AppString.update_password,
                                    textAlign: TextAlign.left, style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,),),
                                ),
                                CustomTextField (
                                  data: Icons.lock,
                                  controller: oldPasswordController,
                                  hintText: AppString.old_password,
                                  isObsecre: true,
                                ),
                                CustomTextField (
                                  data: Icons.lock,
                                  controller: newPasswordController,
                                  hintText: AppString.new_password,
                                  isObsecre: true,
                                ),
                                CustomTextField (
                                  data: Icons.lock,
                                  controller: confirmNewPasswordController,
                                  hintText:  AppString.confirm_new_password,
                                  isObsecre: true,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 12,top: 10,bottom: 5),
                                  child: Text(
                                    AppString.update_email_Address,
                                    textAlign: TextAlign.left, style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,),),
                                ),
                                CustomTextField(
                                  data: Icons.email,
                                  controller: newEmailController,
                                  hintText: AppString.new_email_Address,
                                  isObsecre: false,
                                ),    CustomTextField(
                                  data: Icons.email,
                                  controller: confirmNewEmailController,
                                  hintText: AppString.confirm_new_email_Address,
                                  isObsecre: false,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            child: isLoading ? const CupertinoActivityIndicator(color: Colors.white, radius: 10,) : const Text(
                              AppString.update_profile,
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
                        ],
                      ),
                    ),

                  /*  const SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.orange
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 12,bottom: 5),
                            child: Text(
                              AppString.referral,
                              textAlign: TextAlign.left, style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,),),
                          ),

                          GestureDetector(
                            onTap: () async {
                              print("click");
                              await Clipboard.setData(ClipboardData(text: referralCodeController.text ?? "", ), );
                              // Constants.showToast("Referral Code ${referralCodeController.text ?? ""} copied successfully!");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.only(left: 6.0, right: 15, bottom: 6, top: 6),
                              margin: const EdgeInsets.all(8),
                              child: TextFormField(
                                enabled: false,
                                controller: referralCodeController,
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.egg_alt_rounded,
                                    color: Colors.cyan,
                                  ),
                                  suffix: const Icon(
                                    Icons.copy,
                                    color: Colors.cyan,
                                    size: 22,
                                  ),
                                  focusColor: Theme.of(context).primaryColor,
                                  hintText: AppString.referralCode,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          AppString.referred_people,
                                          textAlign: TextAlign.left, style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,),),
                                      ),
                                      Container(
                                        width: Responsive.width(100, context),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.only(left: 12.0, right: 15, bottom: 12, top: 12),
                                        margin: const EdgeInsets.all(8),
                                        child:  Text(
                                          "${provider.profileModel!.results == null ? 0 : provider.profileModel!.results!.referral!.referredPeople ?? 0}",
                                          textAlign: TextAlign.left, style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,),),
                                      ),
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          AppString.total_commission_amount,
                                          maxLines: 1,
                                          textAlign: TextAlign.left, style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,),),
                                      ),
                                      Container(
                                        width: Responsive.width(100, context),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.only(left: 12.0, right: 15, bottom: 12, top: 12),
                                        margin: const EdgeInsets.all(8),
                                        child:  Text(
                                          "€ ${provider.profileModel!.results == null ? 0  : provider.profileModel!.results!.referral!.totalCommissionAmount ?? 0}",
                                          textAlign: TextAlign.left, style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,),),
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),*/

                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bottomSheet(context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose photo",
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera, color: Colors.black),
              onPressed: () {
                takePhoto(ImageSource.camera);
                Navigator.of(context).pop();
              },
              label: const Text(
                "Camera",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            SizedBox(width: 30),
            TextButton.icon(
              icon: const Icon(
                Icons.image,
                color: Colors.black,
              ),
              onPressed: () {
                takePhoto(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              label: const Text(
                "Gallery",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    var pickedFile = await _picker.pickImage(
      source: source,
    );
    if (pickedFile != null) {
      imageXFile = XFile(pickedFile.path);
    }
    setState(() {});
  }
}


