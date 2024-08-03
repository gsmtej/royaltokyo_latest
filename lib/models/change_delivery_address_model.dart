import '../DishesScreen/model/DishesRestaurantModel.dart';

class ChangeDeliveryAddressModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  ChangeDeliveryAddressModel({this.results, this.errors, this.status, this.msg});

  ChangeDeliveryAddressModel.fromJson(Map<String, dynamic> json) {
    results =
    json['results'] != null ? Results.fromJson(json['results']) : null;
    errors =
    json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.toJson();
    }
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Results {
  String? name;
  String? phoneNumber;
  String? addressRegister;
  String? cityRegister;
  String? postcodeRegister;
  String? minOrder;
  bool? isDeliveryAvailable;

  Results(
      {this.name,
        this.phoneNumber,
        this.addressRegister,
        this.cityRegister,
        this.postcodeRegister,
        this.minOrder,
        this.isDeliveryAvailable,
      });

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    addressRegister = json['address_register'];
    cityRegister = json['city_register'];
    postcodeRegister = json['postcode_register'];
    minOrder = json['minOrder'];
    isDeliveryAvailable = json['is_delivery_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['address_register'] = addressRegister;
    data['city_register'] = cityRegister;
    data['postcode_register'] = postcodeRegister;
    data['minOrder'] = minOrder;
    data['is_delivery_available'] = isDeliveryAvailable;
    return data;
  }
}