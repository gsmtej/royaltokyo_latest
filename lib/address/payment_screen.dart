import 'package:buyer_app/address/summary_screen.dart';
import 'package:flutter/material.dart';

import '../global/constants.dart';
import '../global/responsive.dart';
import '../models/discount_model.dart';
import 'model/address_details_model.dart';

class PaymentScreen extends StatefulWidget{
  final String? date;
  final String? hour;
  final String? orderType;
  final String? notes;
  final DefaultAddress? deliveryAddress;
  final DiscountModel? discountModel;
  const PaymentScreen({super.key, this.date, this.hour, this.orderType,this.notes, this.deliveryAddress, this.discountModel});

  @override
  State<StatefulWidget> createState() {
    return PaymentScreenState();
  }
  
}
class PaymentScreenState extends State<PaymentScreen>{

  String paymentType = "Bank";

  @override
  Widget build(BuildContext context) {
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
          "Payment",
          style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 15, left: 15, right: 15),
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            style: Constants.buttonStyle(),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) =>  SummaryScreen(date: widget.date,
                        hour: widget.hour, orderType: widget.orderType,
                        discountModel: widget.discountModel,
                        paymentType : paymentType,
                        notes: widget.notes, deliveryAddress: widget.deliveryAddress,)));
            },
            child:  const Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  'Summary',
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, right:15, left: 15),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Responsive.width(100, context),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                ),
                child: const Text(
                  "Select the Payment Method",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentType = "Bank";
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: AbsorbPointer(
                              absorbing: true,
                              child: Radio(
                                activeColor: Colors.green,
                                value: "Bank",
                                groupValue: paymentType,
                                onChanged: (Object? value) {},
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Bank Contact/Credit Card",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible : true,
                      // visible : widget.orderType == "Delivery",
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              paymentType = "Cod";
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: Radio(
                                    activeColor: Colors.green,
                                    value: "Cod",
                                    groupValue: paymentType,
                                    onChanged: (Object? value) {},
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Cash on Delivery (COD)",
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}