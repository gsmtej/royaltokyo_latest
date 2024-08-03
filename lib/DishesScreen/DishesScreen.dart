import 'package:buyer_app/RestaurantScreen/restaurantPage.dart';
import 'package:buyer_app/global/AppScaffold.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/home/dashboard_screen.dart';
import 'package:buyer_app/home/profile_screen.dart';
import 'package:buyer_app/providers/DashboardProvider.dart';
import 'package:buyer_app/providers/DishesRestaurantProvider.dart';
import 'package:buyer_app/cart/cart_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

import '../authentication/auth_screen.dart';
import '../home/model/DashboardDetailModel.dart';
import '../providers/CartProvider.dart';
import '../search/search_screen.dart';

class DishesScreen extends StatefulWidget {
  Dishes dishes;

  DishesScreen({Key? key, required this.dishes}) : super(key: key);

  @override
  _DishesScreenState createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  int _selectedIndex = 0;

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
        return DishesDetails(context);
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

  Widget DishesDetails(BuildContext context) {
    final postMdl = Provider.of<DishesRestaurantProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(

              children: [
                //Dishes Image
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(left: 20, right: 20,top: 20),
                  child: Container(
                    height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        // Color(0xFFFFECDF),
                        // borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.network(
                          fit: BoxFit.fitWidth,
                          widget.dishes.fcImage ?? ""),

                      // Image.asset(
                      //     postMdl.dashboadrdDetailsModel?.data?.restaurants?[index].resImage ?? ""),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 5, left: 20),
                  child: const Text(
                    "Restaurants",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  // height: 400,
                  child:  Container(
                    margin: const EdgeInsets.only(left: 10,right: 10,bottom: 60),
                    child:  Stack(
                      children: [
                        postMdl.isFetching
                            ? AppUtils.showLoaderList()
                            : postMdl.dishesRestaurantModel != null &&
                            postMdl.dishesRestaurantModel?.results !=
                                null &&
                            postMdl.dishesRestaurantModel?.results!
                                .restaurants !=
                                null &&
                            postMdl.dishesRestaurantModel!.results!
                                .restaurants!.length >
                                0 &&
                            postMdl.dishesRestaurantModel!.results!
                                .restaurants!.isNotEmpty
                            ? Container(
                          // child: Text("hello")
                          child: bindGridViewOfRestaurant(postMdl),
                        )
                            : AppUtils.commonErrorMessage(
                          message: 'No Found Any Restaurant',
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bindGridViewOfRestaurant(DishesRestaurantProvider postMdl) {
    print("----Restaurant Length===${postMdl.dishesRestaurantModel?.results?.restaurants?.length}");

    final dsp = Provider.of<DashboardProvider>(context);
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: postMdl.dishesRestaurantModel?.results?.restaurants?.length,
      itemBuilder:(BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=>
                RestaurantScreen(
                  restaurantName:postMdl.dishesRestaurantModel?.results?.restaurants?[index].restaurantname ?? "",
                  restaurantImage:postMdl.dishesRestaurantModel?.results?.restaurants?[index].resImage ?? "",
                  restaurantAddress :postMdl.dishesRestaurantModel?.results?.restaurants?[index].address ?? "",
                  restaurantPreparationTime:postMdl.dishesRestaurantModel?.results?.restaurants?[index].preparationtime ?? "",
                  restaurantMinimumOrder:postMdl.dishesRestaurantModel?.results?.restaurants?[index].minimumorder ?? "",
                  restaurantDeliveryTime:postMdl.dishesRestaurantModel?.results?.restaurants?[index].deliverytime ?? "",
                  restaurantAvgRating:postMdl.dishesRestaurantModel?.results?.restaurants?[index].restaurantRatings?.averageRating.toString() ?? "",
                  restaurantId:postMdl.dishesRestaurantModel?.results?.restaurants?[index].id.toString() ?? "",
                )));
          },
          child: Card(
            color: Colors.green.shade50,
            elevation: 10,
            margin: const EdgeInsets.only(left: 10,right: 10,top: 10.0,bottom: 5.0),
            child: Container(
              // padding: EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    // padding: EdgeInsets.all(2),
                    height: 90,
                    width: 150,
                    // width: 100,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      // Color(0xFFFFECDF),
                      // borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.network(
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            fit: BoxFit.fitWidth,
                            "https://via.placeholder.com/200X200".toString(),
                          );
                        },
                        // ""
                        postMdl.dishesRestaurantModel?.results?.restaurants?[index].resImage
                            .toString() ?? ""
                      // "assets/images/seller.png"
                      // postMdl.dashboadrdDetailsModel?.data?.nearbyRestaurants?[index].resImage ?? ""
                      // popularRestaurantList[index].restaurantImage!
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      // "Name : "
                      "${postMdl.dishesRestaurantModel?.results?.restaurants?[index].restaurantname}" ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      // "Address : "
                      "${postMdl.dishesRestaurantModel?.results?.restaurants?[index].address}" ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],),
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: cartQuantity,
      builder: (context, quantity, child) {
        return AppScaffold(
          key: _scaffoldKey,
          title: widget.dishes.foodcategory,
          body: getPage(_selectedIndex),
          bottomSheet: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            items:  <BottomNavigationBarItem>[
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
                    quantity != 0 ?
                Stack(
                    children: <Widget>[
                      const Icon(Icons.shopping_cart),
                      Positioned(  // draw a red marble
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 14,
                          width: 14,

                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:  Colors.red,
                              borderRadius: BorderRadius.circular(100)
                            //more than 50% of width makes circle
                          ),
                          child:  Text(quantity.toString(),style: const TextStyle(  color: Colors.white,
                            fontSize: 10,
                            fontFamily: "Poppins",
                          ),),),
                      )
                    ]
                )
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postMdl =
      Provider.of<DishesRestaurantProvider>(context, listen: false);
      postMdl.getRestaurantByDishes(
          context, widget.dishes.id.toString());
    });
  }
}
