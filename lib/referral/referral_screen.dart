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

import '../global/constants.dart';
import '../global/global.dart';
import '../global/responsive.dart';

class ReferralScreen extends StatefulWidget {
  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  TextEditingController referralCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMyProfile();
  }

  Future<void> getMyProfile() async {
    final ordersProvider = Provider.of<ProfileProvider>(context, listen: false);
    await ordersProvider.getMyProfile(context).then((value){
      if(ordersProvider.profileModel != null && ordersProvider.profileModel!.results != null && ordersProvider.profileModel!.results!.user != null) {
        referralCodeController.text = ordersProvider.profileModel!.results!.user!.referralCode ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green,
                        Colors.green,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
              ),
              title: const Text(
                "Referral",
                style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
              ),
              centerTitle: true,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
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
                  ),

                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );


  }
}


