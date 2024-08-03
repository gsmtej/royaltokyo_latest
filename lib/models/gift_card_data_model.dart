import '../DishesScreen/model/DishesRestaurantModel.dart';

class GiftCardDataModel {
  List<Results>? results;
  Errors? errors;
  bool? status;
  String? msg;

  GiftCardDataModel({this.results, this.errors, this.status, this.msg});

  GiftCardDataModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    errors =
    json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Results {
  int? id;
  int? restaurantId;
  int? giftCardId;
  String? createdAt;
  String? updatedAt;
  GiftCard? giftCard;

  Results(
      {this.id,
        this.restaurantId,
        this.giftCardId,
        this.createdAt,
        this.updatedAt,
        this.giftCard});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    giftCardId = json['gift_card_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    giftCard = json['gift_card'] != null
        ? GiftCard.fromJson(json['gift_card'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['restaurant_id'] = restaurantId;
    data['gift_card_id'] = giftCardId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (giftCard != null) {
      data['gift_card'] = giftCard!.toJson();
    }
    return data;
  }
}

class GiftCard {
  int? id;
  String? name;
  String? userId;
  String? sharedUserId;
  String? giftCardNumber;
  String? amount;
  String? status;
  String? isAdmin;
  String? createdAt;
  String? updatedAt;

  GiftCard(
      {this.id,
        this.name,
        this.userId,
        this.sharedUserId,
        this.giftCardNumber,
        this.amount,
        this.status,
        this.isAdmin,
        this.createdAt,
        this.updatedAt});

  GiftCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'].toString();
    sharedUserId = json['shared_user_id'].toString();
    giftCardNumber = json['gift_card_number'];
    amount = json['amount'];
    status = json['status'];
    isAdmin = json['is_admin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_id'] = userId;
    data['shared_user_id'] = sharedUserId;
    data['gift_card_number'] = giftCardNumber;
    data['amount'] = amount;
    data['status'] = status;
    data['is_admin'] = isAdmin;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}