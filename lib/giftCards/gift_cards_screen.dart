import 'package:buyer_app/giftCards/transfer_gift_card_dialog.dart';
import 'package:buyer_app/models/user_gift_cards_model.dart';
import 'package:buyer_app/providers/RestaurantProductProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../global/constants.dart';
import '../global/global.dart';
import '../global/responsive.dart';
import '../home/home_screen.dart';

class GiftCardsScreen extends StatefulWidget {
  final bool? isFromPurchasedSuccess;
  const GiftCardsScreen({super.key, this.isFromPurchasedSuccess});

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  @override
  void initState() {
    super.initState();
    getUserGiftCardsList();
  }

  Future<void> getUserGiftCardsList() async {
    final provider =
        Provider.of<RestaurantProductProvider>(context, listen: false);
    await provider.getUserGiftCards(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProductProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () {
            if (widget.isFromPurchasedSuccess == true) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false);
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
                  "Gift Cards",
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                ),
                centerTitle: true,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (widget.isFromPurchasedSuccess == true) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (Route<dynamic> route) => false);
                      } else {
                        Navigator.pop(context);
                      }
                    })),
            body: RefreshIndicator(
              onRefresh: () async {
                await provider.getUserGiftCards(context);
                return Future.value(true);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "User Gift Cards",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      provider.isFetchingGiftCards ||
                              provider.userGiftCardDataModel == null
                          ? AppUtils.showLoaderList()
                          : provider.userGiftCardDataModel == null ||
                                  provider.userGiftCardDataModel!.results ==
                                      null ||
                                  provider.userGiftCardDataModel!.results!
                                      .userGiftCard!.isEmpty
                              ? Center(
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
                                          "You have not any Gift Cards",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                              color: Colors.grey),
                                        )),
                                      ),
                                    ],
                                  ),
                                )
                              : AlignedGridView.count(
                                  padding: EdgeInsets.zero,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.userGiftCardDataModel!
                                      .results!.userGiftCard!.length,
                                  cacheExtent: 999999999999999,
                                  itemBuilder: (context, index) {
                                    GiftCard? giftCard = provider
                                        .userGiftCardDataModel!
                                        .results!
                                        .userGiftCard![index]
                                        .giftCard;
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.orange),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.9),
                                              blurRadius: 3.0,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                width: Responsive.width(
                                                    100, context),
                                                height: Responsive.height(
                                                    20, context),
                                                imageUrl:
                                                    "https://royaltokyosushi.be/frontend/assets/img/giftcard.jpg",
                                                placeholder: (context, url) {
                                                  return Image.asset(
                                                      'assets/loading.gif',
                                                      fit: BoxFit.cover);
                                                },
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/loading.gif',
                                                        fit: BoxFit.cover),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                              ),
                                              child: Text(
                                                  "${giftCard!.name} (${giftCard.amount ?? "0.0"})",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                              ),
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                const TextSpan(
                                                    text:
                                                        "This gift is equivalent to amount ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14)),
                                                TextSpan(
                                                    text: giftCard.amount ??
                                                        "0.0",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                                const TextSpan(
                                                    text:
                                                        ", you can transfer this gift card, to your friend after purchasing it.",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14)),
                                              ])),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(provider
                                                                    .userGiftCardDataModel!
                                                                    .results!
                                                                    .userGiftCard![
                                                                        index]
                                                                    .sharedUserId ==
                                                                null &&
                                                            giftCard.status ==
                                                                "1"
                                                        ? Colors.orange
                                                        : Colors.orange
                                                            .withOpacity(0.8)),
                                                    elevation: MaterialStateProperty.all(
                                                        0),
                                                    foregroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors.transparent),
                                                    overlayColor: MaterialStateProperty.all(
                                                        Colors.transparent),
                                                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                    shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    )),
                                                onPressed: () async {
                                                  if (provider
                                                              .userGiftCardDataModel!
                                                              .results!
                                                              .userGiftCard![
                                                                  index]
                                                              .sharedUserId ==
                                                          null &&
                                                      giftCard.status == "1") {
                                                    await transferGiftCardDialog(
                                                            context,
                                                            provider,
                                                            giftCard.id
                                                                .toString())
                                                        .then((value) async {
                                                      if (value == true) {
                                                        await provider
                                                            .getUserGiftCards(
                                                                context);
                                                      }
                                                    });
                                                  }
                                                },
                                                child: Center(
                                                  child: Text(
                                                    provider
                                                                    .userGiftCardDataModel!
                                                                    .results!
                                                                    .userGiftCard![
                                                                        index]
                                                                    .sharedUserId ==
                                                                null &&
                                                            giftCard.status ==
                                                                "1"
                                                        ? "Transfer to friend"
                                                        : provider
                                                                        .userGiftCardDataModel!
                                                                        .results!
                                                                        .userGiftCard![
                                                                            index]
                                                                        .sharedUserId !=
                                                                    null &&
                                                                giftCard.status ==
                                                                    "1"
                                                            ? "Already Transferred"
                                                            : 'Expired',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Shared Gift Cards",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      provider.isFetchingGiftCards ||
                              provider.userGiftCardDataModel == null
                          ? AppUtils.showLoaderList()
                          : provider.userGiftCardDataModel == null ||
                                  provider.userGiftCardDataModel!.results ==
                                      null ||
                                  provider.userGiftCardDataModel!.results!
                                      .sharedGiftCard!.isEmpty
                              ? Center(
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
                                          "You have not any Gift Cards",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                              color: Colors.grey),
                                        )),
                                      ),
                                    ],
                                  ),
                                )
                              : AlignedGridView.count(
                                  padding: EdgeInsets.zero,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.userGiftCardDataModel!
                                      .results!.sharedGiftCard!.length,
                                  cacheExtent: 999999999999999,
                                  itemBuilder: (context, index) {
                                    GiftCard? giftCard = provider
                                        .userGiftCardDataModel!
                                        .results!
                                        .sharedGiftCard![index]
                                        .giftCard;
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.orange),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.9),
                                              blurRadius: 3.0,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                width: Responsive.width(
                                                    100, context),
                                                height: Responsive.height(
                                                    20, context),
                                                imageUrl:
                                                    "https://royaltokyosushi.be/frontend/assets/img/giftcard.jpg",
                                                placeholder: (context, url) {
                                                  return Image.asset(
                                                      'assets/loading.gif',
                                                      fit: BoxFit.cover);
                                                },
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/loading.gif',
                                                        fit: BoxFit.cover),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                              ),
                                              child: Text(
                                                  "${giftCard!.name} (${giftCard.amount ?? "0.0"})",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                              ),
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                const TextSpan(
                                                    text:
                                                        "This gift is equivalent to amount ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14)),
                                                TextSpan(
                                                    text: giftCard.amount ??
                                                        "0.0",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                                const TextSpan(
                                                    text:
                                                        ", you can transfer this gift card, to your friend after purchasing it.",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14)),
                                              ])),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(provider
                                                                    .userGiftCardDataModel!
                                                                    .results!
                                                                    .sharedGiftCard![
                                                                        index]
                                                                    .sharedUserId ==
                                                                null &&
                                                            giftCard.status ==
                                                                "1"
                                                        ? Colors.orange
                                                        : Colors.orange
                                                            .withOpacity(0.8)),
                                                    elevation: MaterialStateProperty.all(
                                                        0),
                                                    foregroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors.transparent),
                                                    overlayColor: MaterialStateProperty.all(
                                                        Colors.transparent),
                                                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                    shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    )),
                                                onPressed: () async {
                                                  if (provider
                                                              .userGiftCardDataModel!
                                                              .results!
                                                              .sharedGiftCard![
                                                                  index]
                                                              .sharedUserId ==
                                                          null &&
                                                      giftCard.status == "1") {
                                                    await transferGiftCardDialog(
                                                            context,
                                                            provider,
                                                            giftCard.id
                                                                .toString())
                                                        .then((value) async {
                                                      if (value == true) {
                                                        await provider
                                                            .getUserGiftCards(
                                                                context);
                                                      }
                                                    });
                                                  } else if (provider
                                                              .userGiftCardDataModel!
                                                              .results!
                                                              .sharedGiftCard![
                                                                  index]
                                                              .sharedUserId !=
                                                          null &&
                                                      giftCard.status == "1") {
                                                    await Clipboard.setData(
                                                        ClipboardData(
                                                      text: giftCard
                                                              .giftCardNumber ??
                                                          "",
                                                    ));
                                                    Constants.showToast(
                                                        "Gift card number ${giftCard.giftCardNumber ?? ""} copied successfully!");
                                                  }
                                                },
                                                child: Center(
                                                  child: Text(
                                                    provider
                                                                    .userGiftCardDataModel!
                                                                    .results!
                                                                    .sharedGiftCard![
                                                                        index]
                                                                    .sharedUserId ==
                                                                null &&
                                                            giftCard.status ==
                                                                "1"
                                                        ? "Transfer to friend"
                                                        : provider
                                                                        .userGiftCardDataModel!
                                                                        .results!
                                                                        .sharedGiftCard![
                                                                            index]
                                                                        .sharedUserId !=
                                                                    null &&
                                                                giftCard.status ==
                                                                    "1" &&
                                                                giftCard.amount !=
                                                                    "0"
                                                            ? "${giftCard.giftCardNumber}"
                                                            : 'Expired',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
