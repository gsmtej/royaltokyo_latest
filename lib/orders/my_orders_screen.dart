import 'package:buyer_app/global/constants.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/global/responsive.dart';
import 'package:buyer_app/home/home_screen.dart';
import 'package:buyer_app/models/my_orders_model.dart';
import 'package:buyer_app/providers/OrdersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  final bool? isFromOrderSuccess;

  const MyOrdersScreen({super.key, this.isFromOrderSuccess});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    getMyOrdersList();
  }

  Future<void> getMyOrdersList() async {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    await ordersProvider.getMyOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () {
            if (widget.isFromOrderSuccess == true) {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
            } else {
              Navigator.pop(context);
            }
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
                  "My Orders",
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                ),
                centerTitle: true,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (widget.isFromOrderSuccess == true) {
                        Navigator.of(context)
                            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
                      } else {
                        Navigator.pop(context);
                      }
                    })),
            body: RefreshIndicator(
              onRefresh: () async {
                await provider.getMyOrders(context);
                return Future.value(true);
              },
              child: provider.isFetching || provider.myOrdersModel == null
                  ? AppUtils.showLoaderList()
                  :  provider.myOrdersModel == null || provider.myOrdersModel!.results == null?
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/ic_not_avail.jpg",
                      height: 150,
                      width: 220,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                          child: Text(
                            "You have not placed any order",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.grey),
                          )),
                    ),
                  ],
                ),
              ):SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child:
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: ListView.builder(
                                itemCount: provider.myOrdersModel!.results!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (c, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Constants.borderLightGrey, width: 0.5),
                                        borderRadius: BorderRadius.circular(8.0),
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
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                                            ),
                                            child: Text(
                                              "Order: #${provider.myOrdersModel!.results![index].orderNumber}",
                                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: "Order Type: ",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: provider.myOrdersModel!.results![index].orderType == "is_delivery"
                                                    ? "Delivery"
                                                    : "Take away",
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.green),
                                              ),
                                            ])),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: "Payment Method: ",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: provider.myOrdersModel!.results![index].paymentType == "mp"
                                                    ? "Bank Contact / Credit Card Payment"
                                                    : "Cash on Delivery (COD)",
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.green),
                                              ),
                                            ])),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: "Delivery Address: ",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: "${provider.myOrdersModel!.results![index].customerAddress!.addressRegister}, "
                                                    "${provider.myOrdersModel!.results![index].customerAddress!.cityRegister}, "
                                                    "${provider.myOrdersModel!.results![index].customerAddress!.postcodeRegister}",
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                                              ),
                                            ])),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: "Ordered On: ",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: provider.myOrdersModel!.results![index].orderType == "is_delivery" ? ("${provider.myOrdersModel!.results![index].deliveryDate ?? ""} ${provider.myOrdersModel!.results![index].orderTime ?? ""}") : ("${provider.myOrdersModel!.results![index].pickupDate ?? ""} ${provider.myOrdersModel!.results![index].orderTime ?? ""}"),
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                                              ),
                                            ])),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: Text(
                                              "Items Ordered: ",
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: Table(
                                              border: TableBorder(
                                                  horizontalInside: BorderSide(
                                                    color: Colors.grey.withOpacity(0.5),
                                                  )),
                                              children:  [
                                                const TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 8.0, right: 2),
                                                      child: Text(
                                                        "Product Name",
                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 8.0, right: 2),
                                                      child: Text(
                                                        "Product Size",
                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 8.0, right: 2),
                                                      child: Text(
                                                        "Quantity",
                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 8.0, right: 2),
                                                      child: Text(
                                                        "Price",
                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TableRow(
                                                  children: [
                                                    Container(),
                                                    Container(),
                                                    Container(),
                                                    Container(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: ListView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: provider.myOrdersModel!.results![index].orderItems!.length,
                                              itemBuilder: (context, currentIndex) {
                                                OrderItems orderItems = provider.myOrdersModel!.results![index].orderItems![currentIndex];
                                              return Table(
                                                border: TableBorder(
                                                    horizontalInside: BorderSide(
                                                      color: Colors.grey.withOpacity(0.5),
                                                    )),
                                                children:  [
                                                  TableRow(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(orderItems.productname!),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(orderItems.productsize!),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(orderItems.qty!),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text("EUR ${orderItems.price!}"),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Container(),
                                                      Container(),
                                                      Container(),
                                                      Container(),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: "Tax: ",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: "EUR ${provider.myOrdersModel!.results![index].tax}",
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.redAccent),
                                              ),
                                            ])),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: "Subtotal: ",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: "EUR ${provider.myOrdersModel!.results![index].originalAmount}",
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.redAccent),
                                              ),
                                            ])),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                                  const TextSpan(
                                                    text: "Gift Card Discount: ",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                                  ),
                                                  TextSpan(
                                                    text: "EUR ${provider.myOrdersModel!.results![index].giftCardAmount}",
                                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.redAccent),
                                                  ),
                                                ])),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: "Total: ",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: "EUR ${provider.myOrdersModel!.results![index].originalAmount}",
                                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.redAccent),
                                              ),
                                            ])),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15, bottom: 15),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: "Order Status: ",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: provider.myOrdersModel!.results![index].orderStatus,
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.orange),
                                              ),
                                            ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
