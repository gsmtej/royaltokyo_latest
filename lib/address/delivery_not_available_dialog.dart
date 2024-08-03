import 'package:buyer_app/global/constants.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:flutter/material.dart';

import '../global/AppImages.dart';

Future<bool> deliveryNotAvailableDialog(BuildContext context, {String? title, String? description}) async {
  bool returnType = false;

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
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Image.asset(
                      "assets/images/ic_not_avail.jpg",
                      height: 150,
                      width: 150,
                    ),

                     Text(
                      title ?? "Delivery Is Not Available",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                    ),

                     Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        description ?? "Delivery Is Not Available On Your Address, Please Select Another Address.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: Constants.buttonStyle(),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child:  const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'OK',
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
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    // pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    //   return const Text('');
    // }
  );

  return returnType;
}