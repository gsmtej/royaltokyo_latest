import 'package:buyer_app/RestaurantScreen/add_to_cart_popup.dart';
import 'package:buyer_app/cart/cart_page_widget.dart';
import 'package:buyer_app/global/AppScaffold.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:buyer_app/home/dashboard_screen.dart';
import 'package:buyer_app/home/profile_screen.dart';
import 'package:buyer_app/models/gift_card_data_model.dart';
import 'package:buyer_app/providers/CartProvider.dart';
import 'package:buyer_app/providers/RestaurantProductProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../authentication/auth_screen.dart';
import '../giftCards/purchase_gift_cards_mollie_screen.dart';
import '../global/constants.dart';
import '../mollie_payment/MolliePaymentScreen.dart';
import '../search/search_screen.dart';

class RestaurantScreen extends StatefulWidget {
  String restaurantName,
      restaurantImage,
      restaurantAddress,
      restaurantPreparationTime,
      restaurantMinimumOrder,
      restaurantDeliveryTime,
      restaurantAvgRating,
      restaurantId;

  // Restaurants? restaurant;

  RestaurantScreen(
      {Key? key,
      required this.restaurantId,
      required this.restaurantName,
      required this.restaurantImage,
      required this.restaurantAddress,
      required this.restaurantAvgRating,
      required this.restaurantDeliveryTime,
      required this.restaurantMinimumOrder,
      required this.restaurantPreparationTime
      // required this.restaurant
      })
      : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _singleValue = "Take away";

  int _selectedIndex = 0;

  late TabController watchListTabController;
  TextEditingController amountController = TextEditingController();

  void _onItemTapped(int index) {
    if(index == 3){
      if(PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN)){
        setState(() {
          _selectedIndex = index;

        });
      }else{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => const AuthScreen()));
      }
    }else{
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return restaurantDetails(context);
        break;
      case 1:
        return const SearchScreen();
        break;
      case 2:
        return CartPageDesign();
        break;
      case 3:
        return ProfileScreen();
        break;
      default:
        return DashboardScreen(onFilterClick: () {
          setState(() {
            _selectedIndex = 1;
          });
        },);
        break;
    }
  }

  Widget restaurantDetails(BuildContext context) {
    var postMdl = Provider.of<RestaurantProductProvider>(context);

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    /*//Take away and delivery Radio button
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: RadioButton(
                              description: "Take away",
                              value: "Take away",
                              groupValue: _singleValue,
                              onChanged: (value) => setState(
                                    () => _singleValue = value ?? '',
                              ),
                              activeColor: Colors.green,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioButton(
                              description: "Delivery",
                              value: "Delivery",
                              groupValue: _singleValue,
                              activeColor: Colors.green,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                              onChanged: (value) => setState(
                                    () => _singleValue = value ?? '',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //Restaurant Details
                    Card(
                      elevation: 5,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 200,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                // Color(0xFFFFECDF),
                                // borderRadius: BorderRadius.circular(50),
                              ),
                              child: Image.network(fit: BoxFit.fitWidth, widget.restaurantImage ?? ""),

                              // Image.asset(
                              //     postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].resImage ?? ""),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "${AppString.address} : ${widget.restaurantAddress ?? ""}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 2),
                              child: Text(
                                "${AppString.preparation_time} : ${widget.restaurantPreparationTime ?? ""}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 2),
                              child: Text(
                                "${AppString.delivery_time} : ${widget.restaurantDeliveryTime ?? ""}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 2),
                              child: Text(
                                "${AppString.minimum_order} : ${widget.restaurantMinimumOrder ?? ""}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 2),
                              child: Text(
                                "${AppString.rating} : ${widget.restaurantAvgRating.toString() ?? ""}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),*/
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
            body: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                    isScrollable: true,
                    controller: watchListTabController,
                    labelColor: Colors.green,
                    indicatorColor: Colors.green,
                    unselectedLabelColor: const Color(0xFFCCCCCC),
                    unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFFCCCCCC)),
                    labelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.green),
                    tabs: const [
                      Tab(text: "Menu",),
                      Tab(text: "Gift Card",),
                      Tab(text: "Review",),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(controller: watchListTabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                    menuWidget(postMdl),
                    giftCardWidget(postMdl),
                    reviewWidget(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bindListViewProductsByCategories(RestaurantProductProvider postMdl) {
    print("----categories Length===${postMdl.restaurantProductModel?.results?.category?.length}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
                itemCount: postMdl.restaurantProductModel?.results?.category?.length,
                itemBuilder: (BuildContext context, int index) {
                  return  GestureDetector(
                    onTap: (){
                      setState(() {
                        postMdl.selectedCategoryIndexSet = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: index == postMdl.selectedCategoryIndexSet ?  Colors.green : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: index == postMdl.selectedCategoryIndexSet ?  Colors.green : Colors.grey)
                      ),
                      child: Text(
                        postMdl.restaurantProductModel?.results?.category?[index].categoryName.toString() ??
                            AppString.starter,
                        // postMdl.restaurantProductModel?.results?.category![index].toString()
                        textAlign: TextAlign.start,
                        style:  TextStyle(
                            color: index == postMdl.selectedCategoryIndexSet ?  Colors.white : Colors.grey, fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
          ),
        ),
        const SizedBox(height : 15),
        Expanded(
          child: postMdl.isFetching
              ? AppUtils.showLoaderList() :
          postMdl.restaurantProductModel != null &&
              postMdl.restaurantProductModel?.results != null &&
              postMdl.restaurantProductModel?.results!.category![postMdl.selectedCategoryIndexSet].product != null &&
              postMdl.restaurantProductModel!.results!.category![postMdl.selectedCategoryIndexSet].product!.length > 0 &&
              postMdl.restaurantProductModel!.results!.category![postMdl.selectedCategoryIndexSet].product!.isNotEmpty
              ?bindListViewProducts(postMdl, postMdl.selectedCategoryIndexSet)
    /*ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: postMdl.restaurantProductModel?.results?.category![postMdl.selectedCategoryIndexSet].product?.length,
              itemBuilder: (BuildContext context, int index) {
                return ;
                  Column(
                  mainAxisSize: MainAxisSize.min,
                  // physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        postMdl.isFetching
                            ? AppUtils.showLoaderList()
                            : postMdl.restaurantProductModel != null &&
                                    postMdl.restaurantProductModel?.results != null &&
                                    postMdl.restaurantProductModel?.results!.category![index].product != null &&
                                    postMdl.restaurantProductModel!.results!.category![index].product!.length > 0 &&
                                    postMdl.restaurantProductModel!.results!.category![index].product!.isNotEmpty
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                                        child: Text(
                                          postMdl.restaurantProductModel?.results?.category?[index].categoryName.toString() ??
                                              AppString.starter,
                                          // postMdl.restaurantProductModel?.results?.category![index].toString()
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: Colors.black, fontFamily: "Poppins", fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Flexible(
                                        // flex: 5,
                                        fit: FlexFit.loose,
                                        child: bindListViewProducts(postMdl, index),
                                      )
                                    ],
                                  )
                                : AppUtils.commonErrorMessage(
                                    message: 'No Found Any Products',
                                  ),
                      ],
                    ),
                  ],
                );
              })*/
        : AppUtils.commonErrorMessage(
          message: 'No Found Any Products',
          ),
        ),
      ],
    );
  }

  Widget bindListViewProducts(RestaurantProductProvider postMdl, int i) {
    print("----product Length===${postMdl.restaurantProductModel?.results?.category?[i].product?.length}");
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // physics: const BouncingScrollPhysics(),
        shrinkWrap: true, //
        itemCount:
            // 1,
            postMdl.restaurantProductModel?.results?.category?[i].product?.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
            child: Container(
              // height: 100,
              margin: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      // Color(0xFFFFECDF),
                      // borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.network(errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        fit: BoxFit.fitHeight,
                        "https://via.placeholder.com/200X200".toString(),
                      );
                    },
                        // ""
                        postMdl.restaurantProductModel!.results!.category?[i].product?[index].productThambnail.toString() ?? ""
                        // "assets/images/seller.png"
                        // postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].resImage ?? ""
                        // popularRestaurantList[index].restaurantImage!
                        ),
                  ),
                  Expanded(
                      child: Container(
                    // width: MediaQuery.of(context).size.width/3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 5, left: 15),
                          child: Text(
                            postMdl.restaurantProductModel!.results!.category![i].product![index].productNameNl.toString() ?? "",
                            style: const TextStyle(color: Colors.black, fontFamily: "Poppins", fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 5, left: 15),
                          child:  Text(
                            postMdl.restaurantProductModel!.results!.category![i].product![index].longDescpEn.toString() ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.black, fontFamily: "Poppins", fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      "\u{20AC} ${postMdl.restaurantProductModel!.results!.category![i].product![index].sellingPrice.toString()}",
                      style: const TextStyle(color: Colors.black, fontFamily: "Poppins", fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      print("id==>${postMdl.restaurantProductModel?.results?.category?[i].product?[index].id}");

                      final postMdlCart = Provider.of<CartProvider>(context, listen: false);

                      setState(() {
                        postMdlCart
                            .getProductViewModelData(
                                context, postMdl.restaurantProductModel?.results?.category?[i].product?[index].id.toString())
                            .then((value) async => {

                                  if ((!(postMdlCart.productViewModel!.results!.size!.contains("NULL") || postMdlCart.productViewModel!.results!.size!.contains("none")) && postMdlCart.productViewModel!.results != null &&
                                          postMdlCart.productViewModel!.results!.size != null &&
                                          postMdlCart.productViewModel!.results!.size!.isNotEmpty) ||
                                      (!(postMdlCart.productViewModel!.results!.saus!.contains("NULL") || postMdlCart.productViewModel!.results!.saus!.contains("none")) && postMdlCart.productViewModel!.results != null &&
                                          postMdlCart.productViewModel!.results!.saus != null &&
                                          postMdlCart.productViewModel!.results!.saus!.isNotEmpty))
                                    {
                                      await addToCartDialog(context).then((resp) {
                                        if (resp) {
                                          AppUtils.showMessage(
                                              context: context,
                                              message: "Successfully Added on Your Cart",
                                              backgroundColor: AppColor.colorOrange);
                                          /*setState(() {
                                            _selectedIndex = 2;
                                          });*/
                                        }
                                      })
                                    }
                                  else {
                                      await postMdlCart
                                          .addToCart(context, int.parse(postMdlCart.productViewModel!.results!.product!.id!),
                                              postMdlCart.productViewModel!.results!.product!.productNameEn!, "1", "NULL", "NULL")
                                          .then((value) {
                                        if (postMdlCart.isFetching) {
                                          AppUtils.showLoaderList();
                                        }
                                        print("${postMdlCart.addtoCart?.results?.returnCartToken}");
                                        PreferenceHelper.setString(
                                            PreferenceHelper.CART_TOKEN, '${postMdlCart.addtoCart?.results?.returnCartToken}');

                                        AppUtils.showMessage(
                                            context: context,
                                            message: "Successfully Added on Your Cart",
                                                        backgroundColor: AppColor.colorOrange);
                                                   /* setState(() {
                                                      _selectedIndex = 2;
                                                    });*/
                                        print('========returnCartToken${PreferenceHelper.getString(PreferenceHelper.CART_TOKEN)}');
                                      })
                                    }
                                });
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      height: 40,
                      width: 50,
                      color: Colors.green,
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: cartQuantity,
      builder: (context, quantity, child) {
        print("quantity==>$quantity");
        return  AppScaffold(
          key: _scaffoldKey,
          title: widget.restaurantName,
          body: getPage(_selectedIndex),
          bottomSheet: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                // backgroundColor: Colors.green,
                icon: Icon(Icons.home),
                label: AppString.home,
              ),
              const BottomNavigationBarItem(
                // backgroundColor: Colors.green,
                icon: Icon(Icons.search),
                label: AppString.search,
              ),
              BottomNavigationBarItem(
                // backgroundColor: Colors.green,
                icon: PreferenceHelper.getBool(PreferenceHelper.BADGE_VALUE) == true &&
                    quantity != 0
                    ? Stack(children: <Widget>[
                  const Icon(Icons.shopping_cart),
                  Positioned(
                    // draw a red marble
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 14,
                      width: 14,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(100)
                        //more than 50% of width makes circle
                      ),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  )
                ])
                    : const Icon(Icons.shopping_cart),
                label: AppString.cart,
              ),
              const BottomNavigationBarItem(
                // backgroundColor: Colors.green,
                icon: Icon(Icons.person),
                label: AppString.profile,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }

  Widget menuWidget(postMdl){
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 60),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [

          Expanded(
            // height: 400,
            child: Stack(
              children: [
                postMdl.isFetching
                    ? AppUtils.showLoaderList()
                    : postMdl.restaurantProductModel != null &&
                    postMdl.restaurantProductModel?.results != null &&
                    postMdl.restaurantProductModel?.results!.category != null &&
                    postMdl.restaurantProductModel!.results!.category!.length > 0 &&
                    postMdl.restaurantProductModel!.results!.category!.isNotEmpty
                    ? Container(
                  // child: Text("hello")
                  child: bindListViewProductsByCategories(postMdl),
                )
                    : AppUtils.commonErrorMessage(
                  message: 'No Found Any Categories',
                ),
              ],
            ),
          ),

          // //checkout button
          // GestureDetector(
          //   onTap: () {
          //     // launch(AppString.login_url);
          //     // print("press");
          //     // setState(() {
          //     //
          //     // });
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(
          //         top: 20, left: 20.0, right: 20.0, bottom: 80),
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //         color: Colors.green,
          //         borderRadius: BorderRadius.all(Radius.circular(25))),
          //     child: TextButton(
          //         child: Text("5 items " + AppString.checkout,
          //             style: TextStyle(fontSize: 16)),
          //         style: ButtonStyle(
          //           padding: MaterialStateProperty.all<EdgeInsets>(
          //               EdgeInsets.all(15)),
          //           foregroundColor:
          //               MaterialStateProperty.all<Color>(Colors.white),
          //         ),
          //         onPressed: () {}),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget reviewWidget(){
    return const Center(
      child: Text("No Data Available", style: TextStyle(color: Colors.black, fontSize: 18),),
    );
  }

  Widget giftCardWidget(RestaurantProductProvider postMdl){
    return postMdl.isFetchingGiftCards
        ? AppUtils.showLoaderList()
        : postMdl.giftCardDataModel != null &&
        postMdl.giftCardDataModel?.results != null &&
        postMdl.giftCardDataModel?.results != null &&
        postMdl.giftCardDataModel!.results!.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 80),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 38,
                  child: TextFormField(
                      controller: amountController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Type amount here",
                          hintStyle: const TextStyle(
                              fontSize: 14, color: Constants.hintColor, fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Constants.borderLightGrey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Constants.borderLightGrey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Constants.borderLightGrey,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12))),
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                style: Constants.buttonStyle(),
                onPressed: () async {

                  if(amountController.text.trim().isEmpty || amountController.text.trim() == "0"){
                    Constants.showToast("Please enter valid amount");
                    return;
                  }

                  if(PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN)){
                    Map<String, dynamic> body = {
                      "gift_card_id" : "",
                      "amount" : double.parse(amountController.text.trim()).toStringAsFixed(2),
                    };
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => PurchaseGiftCardsMollieScreen(body: body, total :  double.parse(amountController.text.trim()).toStringAsFixed(2), title: "Purchase Gift Card",)));
                  }else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const AuthScreen()));
                  }
                },
                child:  const Center(
                  child: Text(
                    'Purchase Gift Card',
                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: AlignedGridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              shrinkWrap: true,
              itemCount: postMdl.giftCardDataModel!.results!.length,
              cacheExtent: 999999999999999,
              itemBuilder: (context, index) {
                GiftCard? giftCard = postMdl.giftCardDataModel!.results![index].giftCard;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      border: Border.all(color: Colors.orange),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.9),
                          blurRadius: 3.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: Responsive.width(100, context),
                            height: Responsive.height(20, context),
                            imageUrl: "https://fastly.picsum.photos/id/124/150/150.jpg?hmac=wNHWsoK5l7ZHfJodqETmUVHvURGYiESRno9G607rP5A",
                            placeholder: (context, url) {
                              return Image.asset('assets/loading.gif', fit: BoxFit.cover);
                            },
                            errorWidget: (context, url, error) => Image.asset('assets/loading.gif', fit: BoxFit.cover),
                          ),
                        ),

                        const SizedBox(height: 10,),

                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 15.0,),
                          child: Text("${giftCard!.name ?? ""} (${giftCard.amount ?? "0.0"})", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18)),
                        ),

                        const SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,),
                          child: RichText(
                              text:  TextSpan(
                            children: [
                              const TextSpan(
                                text: "This gift is equivalent to amount ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14)
                              ),
                              TextSpan(
                                text: giftCard.amount ?? "0.0",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14)
                              ),
                              const TextSpan(
                                text: ", you can transfer this gift card, to your friend after purchasing it.",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14)
                              ),
                            ]
                          )),
                        ),

                        const SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                              if(PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN)){
                                Map<String, dynamic> body = {
                                  "gift_card_id" : giftCard.id,
                                  "amount" : giftCard.amount ?? "0.0",
                                };
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => PurchaseGiftCardsMollieScreen(body: body, total : giftCard.amount ?? "0.0", title: giftCard.name,)));
                              }else{
                                Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
                              }
                            },
                            child:  const Center(
                              child: Text(
                                'Purchase Gift Card',
                                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ) : AppUtils.commonErrorMessage(
      message: 'No Found Any Gift Cards',
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postMdl = Provider.of<RestaurantProductProvider>(context, listen: false);
      postMdl.getRestaurantProductCategories(context, widget.restaurantId.toString());
      postMdl.getRestaurantGiftCards(context, widget.restaurantId.toString());
      postMdl.restaurantProductModel?.results?.category?.forEach((element) {});
    });

    watchListTabController = TabController(length: 3, vsync: this)..addListener(setActiveTabIndex);
  }

  Future<dynamic> setActiveTabIndex() async {}

}
