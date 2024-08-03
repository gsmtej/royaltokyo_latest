import 'dart:convert';

import 'package:buyer_app/models/restaurant_list_model.dart';
import 'package:http/http.dart' as http;

Future<RestaurantModel> getRestaurantApi() async {
  final response = await http
      .get(Uri.parse('https://www.royaltokyosushi.be/api/details/restaurants'));
  var restaurnt = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    return RestaurantModel.fromJson(restaurnt);
  } else {
    return RestaurantModel.fromJson(restaurnt);
  }
}
