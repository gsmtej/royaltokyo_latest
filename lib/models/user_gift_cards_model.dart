import '../DishesScreen/model/DishesRestaurantModel.dart';

class UserGiftCardsModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  UserGiftCardsModel({this.results, this.errors, this.status, this.msg});

  UserGiftCardsModel.fromJson(Map<String, dynamic> json) {
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
  List<UserGiftCard>? userGiftCard;
  List<UserGiftCard>? sharedGiftCard;

  Results({this.userGiftCard, this.sharedGiftCard});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['user_gift_card'] != null) {
      userGiftCard = <UserGiftCard>[];
      json['user_gift_card'].forEach((v) {
        userGiftCard!.add(UserGiftCard.fromJson(v));
      });
    }
    if (json['shared_gift_card'] != null) {
      sharedGiftCard = <UserGiftCard>[];
      json['shared_gift_card'].forEach((v) {
        sharedGiftCard!.add(UserGiftCard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userGiftCard != null) {
      data['user_gift_card'] =
          userGiftCard!.map((v) => v.toJson()).toList();
    }
    if (sharedGiftCard != null) {
      data['shared_gift_card'] =
          sharedGiftCard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserGiftCard {
  int? id;
  int? userId;
  int? sharedUserId;
  int? giftCardId;
  int? amount;
  String? isPaymentReceived;
  String? createdAt;
  String? updatedAt;
  GiftCard? giftCard;

  UserGiftCard(
      {this.id,
        this.userId,
        this.sharedUserId,
        this.giftCardId,
        this.amount,
        this.isPaymentReceived,
        this.createdAt,
        this.updatedAt,
        this.giftCard});

  UserGiftCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sharedUserId = json['shared_user_id'];
    giftCardId = json['gift_card_id'];
    amount = json['amount'];
    isPaymentReceived = json['is_payment_received'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    giftCard = json['gift_card'] != null
        ? GiftCard.fromJson(json['gift_card'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['shared_user_id'] = sharedUserId;
    data['gift_card_id'] = giftCardId;
    data['amount'] = amount;
    data['is_payment_received'] = isPaymentReceived;
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
  int? userId;
  int? sharedUserId;
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
    name = json['name'] ?? "Gift Card";
    userId = json['user_id'];
    sharedUserId = json['shared_user_id'];
    giftCardNumber = json['gift_card_number'];
    amount = json['amount'] ?? "0";
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
