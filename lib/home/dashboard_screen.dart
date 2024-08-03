import 'dart:async';

import 'package:buyer_app/DishesScreen/DishesScreen.dart';
import 'package:buyer_app/RestaurantScreen/restaurantPage.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:buyer_app/home/model/DashboardDetailModel.dart';
import 'package:buyer_app/home/model/DashboardDetailModel.dart';
import 'package:buyer_app/home/model/DashboardDetailModel.dart';
import 'package:buyer_app/providers/CartProvider.dart';

import 'package:buyer_app/providers/DashboardProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../RestaurantScreen/view_all_restaurant_screen.dart';
import '../widgets/filter_dialog.dart';


class DashboardScreen extends StatefulWidget {
  final Function()? onFilterClick;
  const DashboardScreen({super.key, this.onFilterClick});


  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  String Address = 'search';



  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<DashboardProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      // Add padding around the search bar
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      // Use a Material design search bar
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search  Location',
                          // Add a clear button to the search bar

                          // Add a search icon or button to the search bar
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // Perform the search here
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),),
                  ),

                  GestureDetector(
                    onTap: () async {
                      widget.onFilterClick!();
                     /* await filterCardDialog(context, postMdl, postMdl.isCategoriesId).then((value){
                        print("value==>$value");
                        if(value != null && value["applied"] == true){
                          postMdl.setIsFilterApplied = true;
                          postMdl.setCategoriesId = value["category_id"];
                          postMdl.getRestaurantByCategories(context);
                        }else{
                          postMdl.resetFilter();
                          setState(() {

                          });
                        }

                      });*/
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 45,
                            height:45,
                          margin: const EdgeInsets.only(right: 8),
                          alignment: Alignment.center,
                          clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Icon(Icons.filter_list_sharp)),

                        Visibility(
                          visible: postMdl.isFilterApplied == true,
                          child: Positioned(
                            top: 0,right: 15,
                            child: Container(
                              height: 10,
                              width: 10,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              //Popular Food Dishes
              postMdl.isFilterApplied ? Container(): Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top:15,left: 15),
                child: Text(
                  AppString.popular_food_dishes,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              postMdl.isFilterApplied ? Container():  Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 5,right: 5,top:15,bottom: 10),
                  child: Stack(
                    children: [
                      postMdl.isFetching
                          ? AppUtils.showLoaderList()
                          :
                      postMdl.dashboadrdDetailsModel!= null &&
                          postMdl.dashboadrdDetailsModel?.data != null
                          &&
                          postMdl.dashboadrdDetailsModel!.data!.dishes!.length > 0
                          ? Container(
                          child: bindListViewDishes(postMdl))
                          : AppUtils.commonErrorMessage(
                        message: 'No Found Popular FoodCategories',
                      ),
                    ],
                  ),
                  // bindListView(postMdl),
              ),
              //Popular Restaurant
              postMdl.isFilterApplied ? Container():  Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top:10,left: 15, right: 15),
                child: Text(
                  AppString.popular_restaurant,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Stack(
                children: [
                  postMdl.isFetching
                      ? AppUtils.showLoaderList()
                      :
                  postMdl.dashboadrdDetailsModel!= null &&
                      postMdl.dashboadrdDetailsModel?.data != null
                  &&
                  postMdl.dashboadrdDetailsModel!.data!.restaurants!.length > 0
                      ? Container(
                      child:  bindListViewRestaurants(postMdl))
                      : AppUtils.commonErrorMessage(
                      message: 'No Found Popular Restaurants',
                  ),
                ],
              ),

              //hot deals
              postMdl.isFilterApplied ? Container():  Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top:20,left: 15),
                child: Text(
                  AppString.hot_deals,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              postMdl.isFilterApplied ? Container(): Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 5,right: 5,top:15,bottom: 10),
                child: Stack(
                  children: [
                    postMdl.isFetching
                        ? AppUtils.showLoaderList()
                        :
                    postMdl.dashboadrdDetailsModel!= null &&
                        postMdl.dashboadrdDetailsModel?.data != null
                        &&
                        postMdl.dashboadrdDetailsModel!.data!.hotDeals!.length > 0
                        ? Container(
                      child: bindListViewHotDeals(postMdl),)
                        : Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: AppUtils.commonErrorMessage(
                        message: 'No Found Hot Deals',
                      ),
                    ),
                  ],
                ),
              ),

              //Near By you
              postMdl.isFilterApplied ? Container(): Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top:10,left: 15),
                child: Text(
                  AppString.near_by_you,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              postMdl.isFilterApplied ? Container():  Stack(
                children: [
                  postMdl.isFetching
                      ? AppUtils.showLoaderList()
                      :
                  postMdl.dashboadrdDetailsModel!= null &&
                      postMdl.dashboadrdDetailsModel?.data != null
                      &&
                      postMdl.dashboadrdDetailsModel!.data!.nearbyRestaurants!.length > 0
                      ? Container(
                      child: bindListViewNearByRestaurants(postMdl),)
                      : Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: AppUtils.commonErrorMessage(
                          message: 'No Found Near by Restaurants',
                  ),
                      ),
                ],
              ),

              SizedBox(height: 50)
            ],
          ),
          ),
        ),
    );


  }

  Widget bindListViewHotDeals(DashboardProvider postMdl) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount:
        postMdl.dashboadrdDetailsModel?.data?.hotDeals?.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>
                  RestaurantScreen(
                    restaurantName:postMdl.dashboadrdDetailsModel?.data?.hotDeals?[index].restaurantName ?? "",
                    restaurantImage:postMdl.dashboadrdDetailsModel?.data?.hotDeals?[index].resImage ?? "",
                    restaurantAddress : postMdl.dashboadrdDetailsModel?.data?.hotDeals?[index].address ?? "",
                    restaurantPreparationTime:postMdl.dashboadrdDetailsModel?.data?.hotDeals?[index].preparationtime ?? "",
                    restaurantMinimumOrder:postMdl.dashboadrdDetailsModel?.data?.hotDeals?[index].minimumorder ?? "",
                    restaurantDeliveryTime:postMdl.dashboadrdDetailsModel?.data?.hotDeals?[index].deliverytime ?? "",
                    restaurantAvgRating:postMdl.dashboadrdDetailsModel?.data?.hotDeals?[index].restaurantRatings?.averageRating.toString() ?? "",
                    restaurantId:postMdl.dashboadrdDetailsModel?.data?.hotDeals?[index].restaurantId.toString() ?? "",
                  )));
            },
            child: Card(
              elevation: 2,
              child: Container(
                margin: EdgeInsets.only(bottom: 0),
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // Color(0xFFFFECDF),
                        // borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.network(
                        errorBuilder: (context, error, stackTrace) {
                          return  Image.network(
                            fit: BoxFit.fitHeight,
                            "https://via.placeholder.com/200X200".toString(),
                          );
                        },
                        fit: BoxFit.fitHeight,
                        postMdl.dashboadrdDetailsModel!.data!.hotDeals![index].productThambnail.toString(),
                      ),
                      // popularFoodCategoriesList[index].foodImage!),
                    ),
                    SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      child:  Text(
                        postMdl.dashboadrdDetailsModel!.data!.hotDeals![index].productNameEn.toString(),
                        // popularFoodCategoriesList[index].foodName!,
                        textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 11,
                        fontWeight: FontWeight.normal,),),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget bindListViewDishes(DashboardProvider postMdl) {
    return  ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount:
        postMdl.dashboadrdDetailsModel?.data?.dishes?.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>
                  DishesScreen(dishes: postMdl.dashboadrdDetailsModel!.data!.dishes![index])));
            },
            child: Card(
              elevation: 2,
              child: Container(
                margin: EdgeInsets.only(bottom: 0),
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // Color(0xFFFFECDF),
                        // borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.network(
                        errorBuilder: (context, error, stackTrace) {
                          return  Image.network(
                            fit: BoxFit.fitHeight,
                            "https://via.placeholder.com/200X200".toString(),
                          );
                        },
                          fit: BoxFit.fitHeight,
                          postMdl.dashboadrdDetailsModel!.data!.dishes![index].fcImage.toString(),
                      ),
                      // popularFoodCategoriesList[index].foodImage!),
                    ),
                    SizedBox(height: 5),
                   Container(
                     alignment: Alignment.center,
                     child:  Text(
                       postMdl.dashboadrdDetailsModel!.data!.dishes![index].foodcategory.toString(),
                       // popularFoodCategoriesList[index].foodName!,
                       textAlign: TextAlign.center, style: TextStyle(
                       color: Colors.black,
                       fontFamily: "Poppins",
                       fontSize: 11,
                       fontWeight: FontWeight.normal,),),
                   )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget bindListViewRestaurants(DashboardProvider postMdl) {
    return Column(
      children: [
        ListView.builder(
            itemCount: postMdl.dashboadrdDetailsModel!.data!.restaurants!.length > 5 ? 5 : postMdl.dashboadrdDetailsModel?.data?.restaurants?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>
                      RestaurantScreen(
                        restaurantName:postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].restaurantname ?? "",
                        restaurantImage:postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].resImage ?? "",
                        restaurantAddress : postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].address ?? "",
                        restaurantPreparationTime:postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].preparationtime ?? "",
                        restaurantMinimumOrder:postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].minimumorder ?? "",
                        restaurantDeliveryTime:postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].deliverytime ?? "",
                        restaurantAvgRating:postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].restaurantRatings?.averageRating.toString() ?? "",
                        restaurantId:postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].id.toString() ?? "",
                      )));
                },
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left:5.0,right: 5.0,top: 10.0,bottom: 10.0),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            // Color(0xFFFFECDF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.network(
                              postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].resImage ?? "",
                              width: Responsive.width(100, context),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return  Image.network(
                                  "https://via.placeholder.com/200X200".toString(),
                                  fit: BoxFit.cover,
                                  width: Responsive.width(100, context),
                                );
                              },

                            // popularRestaurantList[index].restaurantImage!
                          ),
                        ),
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.home_work_rounded, color: Colors.black, size: 20,),
                                  SizedBox(width: 5),
                                  Text(
                                    postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].restaurantname ?? "",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on_rounded, color: Colors.black, size: 16,),
                                  SizedBox(width: 5),
                                  Text(
                                    postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].address ?? "",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time_filled_rounded, color: Colors.grey, size: 16,),
                                  SizedBox(width: 5),
                                  Text(
                                    "Preparation Time : ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].preparationtime ?? ""}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.delivery_dining_rounded, color: Colors.grey, size: 16,),
                                  SizedBox(width: 5),
                                  Text(
                                    "Delivery Time : ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].deliverytime ?? ""}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.timelapse_rounded, color: Colors.grey, size: 16,),
                                  SizedBox(width: 5),
                                  Text(
                                    "${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].deliveryStartTime ?? ""} - ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].deliveryEndTime ?? ""}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.person_2_rounded, color: Colors.grey, size: 18,),
                                  SizedBox(width: 5),
                                  Text(
                                    postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].ownername ?? "",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.room_service_rounded, color: Colors.grey, size: 18,),
                                  SizedBox(width: 5),
                                  Text(
                                    "Service : ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].serves ?? ""}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top:5,left: 15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.reviews_rounded, color: Colors.grey, size: 18,),
                                      SizedBox(width: 5),
                                      Text(
                                        "${AppString.review}: ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].restaurantRatings!.totalReviews ?? "0"}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top:5,left: 15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.reviews_rounded, color: Colors.grey, size: 18,),
                                      SizedBox(width: 5),
                                      Text(
                                        "${AppString.rating}: ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].restaurantRatings!.averageRating ?? "0"}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top:5,left: 15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.social_distance_rounded, color: Colors.grey, size: 18,),
                                      SizedBox(width: 5),
                                      Text(
                                        "${AppString.delivery_distance} : ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].deliveryDistance.toString() ?? ""} km",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top:5,left: 15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.monetization_on_rounded, color: Colors.grey, size: 18,),
                                      SizedBox(width: 5),
                                      Text(
                                        "${AppString.average_price} : ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].discount.toString() ?? ""}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              );
            }),
        Visibility(
          visible: postMdl.dashboadrdDetailsModel!.data!.restaurants!.length > 5,
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const ViewAllRestaurantScreen()));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                AppString.view_all,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        )
      ],
    );
  }


  Widget bindListViewNearByRestaurants(DashboardProvider postMdl) {
    return ListView.builder(
        itemCount: postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>
                  RestaurantScreen(
                    restaurantName:postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].restaurantname ?? "",
                    restaurantImage:postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].resImage ?? "",
                    restaurantAddress : postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].address ?? "",
                    restaurantPreparationTime:postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].preparationtime ?? "",
                    restaurantMinimumOrder:postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].minimumorder ?? "",
                    restaurantDeliveryTime:postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].deliverytime ?? "",
                    restaurantAvgRating:postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].restaurantRatings?.averageRating.toString() ?? "",
                    restaurantId:postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].id.toString() ?? "",
                  )));
            },
            child: Card(
              elevation: 5,
              margin: EdgeInsets.only(left:5.0,right: 5.0,top: 10.0,bottom: 10.0),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // Color(0xFFFFECDF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network(
                        postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].resImage ?? "",
                        width: Responsive.width(100, context),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return  Image.network(
                            "https://via.placeholder.com/200X200".toString(),
                            fit: BoxFit.cover,
                            width: Responsive.width(100, context),
                          );
                        },

                        // popularRestaurantList[index].restaurantImage!
                      ),
                    ),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top:5,left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.home_work_rounded, color: Colors.black, size: 20,),
                              SizedBox(width: 5),
                              Text(
                                postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].restaurantname ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top:5,left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_rounded, color: Colors.black, size: 16,),
                              SizedBox(width: 5),
                              Text(
                                postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].address ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top:5,left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.access_time_filled_rounded, color: Colors.grey, size: 16,),
                              SizedBox(width: 5),
                              Text(
                                "Preparation Time : ${postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].preparationtime ?? ""}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top:5,left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.delivery_dining_rounded, color: Colors.grey, size: 16,),
                              SizedBox(width: 5),
                              Text(
                                "Delivery Time : ${postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].deliverytime ?? ""}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top:5,left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.timelapse_rounded, color: Colors.grey, size: 16,),
                              SizedBox(width: 5),
                              Text(
                                "${postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].deliveryStartTime ?? ""} - ${postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].deliveryEndTime ?? ""}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top:5,left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.person_2_rounded, color: Colors.grey, size: 18,),
                              SizedBox(width: 5),
                              Text(
                                postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].ownername ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top:5,left: 15),
                          child: Row(
                            children: [
                              Icon(Icons.room_service_rounded, color: Colors.grey, size: 18,),
                              SizedBox(width: 5),
                              Text(
                                "Service : ${postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].serves ?? ""}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.reviews_rounded, color: Colors.grey, size: 18,),
                                  SizedBox(width: 5),
                                  Text(
                                    "${AppString.review}: ${postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].restaurantRatings!.totalReviews ?? "0"}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.reviews_rounded, color: Colors.grey, size: 18,),
                                  SizedBox(width: 5),
                                  Text(
                                    "${AppString.rating}: ${postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].restaurantRatings!.averageRating ?? "0"}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.social_distance_rounded, color: Colors.grey, size: 18,),
                                  SizedBox(width: 5),
                                  Text(
                                    "${AppString.delivery_distance} : ${postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].deliveryDistance.toString() ?? ""} km",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top:5,left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.monetization_on_rounded, color: Colors.grey, size: 18,),
                                  SizedBox(width: 5),
                                  Text(
                                    "${AppString.average_price} : ${postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].discount.toString() ?? ""}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          );
        });
  }


  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];

    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}${place.subLocality}';
     print("---Address---"+Address);
     _searchController.text = place.postalCode.toString() + ", "+place.locality.toString();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getAddress() async {
    Position position = await _getGeoLocationPosition();
   var location ='Lat: ${position.latitude} , Long: ${position.longitude}';
   print(location+"---location");
    GetAddressFromLatLong(position);

  }

  Future<void> locationPermission() async {
    await Permission.location.isRestricted;
    // await Permission.locationAlways.isRestricted ;
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      print('Permission Granted');
      checkGps();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Future<void> checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    // await sharedPreferences!.setString("latitude", lat);
    // await sharedPreferences!.setString("longitude", long);

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
      getAddress();
    });
  }


  @override
  void initState() {
    super.initState();
    locationPermission().then((value){
      checkGps().then((value) {
        getAddress();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final postMdl = Provider.of<DashboardProvider>(context, listen: false);
          postMdl.getHomepageDetails(context);
          final cartMdl = Provider.of<CartProvider>(context, listen: false);
          cartMdl.getCartDetails(context);
          postMdl.resetFilter();
        });
      });
    });
  }
}


