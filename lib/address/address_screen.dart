import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/constants.dart';
import '../global/global.dart';
import '../global/responsive.dart';
import '../models/discount_model.dart';
import '../providers/CartProvider.dart';
import 'add_address_dialog.dart';
import 'delivery_not_available_dialog.dart';
import 'model/address_details_model.dart';
import 'payment_screen.dart';

class AddressScreen extends StatefulWidget{
  final String? date;
  final String? hour;
  final String? orderType;
  final String? notes;
  final DiscountModel? discountModel;
  const AddressScreen({super.key, this.date, this.hour, this.orderType,this.notes, this.discountModel});

  @override
  State<StatefulWidget> createState() {
    return AddressScreenState();
  }
  
}
class AddressScreenState extends State<AddressScreen>{

  DefaultAddress selectedDefaultAddress = DefaultAddress();

  var changeDeliveryAddressResponse = {};

  @override
  void initState() {
    super.initState();
    getAddressDetails();
  }

  Future<void> getAddressDetails()async{
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getRestaurantTimingDetails(context, cartProvider.cartModel!.results!.restaurantId);
    await cartProvider.getAddressDetails(context).then((resp) async {
      print("address==>");
      if(cartProvider.addressDetailsModel != null && cartProvider.addressDetailsModel!.results!.customerAddresses!.isNotEmpty){
        selectedDefaultAddress = cartProvider.addressDetailsModel!.results!.customerAddresses!.first;
        print("address==>11 ${selectedDefaultAddress.id}");
        await cartProvider.changeDeliveryAddress(context, selectedDefaultAddress.id!, orderType: widget.orderType).then((changeAddRes) async {
          print("address==>22 ${changeAddRes}");
          if(changeAddRes != null && changeAddRes["results"]["is_delivery_available"] == false){
            await deliveryNotAvailableDialog(context, description: changeAddRes["message"] == null || changeAddRes["message"] == "null" ? "Delivery Is Not Available On Your Address, Please Select Another Address" : changeAddRes["message"]);
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
              "Address Details",
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
                    if(provider.setChangeDeliveryAddressModel == null || provider.setChangeDeliveryAddressModel!.results!.isDeliveryAvailable == false){
                      await deliveryNotAvailableDialog(context, description: "Delivery Is Not Available On Your Address, Please Select Another Address" );
                    }else{
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>  PaymentScreen(date: widget.date,
                                hour: widget.hour, orderType: widget.orderType,
                                discountModel: provider.discountModel,
                                notes: widget.notes, deliveryAddress: selectedDefaultAddress,)));
                    }
                  },
                  child:  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        'Payment',
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
                                  "Your Address",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                                child: const Text(
                                  "Available Postcode",
                                  style: TextStyle(fontSize: 16, fontFamily: "Poppins", color: Colors.black, fontWeight: FontWeight.w600),
                                ),
                              ),

                              provider.getChangeDeliveryAddressModel == null || provider.getChangeDeliveryAddressModel!.results == null ? Container():Container(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                                ),
                                child: Text(
                                  "Post Code: ${provider.getChangeDeliveryAddressModel!.results!.postcodeRegister} | Min Order: € ${provider.getChangeDeliveryAddressModel!.results!.minOrder}",
                                  style: const TextStyle(fontSize: 14, fontFamily: "Poppins", color: Colors.black, fontWeight: FontWeight.w500),
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