import 'dart:async';

import 'package:buyer_app/global/constants.dart';
import 'package:buyer_app/mollie_payment/loader.dart';
import 'package:buyer_app/orders/order_success_dialog.dart';
import 'package:buyer_app/providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:mollie_flutter/mollie.dart';
import 'package:provider/provider.dart';

import '../global/PreferenceHelper.dart';

class MolliePaymentScreen extends StatefulWidget {
  final Map<String, dynamic>? body;
  final String? total;
  final bool? isLoading;
  const MolliePaymentScreen({super.key, this.body, this.total, this.isLoading});

  @override
  State<StatefulWidget> createState() {
    return MolliePaymentScreenState();
  }
}

class MolliePaymentScreenState extends State<MolliePaymentScreen> {
  String paymentId = "";
  String paymentStatus = 'unknown';
  Timer? statusTimer;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    client.init(PreferenceHelper.getString(PreferenceHelper.MOLLIE_KEY) ?? "");
    if (widget.isLoading != null) {
      isLoading.value = widget.isLoading!;
    }
    super.initState();
  }

  Future<void> createOrder(String method) async {
    print(
        "clientId==>${PreferenceHelper.getString(PreferenceHelper.MOLLIE_KEY) ?? ""}");
    print("amount==>${double.parse(widget.total ?? "0.0").toStringAsFixed(2)}");
    MolliePaymentRequest r = MolliePaymentRequest(
      amount: MollieAmount(
        currency: 'EUR',
        value: double.parse(widget.total ?? "0.0").toStringAsFixed(2),
      ),
      method: method,
      description:
          widget.body!['notes'] == "" ? "Order" : widget.body!['notes'],
      redirectUrl: 'be.royaltokyosushi.userapp://payment-redirect',
      webhookUrl: 'https://royaltokyosushi.be/',
    );

    MolliePaymentResponse p = await client.payments.create(r);

    client.init(PreferenceHelper.getString(PreferenceHelper.MOLLIE_KEY) ?? "");
    print("data==>${p.checkoutUrl}");
    print("data==>${p.id}");

    paymentId = p.id!;
    paymentStatus = "open";

    startStatusTimer();

    final result = await FlutterWebAuth2.authenticate(
        url: p.checkoutUrl ?? "",
        callbackUrlScheme: 'be.royaltokyosushi.userapp');
    print("result==>$result");
  }

  void startStatusTimer() {
    stopStatusTimer();

    statusTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkPaymentStatus();
    });
  }

  void stopStatusTimer() {
    if (statusTimer != null && statusTimer!.isActive) {
      statusTimer!.cancel();
    }
  }

  void checkPaymentStatus() async {
    MolliePaymentResponse paymentResp =
        await client.payments.get(paymentId ?? "");
    print("data==>11 ${paymentResp.status}");

    if (paymentResp.status == "paid") {
      isLoading.value = true;

      stopStatusTimer();
      final provider = Provider.of<CartProvider>(context, listen: false);
      widget.body!['payment_id'] = paymentId ?? "";
      await provider
          .molliePaymentOrder(context, widget.body!)
          .then((value) async {
        isLoading.value = false;
        if (value != null && value["status"] == true) {
          await orderSuccessDialog(context, price: widget.total);
        } else {
          Constants.showToast(value["message"] == "null"
              ? "Something went wrong, please try again later"
              : value["message"]);
        }
      });
    } else {
      // stopStatusTimer();
      // isLoading.value = false;
      // Constants.showToast("Something went wrong, please try again later!");
    }
  }

  @override
  void dispose() {
    stopStatusTimer();
    isLoading.dispose();
    super.dispose();
  }

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
        title: const Text(
          "Select Payment Method",
          style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: MollieCheckoutOptions(
                paymentOptions: [
                  PaymentOptions.bancontact,
                  PaymentOptions.creditcard,
                  PaymentOptions.paypal,
                ],
                style: CheckoutStyle(
                  buttonColor: Colors.white,
                ),
                onMethodSelected: (method) {
                  createOrder(method);
                },
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) {
              return Container(
                  child: value == true ? const Loader() : Container());
            },
          )
        ],
      ),
    );
  }
}
