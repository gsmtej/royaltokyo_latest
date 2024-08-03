import 'package:buyer_app/authentication/auth_screen.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/mainScreens/address_screen.dart';
import 'package:buyer_app/mainScreens/history_screen.dart';
import 'package:buyer_app/home/home_screen.dart';
import 'package:buyer_app/orders/my_orders_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../giftCards/gift_cards_screen.dart';
import '../global/AppStrings.dart';
import '../referral/referral_screen.dart';
import '../search/search_screen.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN) ?
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            PreferenceHelper.getString(PreferenceHelper.PHOTO_URL) ?? ""),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  PreferenceHelper.getString("name") ?? "",
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Poppins"),
                ),
              ],
            ),
          ) : Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 10, left : 15, right:15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "YOU ARE NOT LOGGED IN!",
                  style: TextStyle(
                      color: Colors.black, fontSize: 12, fontFamily: "Poppins"),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Login now to access all the features.",
                  style: TextStyle(
                      color: Colors.black, fontSize: 16, fontFamily: "Poppins"),
                ),
                const SizedBox(height: 12),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const AuthScreen()));
                    },
                    child:  const Text(
                      AppString.login,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "My Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    if(PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN)){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MyOrdersScreen()));
                    }else{
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const AuthScreen()));
                    }

                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.games_rounded,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Gift Cards",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    if(PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN)){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const GiftCardsScreen()));
                    }else{
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const AuthScreen()));
                    }

                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.sports_handball_rounded,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Referral",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    if(PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN)){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>  ReferralScreen()));
                    }else{
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const AuthScreen()));
                    }

                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "History",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));

                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Search",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () 
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const SearchScreen()));

                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.add_location,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Add New Address",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () 
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> AddressScreen()));


                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                Visibility(
                  // visible: PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN),
                  visible: true,
                  child: ListTile(
                    leading:  Icon(
                      PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN) ? Icons.exit_to_app : Icons.login_rounded,
                      color: Colors.black,
                    ),
                    title:  Text(
                      PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN) ? "Sign Out" : "Login",
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () async {
                      if(PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN)){
                        PreferenceHelper.clear();
                        await FirebaseMessaging.instance.unsubscribeFromTopic("broadcast_all");
                        await firebaseAuth.signOut().then((value) {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const AuthScreen()));
                        });
                      }else{
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const AuthScreen()));
                      }

                    },
                  ),
                ),
                Visibility(
                  // visible: PreferenceHelper.getBool(PreferenceHelper.IS_LOGIN),
                  visible: true,
                  child: const Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
