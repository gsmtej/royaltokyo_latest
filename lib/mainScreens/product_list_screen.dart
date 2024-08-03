import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super (key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,
        actions: const [
          Center(
           child: Icon(Icons.shopping_bag_outlined),           
             
            ),
        ],
        
        
      ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(index.toString())
                      ],)

                  ],
                ),
              );
            },
            ),
        ),
      ]),
    );
  }
} 