import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/constants.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:buyer_app/providers/CartProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

Future<bool> addToCartDialog(BuildContext context) async {
  bool returnType = false;
  String selectedItemsSize = "";
  String selectedIngredients = "";
  TextEditingController addMultipleController = TextEditingController(text: "1");
  final postMdlCart = Provider.of<CartProvider>(context, listen: false);
  await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
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
                      height: Responsive.height(70, context),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
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
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        width: Responsive.width(80, context),
                                        height: Responsive.height(18, context),
                                        fit: BoxFit.cover,
                                        imageUrl: provider.productViewModel!.results!.product!.productThambnail!,
                                        placeholder: (context, url) {
                                          return Image.asset('assets/loading.gif', fit: BoxFit.cover);
                                        },
                                        errorWidget: (context, url, error) => Image.asset('assets/loading.gif', fit: BoxFit.cover),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Kitchen Type",
                                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        provider.productViewModel!.results!.product!.productCode!,
                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.productViewModel!.results != null && provider.productViewModel!.results!.size != null && provider.productViewModel!.results!.size!.isNotEmpty,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          "Select Item Size",
                                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.productViewModel!.results != null && provider.productViewModel!.results!.size != null && provider.productViewModel!.results!.size!.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
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
                                            selectedItem: selectedItemsSize,
                                            mode: Mode.MENU,
                                            items: provider.productViewModel!.results!.size!.contains("NULL")? []:provider.productViewModel!.results!.size!,
                                            onChanged: (value) {
                                              selectedItemsSize = value ?? "";
                                              setState(() {});
                                            },
                                            dropdownBuilder: (context, selectedItems) {
                                              return Text(
                                                selectedItems! == "" ? "Item Size" : selectedItems,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: selectedItems == "" ? Constants.hintColor : Colors.black),
                                              );
                                            },
                                            showSearchBox: false,
                                            dropdownSearchDecoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintStyle:
                                                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Constants.hintColor),
                                              hintText: "Item Size",
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
                                    ),
                                    Visibility(
                                      visible: provider.productViewModel!.results != null && provider.productViewModel!.results!.saus != null && provider.productViewModel!.results!.saus!.isNotEmpty,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          "Add ingredients/Saus",
                                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.productViewModel!.results != null && provider.productViewModel!.results!.saus != null && provider.productViewModel!.results!.saus!.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
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
                                            selectedItem: selectedIngredients,
                                            mode: Mode.MENU,
                                            items: provider.productViewModel!.results!.saus!.contains("NULL")? []: provider.productViewModel!.results!.saus!,
                                            onChanged: (value) {
                                              selectedIngredients = value ?? "";
                                              setState(() {});
                                            },
                                            dropdownBuilder: (context, selectedItems) {
                                              return Text(
                                                selectedItems! == "" ? "Ingredients/Saus" : selectedItems,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: selectedItems == "" ? Constants.hintColor : Colors.black),
                                              );
                                            },
                                            showSearchBox: false,
                                            dropdownSearchDecoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintStyle:
                                                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Constants.hintColor),
                                              hintText: "Ingredients/Saus",
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Row(
                                        children: [
                                          const Text("Stock",
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14)),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            margin: const EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6.0),
                                              color: provider.productViewModel!.results!.product!.status! == 1 ? Colors.green : Colors.red,
                                            ),
                                            child: Text(
                                                provider.productViewModel!.results!.product!.status! == 1 ? "available" : "not available",
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Selling Price : €${provider.productViewModel!.results!.product!.sellingPrice!}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            decoration: TextDecoration.lineThrough),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Special Price : €${provider.productViewModel!.results!.product!.discountPrice!}",
                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Quantity",
                                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: TextFormField(
                                                controller: addMultipleController,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                keyboardType: TextInputType.number,
                                                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                                                decoration: InputDecoration(
                                                    hintText: "Enter Quantity",
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
                                                    contentPadding: const EdgeInsets.all(12))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
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

                                        if(!provider.productViewModel!.results!.size!.contains("NULL") && (postMdlCart.productViewModel!.results != null &&
                                            postMdlCart.productViewModel!.results!.size != null &&
                                            postMdlCart.productViewModel!.results!.size!.isNotEmpty) && selectedItemsSize.isEmpty){
                                          Constants.showToast("Please select Size");
                                        }else if (!provider.productViewModel!.results!.saus!.contains("NULL") && (postMdlCart.productViewModel!.results != null &&
                                            postMdlCart.productViewModel!.results!.saus != null &&
                                            postMdlCart.productViewModel!.results!.saus!.isNotEmpty) && selectedIngredients.isEmpty){
                                          Constants.showToast("Please select Ingredients/Saus");
                                        }else if (addMultipleController.text.trim().isEmpty){
                                          Constants.showToast("Please enter quantity");
                                        }else{

                                          await postMdlCart.addToCart(context, int.parse(provider.productViewModel!.results!.product!.id!),
                                              provider.productViewModel!.results!.product!.productNameEn!, addMultipleController.text.trim(), selectedItemsSize, selectedIngredients)
                                              .then((value) {
                                            if (postMdlCart.isFetching) {
                                              AppUtils.showLoaderList();
                                            }
                                            print("${postMdlCart.addtoCart?.results?.returnCartToken}");
                                            PreferenceHelper.setString(PreferenceHelper.CART_TOKEN, '${postMdlCart.addtoCart?.results?.returnCartToken}');

                                            print('========returnCartToken${PreferenceHelper.getString(PreferenceHelper.CART_TOKEN)}');
                                            returnType = true;
                                            Navigator.pop(context);
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
                                            'Add to Cart',
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
                      ),
                    );
                  },
                );
              },
            ));
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return const Text('');
      });

  return returnType;
}
