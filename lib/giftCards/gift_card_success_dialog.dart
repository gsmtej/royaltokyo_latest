import 'package:buyer_app/giftCards/gift_cards_screen.dart';
import 'package:buyer_app/global/constants.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:buyer_app/home/home_screen.dart';
import 'package:buyer_app/orders/my_orders_screen.dart';
import 'package:flutter/material.dart';

Future<bool> giftCardPurchasedSuccessDialog(BuildContext context, {String? title, String? price}) async {
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
                  mainAxisSize : MainAxisSize.min,
                  children: [

                    Image.asset(
                      "assets/images/ic_order_successfully.png",
                      height: 160,
                      width: 160,
                    ),

                    SizedBox(height: 10,),

                    Text(
                      title ?? "",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
                    ),

                    SizedBox(height: 10,),

                    Text(
                      "Gift card purchased successfully!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 16),
                    ),

                    SizedBox(height: 10,),

                    Text(
                      "Amount : € $price",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: Constants.buttonStyle(),
                              onPressed: () async {
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                const GiftCardsScreen(isFromPurchasedSuccess: true,)), (Route<dynamic> route) => false);
                              },
                              child:  const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'View Gift Cards',
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