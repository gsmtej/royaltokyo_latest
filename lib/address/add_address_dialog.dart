import 'package:buyer_app/address/delivery_not_available_dialog.dart';
import 'package:buyer_app/global/constants.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:buyer_app/providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

Future<bool> addAddressDialog(BuildContext context) async {
  bool returnType = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  final postMdlCart = Provider.of<CartProvider>(context, listen: false);
  await showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 25),
            backgroundColor: Colors.white,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Consumer<CartProvider>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      height: Responsive.height(68, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: Responsive.width(100, context),
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                                    ),
                                    child: const Text(
                                      "Add Address",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 15, right: 15),
                                    child: Text(
                                      "First and Last Name",
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                                    child: TextFormField(
                                        controller: nameController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
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

                                  const Padding(
                                    padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                                    child: Text(
                                      "Phone",
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                                    child: TextFormField(
                                        controller: phoneController,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.next,
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

                                  const Padding(
                                    padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                                    child: Text(
                                      "Full Address",
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                                    child: TextFormField(
                                        controller: addressController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
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

                                  const Padding(
                                    padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                                    child: Text(
                                      "City",
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                                    child: TextFormField(
                                        controller: cityController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
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

                                  const Padding(
                                    padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                                    child: Text(
                                      "Post Code",
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                                    child: TextFormField(
                                        controller: postCodeController,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        maxLength: 6,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                                        decoration: InputDecoration(
                                          counterText: "",
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
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: Constants.borderButtonStyle(),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: Constants.buttonStyle(),
                                    onPressed: () async {

                                      if(nameController.text.trim().isEmpty){
                                        Constants.showToast("Please enter first and last name");
                                      }else if (phoneController.text.trim().isEmpty){
                                        Constants.showToast("Please enter phone number");
                                      }else if (addressController.text.trim().isEmpty){
                                        Constants.showToast("Please enter full address");
                                      }else if (cityController.text.trim().isEmpty){
                                        Constants.showToast("Please enter city");
                                      }else if (postCodeController.text.trim().isEmpty && postCodeController.text.trim().length != 6){
                                        Constants.showToast("Please enter post code");
                                      }else{
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        Map<String, dynamic> body = {
                                          "name" : nameController.text.trim(),
                                          "phone" : phoneController.text.trim(),
                                          "address" : addressController.text.trim(),
                                          "city" : cityController.text.trim(),
                                          "post" : postCodeController.text.trim(),
                                        };
                                        await postMdlCart.addAddressDetails(context, body)
                                            .then((value) async {
                                              print("add==>$value");
                                              print("add==>${value["status"]== true}");
                                              print("add==>${value["status"]== "true"}");
                                              if(value != null && value["status"] == true){
                                                if (postMdlCart.isFetching) {
                                                  AppUtils.showLoaderList();
                                                }
                                                returnType = true;
                                                Navigator.pop(context);
                                              }else{
                                                await deliveryNotAvailableDialog(context, title: "Error Adding Address", description: "Delivery not available in this address!");
                                              }

                                        });
                                      }

                                    },
                                    child:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: postMdlCart.isFetching ? const SpinKitThreeBounce(
                                          color: Colors.white,
                                          size: 20,
                                        ):const Text(
                                          'Add',
                                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ));
      },
      // transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      // pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      //   return const Text('');
      // }
  );

  return returnType;
}