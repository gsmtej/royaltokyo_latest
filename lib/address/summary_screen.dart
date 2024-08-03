import 'package:buyer_app/address/model/address_details_model.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/constants.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:buyer_app/home/home_screen.dart';
import 'package:buyer_app/mollie_payment/MolliePaymentScreen.dart';
import 'package:buyer_app/orders/order_success_dialog.dart';
import 'package:buyer_app/providers/CartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/discount_model.dart';

class SummaryScreen extends StatefulWidget{
  final String? date;
  final String? hour;
  final String? orderType;
  final String? notes;
  final String? paymentType;
  final DefaultAddress? deliveryAddress;
  final DiscountModel? discountModel;
  const SummaryScreen({super.key, this.paymentType, this.date, this.hour, this.orderType,this.notes, this.deliveryAddress, this.discountModel});

  @override
  State<StatefulWidget> createState() {
    return SummaryScreenState();
  }
  
}
class SummaryScreenState extends State<SummaryScreen>{

  TextEditingController couponController = TextEditingController();
  String coupon = "";

  bool isCouponApplied = false;
  String couponDiscount = "0";

  TextEditingController giftCardController = TextEditingController(text: "");
  String giftcard = "";

  bool isGiftCardApplied = false;
  String giftCardDiscount = "0.0";

  String paymentType = "";

  @override
  void initState() {
    paymentType = widget.paymentType ?? "Bank";
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
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
             title:  const Text(
            "Summary",
            style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
          ),
          centerTitle: true,
            automaticallyImplyLeading: true,
          ),
          body: provider.isFetching
              ? AppUtils.showLoaderList():SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                        borderRadius:  BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 3.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: Responsive.width(100, context),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                            ),
                            child: const Column(
                              children:  [
                                Text(
                                  "Order Summary",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
                                ),
                                /*Text(
                                "Sushi Kioku Duffel",
                                style: TextStyle(color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w300, fontSize: 14),
                              ),*/
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                            child: Table(
                              border:  TableBorder.all(color: const Color(0xFFDEDEDE),  style: BorderStyle.solid, width: 0.7),
                              children: [
                                TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Date:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.date.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Time:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.hour.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Type:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.orderType.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Timing 1:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${provider.restaurantTimingModel!.results!.timing1.toString()}, ${provider.restaurantTimingModel!.results!.timing2.toString()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Timing 2:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${provider.restaurantTimingModel!.results!.timing3.toString()}, ${provider.restaurantTimingModel!.results!.timing4.toString()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 15, right: 15),
                            child: Text(
                              "My Cart",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                            child: Divider(color: Constants.borderLightGrey,height: 0.7,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: provider.cartModel?.results?.carts!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Flexible(
                                          child: Text(provider.cartModel?.results?.carts?[index].name ??
                                              "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: Colors.green,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            final postMdlCart = Provider.of<CartProvider>(
                                                context,
                                                listen: false);

                                            setState(() {
                                              postMdlCart
                                                  .removeFromCart(
                                                  context,
                                                  provider.cartModel?.results
                                                      ?.carts?[index].rowId
                                                      .toString())
                                                  .then((value) =>
                                              {postMdlCart.getCartDetails(context)});
                                            });
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(50)
                                              ),
                                              child: const Icon(Icons.close, color: Colors.white,size: 15)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),

                                    RichText(
                                        textAlign: TextAlign.center,
                                        text:  TextSpan(children: [
                                          const TextSpan(
                                            text: "Size : ",
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
                                          ),
                                          TextSpan(
                                            text: provider.cartModel?.results?.carts?[index].options!.size ??
                                                "",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                          ),
                                        ])),
                                    const SizedBox(height: 8.0),
                                    RichText(
                                        textAlign: TextAlign.center,
                                        text:  TextSpan(children: [
                                          const TextSpan(
                                            text: "Saus : ",
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
                                          ),
                                          TextSpan(
                                            text: provider.cartModel?.results?.carts?[index].options!.saus ??
                                                "",
                                            style:const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                          ),
                                        ])),
                                    const SizedBox(height: 15.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Responsive.width(30, context),
                                          height: 30,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 15),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                                onTap: () {
                                                  final postMdlCart = Provider.of<CartProvider>(
                                                      context,
                                                      listen: false);

                                                  setState(() {
                                                    postMdlCart
                                                        .decrementToCart(
                                                        context,
                                                        provider.cartModel?.results
                                                            ?.carts?[index].rowId
                                                            .toString())
                                                        .then((value) => {
                                                      postMdlCart
                                                          .getCartDetails(context)
                                                    });
                                                  });
                                                },

                                              ),
                                               Text(
                                                provider.cartModel?.results?.carts?[index].qty ??
                                                    "1", // Display the current quantity
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                  margin: const EdgeInsets.only(left: 15),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                                onTap: () {
                                                  final postMdlCart = Provider.of<CartProvider>(
                                                      context,
                                                      listen: false);

                                                  setState(() {
                                                    postMdlCart
                                                        .incrementToCart(
                                                        context,
                                                        provider.cartModel?.results
                                                            ?.carts?[index].rowId
                                                            .toString())
                                                        .then((value) => {
                                                      postMdlCart
                                                          .getCartDetails(context)
                                                    });
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),

                                         Text("\u{20AC} ${provider.cartModel?.results?.carts?[index].price}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontFamily: "Poppins",
                                          ),
                                        )
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                                      child: Divider(color: Constants.borderLightGrey,height: 0.7,),
                                    ),
                                  ],
                                ); // Custom widget for displaying cart items
                              },
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                            child: Text(
                              "Discount Code (If you have)",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                            child: Divider(color: Constants.borderLightGrey,height: 0.7,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: TextFormField(
                                controller: couponController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                                onChanged: (value){
                                  setState(() {
                                    coupon = value.trim();
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: "Enter coupon",
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Constants.hintColor, fontWeight: FontWeight.w400),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Constants.borderLightGrey,
                                          width: 0.7
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Constants.borderLightGrey,
                                        width: 0.7,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Constants.borderLightGrey,
                                          width: 0.7
                                      ),
                                    ),
                                    suffixIconConstraints: const BoxConstraints(minWidth: 35, maxHeight: 20),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Visibility(
                                          visible: coupon != "",
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  coupon = "";
                                                  couponController.text = "";
                                                  couponDiscount = "0";
                                                  isCouponApplied = false;
                                                });
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Colors.green,
                                              )),
                                        ),
                                      ],
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical:8 ))),
                          ),

                          Visibility(
                            visible: isCouponApplied,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                              child: Text(
                                "Coupon code is Applied Successfully!",
                                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0, right: 15),
                              child: SizedBox(
                                height: 30,
                                width: Responsive.width(38, context),
                                child: ElevatedButton(
                                  style: Constants.buttonStyle(),
                                  onPressed: () async {

                                    if(coupon == ""){
                                      Constants.showToast("Please enter coupon code");
                                    }else{
                                      Map<String, dynamic> body = {
                                        "restaurant_id": provider.cartModel!.results!.restaurantId,
                                        "coupon_code": couponController.text.trim(),
                                        "cartToken": PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) ?? '',
                                      };
                                      await provider.applyCouponCode(context, body).then((value) {
                                        print("value==>$value");
                                        if(value != null && value["status"] == true){
                                          setState(() {
                                            isCouponApplied = true;
                                          });
                                        }else{
                                          Constants.showToast(value["message"]);
                                        }
                                      });
                                    }

                                  },
                                  child:   Padding(
                                    padding:const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: provider.isCouponLoading ? const SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 20,
                                      ): const Text(
                                        'APPLY COUPON',
                                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                            child: Text(
                              "Gift Card (If you have)",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                            child: Divider(color: Constants.borderLightGrey,height: 0.7,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: TextFormField(
                                controller: giftCardController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                                onChanged: (value){
                                  setState(() {
                                    giftcard = value.trim();
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: "Enter gift card code",
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Constants.hintColor, fontWeight: FontWeight.w400),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Constants.borderLightGrey,
                                          width: 0.7
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Constants.borderLightGrey,
                                        width: 0.7,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Constants.borderLightGrey,
                                          width: 0.7
                                      ),
                                    ),
                                    suffixIconConstraints: const BoxConstraints(minWidth: 35, maxHeight: 20),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Visibility(
                                          visible: giftcard != "",
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  giftcard = "";
                                                  giftCardController.text = "";
                                                  giftCardDiscount = "0.0";
                                                  isGiftCardApplied = false;
                                                });
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Colors.green,
                                              )),
                                        ),
                                      ],
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical:8 ))),
                          ),

                          Visibility(
                            visible: isGiftCardApplied,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                              child: Text(
                                "Gift card code is Applied Successfully!",
                                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0, right: 15),
                              child: SizedBox(
                                height: 30,
                                width: Responsive.width(50, context),
                                child: ElevatedButton(
                                  style: Constants.buttonStyle(),
                                  onPressed: () async {

                                    if(giftcard == ""){
                                      Constants.showToast("Please enter gift card code");
                                    }else{
                                      Map<String, dynamic> body = {
                                        "restaurant_id": provider.cartModel!.results!.restaurantId,
                                        "gift_card_number": giftCardController.text.trim(),
                                        "cartToken": PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) ?? '',
                                      };
                                      await provider.applyGiftCouponCode(context, body).then((value) {
                                        print("value==>$value");
                                        if(value != null && value["status"] == true && value["results"]["type"] != "error"){
                                          setState(() {
                                            isGiftCardApplied = true;
                                            giftCardDiscount = "${value["results"]["gift_card_amount"] ?? "0.0"}";
                                          });
                                        }else{
                                          Constants.showToast(value["message"]);
                                        }
                                      });
                                    }

                                  },
                                  child:   Padding(
                                    padding:const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: provider.isGiftCardLoading ? const SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 20,
                                      ): const Text(
                                        'APPLY GIFT CARD',
                                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                            child: Divider(color: Constants.borderLightGrey,height: 0.7,),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                            child: Table(
                              border:  TableBorder.all(color: const Color(0xFFDEDEDE),  style: BorderStyle.solid, width: 0.7),
                              children: [
                                TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Subtotal:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '€ ${provider.cartModel?.results?.cartSubtotal}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                TableRow(children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${widget.orderType} Discount:',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '€ ${(double.parse(provider.cartModel?.results?.cartSubtotal.toString() ?? "0"))*(int.parse(widget.orderType == "Delivery"? widget.discountModel?.results?.discount?.deliveryDiscount ??"0" :
                                          widget.discountModel?.results?.discount?.takeAwayDiscount ?? "0")/100 )}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                isCouponApplied? TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Coupon Discount',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '€ ${provider.cartModel?.results?.discountApplied}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]): TableRow(
                                    children: [
                                      TableCell(
                                          child: Row(
                                              children: <Widget>[
                                                new Container(),
                                              ]
                                          )
                                      ),

                                      TableCell(
                                          child: Row(
                                              children: <Widget>[
                                                new Container(),
                                              ]
                                          )
                                      )
                                    ]
                                ),
                                isGiftCardApplied? TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Gift Card Discount',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '€ ${giftCardDiscount}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]): TableRow(
                                    children: [
                                      TableCell(
                                          child: Row(
                                              children: <Widget>[
                                                new Container(),
                                              ]
                                          )
                                      ),

                                      TableCell(
                                          child: Row(
                                              children: <Widget>[
                                                new Container(),
                                              ]
                                          )
                                      )
                                    ]
                                ),
                                TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Tax:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '€ ${provider.cartModel?.results?.cartTax}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                TableRow(children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Total:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '€ ${(double.parse(provider.cartModel?.results?.cartSubtotal.toString() ?? "0")) -
                                              (double.parse(giftCardDiscount)) -
                                              ((double.parse(provider.cartModel?.results?.cartSubtotal.toString() ?? "0"))*(int.parse(widget.orderType == "Delivery"? widget.discountModel?.results?.discount?.deliveryDiscount ??"0" :
                                          widget.discountModel?.results?.discount?.takeAwayDiscount ?? "0")/100 )) }',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                                textAlign: TextAlign.center,
                                text:  TextSpan(children: [
                                  const TextSpan(
                                    text: "Or Call Us at ",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black),
                                  ),
                                  TextSpan(
                                      text: "0487 82 14 55",
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          launchUrl(Uri.parse("tel://0487821455"));
                                        }
                                  ),
                                ])),
                          ),

                          const SizedBox(height: 15,)
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                          borderRadius:  BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 3.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: Responsive.width(100, context),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                              ),
                              child: const Text(
                                "Select the Payment Method",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        paymentType = "Bank";
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: AbsorbPointer(
                                            absorbing: true,
                                            child: Radio(
                                              activeColor: Colors.green,
                                              value: "Bank",
                                              groupValue: paymentType,
                                              onChanged: (Object? value) {},
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "Bank Contact/Credit Card",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible : true,
                                    // visible : widget.orderType == "Delivery",
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            paymentType = "Cod";
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: AbsorbPointer(
                                                absorbing: true,
                                                child: Radio(
                                                  activeColor: Colors.green,
                                                  value: "Cod",
                                                  groupValue: paymentType,
                                                  onChanged: (Object? value) {},
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                "Cash on Delivery (COD)",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 15),
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: Constants.buttonStyle(),
                        onPressed: () async {
                          Map<String, dynamic> body = {
                            "cartToken" : PreferenceHelper.getString(PreferenceHelper.CART_TOKEN) ?? '',
                            "customer_address" : widget.deliveryAddress!.id,
                            "opt_order" : widget.orderType == "Delivery" ? "is_delivery":"is_takeaway",
                            "notes" : widget.notes.toString(),
                            "payment_method" : paymentType == "Cod"? "cp" : "mp",
                            "delivery_time" : widget.hour,
                            "order_date" : DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(widget.date!)),
                          };
                            if(paymentType == "Bank"){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => MolliePaymentScreen(body: body, total : ((double.parse(provider.cartModel?.results?.cartSubtotal.toString() ?? "0")) -
                                          (double.parse(giftCardDiscount)) -
                                          ((double.parse(provider.cartModel?.results?.cartSubtotal.toString() ?? "0"))*(int.parse(widget.orderType == "Delivery"? widget.discountModel?.results?.discount?.deliveryDiscount ??"0" :
                                          widget.discountModel?.results?.discount?.takeAwayDiscount ?? "0")/100 )) ).toString())));
                            }else{
                              FocusManager.instance.primaryFocus?.unfocus();
                              await provider.codPaymentOrder(context, body)
                                  .then((value) async {
                                if(value != null && value["status"] == true){
                                  /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      const HomeScreen()), (Route<dynamic> route) => false);*/
                                  await orderSuccessDialog(context, price: value["results"]["amount"].toString());
                                }else{
                                  Constants.showToast(value["message"] == "null" ? "Something went wrong, please try again later" : value["message"]);
                                }

                              });
                            }
                        },
                        child:   Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: provider.isLoading ? const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20,
                            ):const Text(
                              'Order Now',
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
}