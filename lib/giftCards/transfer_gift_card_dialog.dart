import 'package:buyer_app/providers/RestaurantProductProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/constants.dart';

Future<bool> transferGiftCardDialog(BuildContext context, RestaurantProductProvider provider, String giftCardId) async {
  bool returnType = false;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();

  await showDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return Dialog(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          backgroundColor: Colors.white,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize : MainAxisSize.min,
                  children: [

                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Transer to friend",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Email Address",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child:  TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "Enter email address",
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Constants.hintColor, fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Constants.borderLightGrey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Constants.borderLightGrey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Constants.borderLightGrey,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(12))),
                      ),
                    ),

                    const SizedBox(height: 10,),
                    const Text(
                      "Must ensure that e-mail account already registered on resturanthub.",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 12),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all( const BorderSide(width: 1.0, color: Colors.orange)),
                                backgroundColor: MaterialStateProperty.all(Colors.white ),
                                elevation: MaterialStateProperty.all(0),
                                foregroundColor: MaterialStateProperty.all(Colors.transparent),
                                overlayColor: MaterialStateProperty.all(Colors.transparent),
                                shadowColor: MaterialStateProperty.all(Colors.transparent),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),),),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.orange ),
                                  elevation: MaterialStateProperty.all(0),
                                  foregroundColor: MaterialStateProperty.all(Colors.transparent),
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),)
                              ),
                              onPressed: () async {
                                if(emailController.text.trim().isNotEmpty){
                                  Map<String, dynamic> body = {
                                    "gift_card_id" : giftCardId,
                                    "email" : emailController.text.trim(),
                                  };
                                  setState((){
                                    isLoading=true;
                                  });
                                  await provider.transferGiftCards(context, body)
                                      .then((value) async {
                                    if(value != null && value["status"] == true){
                                      Constants.showToast("Gift cards transferred successfully!");

                                      Navigator.pop(context);
                                    }else{
                                      Constants.showToast(value["message"] == "null" ? "Something went wrong, please try again later" : value["message"]);
                                    }
                                  });
                                  setState((){
                                    isLoading=false;
                                  });
                                }else{
                                  Constants.showToast("Please valid email address.");
                                }


                              },
                              child:   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: provider.isPurchaseLoading ?
                                      const CupertinoActivityIndicator(color: Colors.white, radius: 10,):
                                  const Text(
                                    'Transfer',
                                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ));
    },
    // transitionDuration: const Duration(milliseconds: 300),
    barrierDismissible: false,
    barrierLabel: '',
    context: context,
    // pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    //   return const Text('');
    // }
  );

  return returnType;
}