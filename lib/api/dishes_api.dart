import 'dart:convert';

import 'package:buyer_app/models/dishes.dart';
import 'package:http/http.dart' as http;

Future<DishesList> getDishesApi() async {
  final response = await http.get(
      Uri.parse('https://www.royaltokyosushi.be/api/details/popular-dishes'));
  var dish = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    return DishesList.fromJson(dish);
  } else {
    return DishesList.fromJson(dish);
  }
}
