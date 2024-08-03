import 'package:buyer_app/api/dishes_api.dart';
import 'package:buyer_app/models/dishes.dart';
import 'package:flutter/material.dart';



class FoodCategoryScreen extends StatefulWidget {
  const FoodCategoryScreen({super.key});

  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  


  @override
  Widget build(BuildContext context) {

return Scaffold(
      appBar: AppBar(
        title: const Text('Cuisine List'),
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
          child: FutureBuilder<DishesList>(
          future: getDishesApi (),
        builder: (context, snapshot){
          return ListView.builder(
              itemCount: snapshot.data!.dish!.length,
              itemBuilder: (context, index) 
              {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image(
                              height: 90,
                              width: 90,
                              image: NetworkImage(snapshot.data!.dish![index].fcImage!.toString()),
                              ),
                              const SizedBox(width: 10,),

                            Column(
                              children: [
                                Text(snapshot.data!.dish![index].foodcategory!.toString(),
                                style: const TextStyle(fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5,),
                          
                                const Text(('Total Restaurants : 100'),
                                 style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                                ),
                                const SizedBox(height: 5,),
                                const Text('Average Price :'),
                                Text((snapshot.data!.dish![index].fcAverageprice!.toString()) + ' €',
                                style: const TextStyle(fontFamily: "Poppins", fontSize: 12, fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(height: 5,),


                              ],
                            )
                        
                          
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              
            );
          }
        ),
       ),
      ],
    ),
  
  );

}
}


     