import 'package:buyer_app/RestaurantScreen/restaurantPage.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';
import '../global/responsive.dart';
import '../providers/DashboardProvider.dart';

class ViewAllRestaurantScreen extends StatefulWidget {
  final bool? isFromPurchasedSuccess;
  const ViewAllRestaurantScreen({super.key, this.isFromPurchasedSuccess});

  @override
  State<ViewAllRestaurantScreen> createState() => _ViewAllRestaurantScreenState();
}

class _ViewAllRestaurantScreenState extends State<ViewAllRestaurantScreen> {

  @override
  void initState() {
    super.initState();
    getUserGiftCardsList();
  }

  Future<void> getUserGiftCardsList() async {
    final postMdl = Provider.of<DashboardProvider>(context, listen: false);
    postMdl.getHomepageDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, postMdl, child) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future(() => true);
          },
          child: Scaffold(
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
                  AppString.popular_restaurant,
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                ),
                centerTitle: true,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    })),
            body: RefreshIndicator(
              onRefresh: () async {
                await postMdl.getHomepageDetails(context);
                return Future.value(true);
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: postMdl.isFetching
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bindListViewRestaurants(DashboardProvider postMdl) {
    return ListView.builder(
        itemCount: postMdl.dashboadrdDetailsModel!.data!.restaurants!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
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
        });
  }
}