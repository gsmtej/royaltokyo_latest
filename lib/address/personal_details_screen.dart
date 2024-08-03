import 'package:buyer_app/address/add_address_dialog.dart';
import 'package:buyer_app/address/delivery_not_available_dialog.dart';
import 'package:buyer_app/address/model/address_details_model.dart';
import 'package:buyer_app/address/summary_screen.dart';
import 'package:buyer_app/global/constants.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:buyer_app/providers/CartProvider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonalDetailsScreen extends StatefulWidget{
  final String? restaurantId;
  const PersonalDetailsScreen({super.key, this.restaurantId});

  @override
  State<StatefulWidget> createState() {
    return PersonalDetailsScreenState();
  }
  
}
class PersonalDetailsScreenState extends State<PersonalDetailsScreen>{

  String selectedAddress= "";
  String orderType = "Delivery";
  String timing1 = "12:00 AM, 03:30 PM";
  String timing2 = "04:00 PM, 11:50 PM";

  TextEditingController noteController = TextEditingController();
  String orderDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  // TimeOfDay orderTime = TimeOfDay.now();
  String orderTime = "";

  DefaultAddress selectedDefaultAddress = DefaultAddress();

  @override
  void initState() {
    super.initState();
    calculateDiscount();
    getAddressDetails();
  }

  Future<void> calculateDiscount()async{
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.calculateDiscount(context, cartProvider.cartModel!.results!.restaurantId);
  }

  Future<void> getAddressDetails()async{
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getRestaurantTimingDetails(context, cartProvider.cartModel!.results!.restaurantId);
    await cartProvider.getAddressDetails(context).then((resp) async {
      if(cartProvider.addressDetailsModel != null && cartProvider.addressDetailsModel!.results!.customerAddresses!.isNotEmpty){
        selectedDefaultAddress = cartProvider.addressDetailsModel!.results!.customerAddresses!.first;
        await cartProvider.changeDeliveryAddress(context, selectedDefaultAddress.id!).then((changeAddRes) async {
          if(changeAddRes != null && changeAddRes["status"] == "false"){
            await deliveryNotAvailableDialog(context, description: changeAddRes["message"]);
          }
        });
      }
    });
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
              "Personal Details",
              style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
          ),
          bottomNavigationBar: Visibility(
            visible: !provider.isFetching,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 15, left: 15, right: 15),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: Constants.buttonStyle(),
                  onPressed: () async {
                    if(orderTime == ""){
                      Constants.showToast("Please select order time");
                    }else{
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>  SummaryScreen(date: orderDate,
                                hour: orderTime, orderType: orderType,
                                discountModel: provider.discountModel,
                                notes: noteController.text.trim(), deliveryAddress: selectedDefaultAddress,)));
                    }

                  },
                  child:  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body:  Stack(
            children: [
              provider.isFetching || provider.addressDetailsModel == null
                  ? AppUtils.showLoaderList()
                  :  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              "First and Last Name",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 40,
                              width: Responsive.width(100, context),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                              ),
                              child:  Text(
                              provider.addressDetailsModel!.results!.defaultAddress!.name!,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Email Address",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 40,
                              width: Responsive.width(100, context),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                              ),
                              child:  Text(
                                  provider.addressDetailsModel!.results!.defaultAddress!.email!,
                                style:const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Phone",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 40,
                              width: Responsive.width(100, context),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                              ),
                              child:  Text(
                                provider.addressDetailsModel!.results!.defaultAddress!.phoneNumber!,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Full Address",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 40,
                              width: Responsive.width(100, context),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                              ),
                              child:  Text(
                                provider.addressDetailsModel!.results!.defaultAddress!.addressRegister!,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "City",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 40,
                              width: Responsive.width(100, context),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                              ),
                              child: Text(
                                  provider.addressDetailsModel!.results!.defaultAddress!.cityRegister!,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Post Code",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 40,
                              width: Responsive.width(100, context),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                              ),
                              child: Text(
                                  provider.addressDetailsModel!.results!.defaultAddress!.postcodeRegister!,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),

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
                            children: [
                              Container(
                                width: Responsive.width(100, context),
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                                ),
                                child: const Text(
                                  "Your Address",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                                  ),
                                  child: DropdownSearch<DefaultAddress>(
                                    dropDownButton: const Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.transparent,
                                      size: 20,
                                    ),
                                    selectedItem: selectedDefaultAddress,
                                    mode: Mode.MENU,
                                    items: provider.addressDetailsModel!.results!.customerAddresses,
                                    onChanged: (value) async{
                                      if(value != selectedDefaultAddress){
                                        selectedDefaultAddress = value! ;
                                        await provider.changeDeliveryAddress(context, selectedDefaultAddress.id!).then((changeAddRes) async {
                                          if(changeAddRes != null && changeAddRes["status"] == "false"){
                                            await deliveryNotAvailableDialog(context);
                                          }
                                        });
                                      }

                                      setState(() {});
                                    },
                                    itemAsString: (DefaultAddress? address) {
                                      return address!.addressRegister.toString();
                                    },
                                    dropdownBuilder: (context, selectedItems) {
                                      return Text(
                                        selectedItems == null ||  selectedItems.addressRegister == null? "Address" : "${selectedItems.addressRegister!}, ${selectedItems.cityRegister!}, ${selectedItems.postcodeRegister!}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color:  selectedItems == null || selectedItems.addressRegister == null ? Constants.hintColor : Colors.black),
                                      );
                                    },
                                    showSearchBox: false,
                                    dropdownSearchDecoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle:
                                      const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Constants.hintColor),
                                      hintText: "Address",
                                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 30.0,bottom: 10, left: 15, right: 15),
                                child: ElevatedButton(
                                  style: Constants.buttonStyle(),
                                  onPressed: () async {
                                    await addAddressDialog(context).then((value) async {
                                      if(value == true){
                                        await getAddressDetails();
                                      }
                                    });
                                  },
                                  child:  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        'Add Address',
                                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

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
                                width: Responsive.width(100, context),
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                                ),
                                child: const Text(
                                  "Order Type",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            orderType = "Delivery";
                                          });
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: AbsorbPointer(
                                                absorbing: true,
                                                child: Radio(
                                                  activeColor: Colors.green,
                                                  value: "Delivery",
                                                  groupValue: orderType,
                                                  onChanged: (Object? value) {},
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                "Delivery",
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
                                    const Padding(padding: EdgeInsets.only(left: 15)),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            orderType = "Take Away";
                                          });
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: AbsorbPointer(
                                                absorbing: true,
                                                child: Radio(
                                                  activeColor: Colors.green,
                                                  value: "Take Away",
                                                  groupValue: orderType,
                                                  onChanged: (Object? value) {},
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                "Take Away",
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
                                  ],
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.only(top: 20.0, left: 15, right: 15),
                                child: Text(
                                  "Order Date",
                                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                child: GestureDetector(
                                  onTap: () async {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    DateTime selectedDate = await Constants.selectPastDate(context,
                                        givenDate: DateFormat('dd/MM/yyyy').parse(orderDate));
                                    setState(() {
                                      orderDate = DateFormat('dd/MM/yyyy').format(selectedDate);
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: Responsive.width(100, context),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                                    ),
                                    child: Text(
                                      orderDate,
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.only(top: 20.0, left: 15, right: 15),
                                child: Text(
                                  "Order Time",
                                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                                ),
                              ),

                             /* Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                child: GestureDetector(
                                  onTap: () async {
                                    TimeOfDay time =  await Constants.selectTime(context, orderTime);
                                    setState(() {
                                      orderTime = time;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: Responsive.width(100, context),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                                    ),
                                    child:  Text(
                                      orderTime.format(context),
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),*/

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                                  ),
                                  child: DropdownSearch<String>(
                                    dropDownButton: const Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    selectedItem: orderTime,
                                    mode: Mode.MENU,
                                    items: provider.restaurantTimingModel!.results!.deliveryTimings!,
                                    // items: ["13:00", "13:15", "13:30", "13.45", "14.00"],
                                    onChanged: (value) {
                                      orderTime = value ?? "";
                                      setState(() {});
                                    },
                                    dropdownBuilder: (context, selectedItems) {
                                      return Text(
                                        selectedItems! == "" ? "Time" : selectedItems,
                                        style: TextStyle(
                                            fontWeight: selectedItems == ""? FontWeight.w400 : FontWeight.w500,
                                            fontSize: 14,
                                            color: selectedItems == "" ? Constants.hintColor : Colors.black),
                                      );
                                    },
                                    showSearchBox: false,
                                    dropdownSearchDecoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle:
                                      const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Constants.hintColor),
                                      hintText: "Time",
                                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 5, 2),
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.only(top: 20.0, left: 15, right: 15),
                                child: Text(
                                  "Order Notes",
                                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                                child: TextFormField(
                                    controller: noteController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    maxLines: 2,
                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintText: "",
                                        hintStyle: const TextStyle(
                                            fontSize: 14, color: Constants.hintColor, fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Constants.borderLightGrey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Constants.borderLightGrey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Constants.borderLightGrey,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9))),
                              ),

                              const SizedBox(height: 15)
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
  
}