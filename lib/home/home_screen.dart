import 'package:buyer_app/global/AppScaffold.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/home/dashboard_screen.dart';
import 'package:buyer_app/home/profile_screen.dart';
import 'package:buyer_app/cart/cart_page_widget.dart';
import 'package:buyer_app/search/search_screen.dart';
import 'package:flutter/material.dart';

import '../authentication/auth_screen.dart';
import '../providers/CartProvider.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    switch (index){
      case 0:
        return DashboardScreen(onFilterClick: () {
          setState(() {
            _selectedIndex = 1;
          });
        },);
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


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: cartQuantity,
      builder: (context, quantity, child) {
        return AppScaffold(
          key: _scaffoldKey,
          title: AppString.restaurunt_hub,
          body: getPage(_selectedIndex),
          bottomSheet:  BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                // backgroundColor: Colors.green,
                icon: Icon(Icons.home),
                label: AppString.home,
              ),
              BottomNavigationBarItem(
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
                      Icon(Icons.shopping_cart),
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
                          child: Text(quantity.toString(),style: TextStyle(  color: Colors.white,
                            fontSize: 10,
                            fontFamily: "Poppins",
                          ),),),
                      )
                    ]
                )
                    : Icon(Icons.shopping_cart),
                label: AppString.cart,
              ),
              BottomNavigationBarItem(
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
}
