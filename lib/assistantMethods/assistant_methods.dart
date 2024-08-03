import 'package:buyer_app/assistantMethods/cart_item_counter.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/splashScreen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// SEPERATE ORDER ITEMS IN FIREBASE /////////////////////////////////////////////
separateOrderItemIDs(orderIDs)
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = List<String>.from(orderIDs);

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

            //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print("\nThis is Items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}

// SEPERATE ORDER QUANTITYES IN FIREBAE BACKEND ////////////////////////////////////

separateOrderItemQuantities(orderIDs)
{
  List<String> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = List<String>.from(orderIDs);

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    
                                             //0=:
                                             //1=7
            //:7
    
    List<String> ListItemCharacters = item.split(":").toList();
                                 //7
    var quanNumber = int.parse(ListItemCharacters[1].toString());

    print("\nThis is Quantity Number = " + quanNumber.toString());

    separateItemQuantityList.add(quanNumber.toString());
      }

  print("\nThis is Items Quantity List now = ");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}





//  SEPERATE ITEM IN USER ORDER PAGE ///////////////////////////////////////////
separateItemIDs()
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

            //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print("\nThis is Items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}


addItemToCart(String? foodItemId, BuildContext context, int itemCounter)
{
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter"); //56557657:7
  
  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser!.uid).update({
    "userCart": tempList,
  }).then((value)
  {
    Fluttertoast.showToast(msg: "Item Added Successfully.");

    sharedPreferences!.setStringList("userCart", tempList);

    //update the badge
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
  });
}

separateItemQuantities()
{
  List<int> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    
                                             //0=:
                                             //1=7
            //:7
    
    List<String> ListItemCharacters = item.split(":").toList();
                                 //7
    var quanNumber = int.parse(ListItemCharacters[1].toString());

    print("\nThis is Quantity Number = " + quanNumber.toString());

    separateItemQuantityList.add(quanNumber);
      }

  print("\nThis is Items Quantity List now = ");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}

clearCartNow(context)
{
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance
  .collection("users")
  .doc(firebaseAuth.currentUser!.uid)
  .update({
    "userCart": emptyList
  }).then((value)
  {
     sharedPreferences!.setStringList("userCart", emptyList!);
     Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
     
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));


     Fluttertoast.showToast(msg: "Cart has been cleared.");
  });
}
  




