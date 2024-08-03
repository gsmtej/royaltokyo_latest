import 'package:buyer_app/models/items.dart';
import 'package:buyer_app/models/menus.dart';
import 'package:buyer_app/widgets/app_bar.dart';
import 'package:buyer_app/widgets/items_design.dart';
import 'package:buyer_app/widgets/progress_bar.dart';
import 'package:buyer_app/widgets/text_widget_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class ItemsScreen extends StatefulWidget {
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}


class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.menuTitle.toString())),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
                .orderBy("publishedDate", descending: false)
                .snapshots(),
            builder: (context, snapshot)
            {
              return
                // !snapshot.hasData
                //   ?
                SliverToBoxAdapter(
                      child: Center(child: circularProgress(),),
                    )
                  ;
                  // : SliverStaggeredGrid.countBuilder(
                  //     crossAxisCount: 1,
                  //     staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  //     itemBuilder: (context, index)
                  //     {
                  //       Items model = Items.fromJson(
                  //         snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  //       );
                  //       return ItemsDesignWidget(
                  //         model: model,
                  //         context: context,
                  //       );
                  //     },
                  //     itemCount: snapshot.data!.docs.length,
                  //   );
            },
          ),
        ],
      ),
    );
  }
}


