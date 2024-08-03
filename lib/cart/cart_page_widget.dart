import 'package:buyer_app/address/personal_details_screen.dart';
import 'package:buyer_app/assistantMethods/total_amount.dart';
import 'package:buyer_app/authentication/auth_screen.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../address/order_type_screen.dart';

class CartPageDesign extends StatefulWidget {
  @override
  _CartPageDesignState createState() => _CartPageDesignState();
}

class _CartPageDesignState extends State<CartPageDesign> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postMdl = Provider.of<CartProvider>(context, listen: false);
      postMdl.getCartDetails(context).then((value) {
        PreferenceHelper.setString(PreferenceHelper.CART_QTY,
            '${postMdl.cartModel?.results?.cartQty}');
        if (postMdl.cartModel?.results?.carts?.length != 0) {
          PreferenceHelper.setBool(PreferenceHelper.BADGE_VALUE, true);
        } else {
          PreferenceHelper.setBool(PreferenceHelper.BADGE_VALUE, false);
        }
        print(PreferenceHelper.getString(PreferenceHelper.CART_QTY).toString() +
            "===cart Qty");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Stack(
        children: [
          postMdl.isFetching
              ? AppUtils.showLoaderList()
              : postMdl.cartModel != null &&
              postMdl.cartModel?.results != null &&
              postMdl.cartModel?.results!.carts != null &&
              postMdl.cartModel!.results!.carts!.length > 0
              ? Container(
            margin: EdgeInsets.only(bottom: 60),
            // child: Text("hello")
            child: ListView(
              scrollDirection: Axis.vertical, // or Axis.horizontal for a row
              children: [
                bindListViewCart(postMdl),
                // Expanded(child:
                // bindListViewCart(postMdl),),
                //Cart Total
                Container(
                  margin: EdgeInsets.only(top: 0,bottom: 0),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15,top: 5,bottom: 5,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child:  Text("Total Price",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child:  Text('\u{20AC}${postMdl.cartModel?.results?.cartTotal}' ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                //Discount
                Container(
                  margin: EdgeInsets.only(top: 0,bottom: 0),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15,top: 5,bottom: 5,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child:  Text("Total Discount",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child:  Text('\u{20AC}${postMdl.cartModel?.results?.discountApplied}' ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                //tax
                Container(
                  margin: EdgeInsets.only(top: 0,bottom: 0),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15,top: 5,bottom: 5,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child:  Text("Tax price",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child:  Text('\u{20AC}${postMdl.cartModel?.results?.cartTax}' ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                //Order Total
                Container(
                  margin: EdgeInsets.only(top: 0,bottom: 0),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15,top: 5,bottom: 5,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child:  Text("Order Total",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child:  Text('\u{20AC}${postMdl.cartModel?.results?.cartSubtotal}' ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                //Place Order
                Container(
                  margin: EdgeInsets.only(top: 0,bottom: 0),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15,top: 5,bottom: 5,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child:  Text('\u{20AC}${postMdl.cartModel?.results?.cartSubtotal}' ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                      ),
                      ElevatedButton(
                        child:  Text(
                          AppString.place_order,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        ),
                        onPressed: () {
                          if(PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN)){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => OrderTypeScreen(orderAmount: postMdl.cartModel?.results?.cartSubtotal.toString(),)));
                          }else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const AuthScreen()));
                          }

                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              : AppUtils.commonErrorMessage(
            message: 'Cart is Empty',
          ),
        ],
      ),
    );
  }

  Widget bindListViewCart(CartProvider postMdl) {
    print("----cart Length===${postMdl.cartModel?.results?.carts!.length}");
    return ListView.builder(
      physics: BouncingScrollPhysics(),

      shrinkWrap: true,
      itemCount: postMdl.cartModel?.results?.carts!.length,
      // Replace with your actual cart item count
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [

              // Image.asset('assets/images/login.png',width: 100.0,fit: BoxFit.fitHeight,height: MediaQuery.of(context).size.height/4,),
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/login.png'), // Replace with your actual image
                  //   fit: BoxFit.fitHeight,
                  // ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  child: Image.network(fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      fit: BoxFit.fitHeight,
                      "https://via.placeholder.com/200X200".toString(),
                    );
                  },
                      // ""
                      postMdl.cartModel?.results?.carts?[index].options?.image
                              .toString() ??
                          ""
                      // "assets/images/seller.png"
                      // postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].resImage ?? ""
                      // popularRestaurantList[index].restaurantImage!
                      ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            postMdl.cartModel?.results?.carts?[index].name ??
                                "",
                            maxLines:
                                5, // Replace with your actual product name
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          // width:90.0,
                          // width: 40,
                          // height: 20,

                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                onTap: () {
                                  // decrementQuantity();
                                  final postMdlCart = Provider.of<CartProvider>(
                                      context,
                                      listen: false);

                                  setState(() {
                                    postMdlCart
                                        .decrementToCart(
                                            context,
                                            postMdl.cartModel?.results
                                                ?.carts?[index].rowId
                                                .toString())
                                        .then((value) => {
                                              postMdlCart
                                                  .getCartDetails(context)
                                            });
                                  });
                                },
                                // alignment: Alignment.center,
                              ),
                              Text(
                                postMdl.cartModel?.results?.carts?[index].qty ??
                                    "5", // Display the current quantity
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                onTap: () {
                                  // incrementQuantity();
                                  final postMdlCart = Provider.of<CartProvider>(
                                      context,
                                      listen: false);

                                  setState(() {
                                    postMdlCart
                                        .incrementToCart(
                                            context,
                                            postMdl.cartModel?.results
                                                ?.carts?[index].rowId
                                                .toString())
                                        .then((value) => {
                                              postMdlCart
                                                  .getCartDetails(context)
                                            });
                                  });
                                },
                                // alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Price : ",
                              // '\u{20AC} ${postMdl.cartModel?.results?.carts?[index].discount}', // Replace with your actual product price
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                // decoration: TextDecoration.lineThrough,
                                fontFamily: "Poppins",
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '\u{20AC} ${postMdl.cartModel?.results?.carts?[index].price}',
                              // Replace with your actual product price
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 8.0),
                        Container(
                          // margin: EdgeInsets.only(left: 10,right: 0),
                          child: GestureDetector(
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              final postMdlCart = Provider.of<CartProvider>(
                                  context,
                                  listen: false);

                              setState(() {
                                postMdlCart
                                    .removeFromCart(
                                    context,
                                    postMdl.cartModel?.results
                                        ?.carts?[index].rowId
                                        .toString())
                                    .then((value) =>
                                {postMdlCart.getCartDetails(context)});
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    // Text(
                    //   'Size:  ${postMdl.cartModel?.results?.carts?[index].options?.size}',
                    //   // Replace with your actual seller info
                    //   style: TextStyle(
                    //       fontSize: 14.0,
                    //       color: Colors.black,
                    //       fontFamily: "Poppins",
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(height: 8.0),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       child: Text(
                    //         postMdl.cartModel?.results?.carts?[index].options
                    //                     ?.saus !=
                    //                 null
                    //             ? 'Saus :'
                    //                 '  ${postMdl.cartModel?.results?.carts?[index].options?.saus}'
                    //             : "",
                    //         maxLines: 3, // Replace with your actual seller info
                    //         style: TextStyle(
                    //             fontSize: 14.0,
                    //             color: Colors.black,
                    //             fontFamily: "Poppins",
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //       width: 150,
                    //     ),
                    //
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
            ],
          ),
        ); // Custom widget for displaying cart items
      },
    );
  }
}
