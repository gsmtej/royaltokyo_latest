import '../../RestaurantScreen/model/RestaurantProductModel.dart';

class AddressDetailsModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  AddressDetailsModel({this.results, this.errors, this.status, this.msg });

  AddressDetailsModel.fromJson(Map<String, dynamic> json) {
    results =
    json['results'] != null ? Results.fromJson(json['results']) : null;
    errors =
    json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    status = json['status'];
  }
}

class Results {
  DefaultAddress? defaultAddress;
  List<DefaultAddress>? customerAddresses;

  Results({this.defaultAddress, this.customerAddresses});

  Results.fromJson(Map<String, dynamic> json) {
    defaultAddress = json['defaultAddress'] != null
        ? DefaultAddress.fromJson(json['defaultAddress'])
        : null;
    if (json['customerAddresses'] != null) {
      customerAddresses = <DefaultAddress>[];
      json['customerAddresses'].forEach((v) {
        customerAddresses!.add(DefaultAddress.fromJson(v));
      });
    }
  }
}

class DefaultAddress {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? addressRegister;
  String? cityRegister;
  String? postcodeRegister;
  String? isDefault;
  String? userableId;
  String? userableType;
  String? createdAt;
  String? updatedAt;

  DefaultAddress(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.addressRegister,
        this.cityRegister,
        this.postcodeRegister,
        this.isDefault,
        this.userableId,
        this.userableType,
        this.createdAt,
        this.updatedAt});

  DefaultAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phoneNumber = json['phone_number'].toString();
    addressRegister = json['address_register'].toString();
    cityRegister = json['city_register'].toString();
    postcodeRegister = json['postcode_register'].toString();
    isDefault = json['is_default'].toString();
    userableId = json['userable_id'].toString();
    userableType = json['userable_type'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }
}
