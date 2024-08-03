import 'package:buyer_app/api/restaurant_list_api.dart';
import 'package:buyer_app/models/restaurant_list_model.dart';
import 'package:flutter/material.dart';



class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  Widget build(BuildContext context) {
    
return Scaffold(
    resizeToAvoidBottomInset: false,
    
      appBar: AppBar(
        title: const Text('Restaurant List'),
        centerTitle: true,
        actions: const [
          Center(
           child: Icon(Icons.shopping_bag_outlined),           
             
            ),
        ],
      ),
      
    body: 
    
    Column(
      children: [
        Expanded(
          child: FutureBuilder<RestaurantModel>(
          future: getRestaurantApi (),
           builder: (context, snapshot){
          
          return ListView.builder(
              itemCount: snapshot.data!.restaurnt!.length,
              itemBuilder: (context, index) 
              {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image(
                              height: 90,
                              width: 90,
                              image: NetworkImage(snapshot.data!.restaurnt![index].resImage!.toString()),
                              ),
                              const SizedBox(width: 10,),
                            Column(
                              children: [
                                Text(snapshot.data!.restaurnt![index].restaurantname!.toString(),
                                style: const TextStyle(fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5,),
                                                         
                                Text((snapshot.data!.restaurnt![index].address!.toString()) + ',' +' '+ snapshot.data!.restaurnt![index].postcode!.toString() + ' ' +snapshot.data!.restaurnt![index].city!.toString(),                                
                                style: const TextStyle(fontFamily: "Poppins", fontSize: 12, fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(height: 5,),

                                const Text(('Review:'),
                                 style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                                ),
                                const SizedBox(height: 5,),
                              ],
                            ),

                            Column(
                              children: [
                              Text(('Price:10'),
                                 style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                                ),
                                const SizedBox(height: 5,),

                            ],),




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
