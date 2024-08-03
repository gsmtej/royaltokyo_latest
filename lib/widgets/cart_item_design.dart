import 'package:buyer_app/models/items.dart';
import 'package:flutter/material.dart';


class CartItemDesign extends StatefulWidget
{
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber,
  });

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              //image
              Expanded(child:   Image.network(widget.model?.thumbnailUrl ?? "",), ),
              SizedBox(width: 6,),
              //title
              //quantity number
              //price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //title
                  Text(
                    widget.model?.title ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),

                  //quantity number // x 7
                  Row(
                    children: [
                      const Text(
                        "x ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        widget.quanNumber.toString() ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),

                  //price
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        "€ ",
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: "Poppins",
                            fontSize: 14.0
                        ),
                      ),
                      Text(
                          widget.model?.price.toString() ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: Colors.green,
                          )
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
