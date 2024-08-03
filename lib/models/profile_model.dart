import '../cart/model/CartModel.dart';

class ProfileModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  ProfileModel({this.results, this.errors, this.status, this.msg});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  User? addresses;
  Referral? referral;
  String? type;

  Results({this.user, this.addresses, this.referral, this.type});

  Results.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    addresses =
    json['addresses'] != null ? User.fromJson(json['addresses']) : null;
    referral = json['referral'] != null
        ? Referral.fromJson(json['referral'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (addresses != null) {
      data['addresses'] = addresses!.toJson();
    }
    if (referral != null) {
      data['referral'] = referral!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  int? status;
  String? deviceToken;
  String? referralCode;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  List<CustomerAddresses>? customerAddresses;

  User(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.emailVerifiedAt,
        this.status,
        this.deviceToken,
        this.referralCode,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.customerAddresses});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'].toString();
    status = json['status'];
    deviceToken = json['device_token'];
    referralCode = json['referral_code'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['customer_addresses'] != null) {
      customerAddresses = <CustomerAddresses>[];
      json['customer_addresses'].forEach((v) {
        customerAddresses!.add(CustomerAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['status'] = status;
    data['device_token'] = deviceToken;
    data['referral_code'] = referralCode;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (customerAddresses != null) {
      data['customer_addresses'] =
          customerAddresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAddresses {
  int? id;
  String? name;
  String? phoneNumber;
  String? addressRegister;
  String? cityRegister;
  String? postcodeRegister;
  String? isDefault;
  int? userableId;
  String? userableType;
  String? createdAt;
  String? updatedAt;

  CustomerAddresses(
      {this.id,
        this.name,
        this.phoneNumber,
        this.addressRegister,
        this.cityRegister,
        this.postcodeRegister,
        this.isDefault,
        this.userableId,
        this.userableType,
        this.createdAt,
        this.updatedAt});

  CustomerAddresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    addressRegister = json['address_register'];
    cityRegister = json['city_register'];
    postcodeRegister = json['postcode_register'];
    isDefault = json['is_default'];
    userableId = json['userable_id'];
    userableType = json['userable_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['address_register'] = addressRegister;
    data['city_register'] = cityRegister;
    data['postcode_register'] = postcodeRegister;
    data['is_default'] = isDefault;
    data['userable_id'] = userableId;
    data['userable_type'] = userableType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Referral {
  int? referredPeople;
  String? totalCommissionAmount;
  String? referralCode;

  Referral(
      {this.referredPeople, this.totalCommissionAmount, this.referralCode});

  Referral.fromJson(Map<String, dynamic> json) {
    referredPeople = json['referred_people'];
    totalCommissionAmount = json['total_commission_amount'];
    referralCode = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referred_people'] = referredPeople;
    data['total_commission_amount'] = totalCommissionAmount;
    data['referral_code'] = referralCode;
    return data;
  }
}
