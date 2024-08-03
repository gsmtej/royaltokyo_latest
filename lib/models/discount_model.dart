import '../cart/model/AddtoCartModel.dart';

class DiscountModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  DiscountModel({this.results, this.errors, this.status, this.msg});

  DiscountModel.fromJson(Map<String, dynamic> json) {
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
  Discount? discount;

  Results({this.discount});

  Results.fromJson(Map<String, dynamic> json) {
    discount = json['discount'] != null
        ? Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (discount != null) {
      data['discount'] = discount!.toJson();
    }
    return data;
  }
}

class Discount {
  String? takeAwayDiscount;
  String? deliveryDiscount;

  Discount({this.takeAwayDiscount, this.deliveryDiscount});

  Discount.fromJson(Map<String, dynamic> json) {
    takeAwayDiscount = json['take_away_discount'] ?? "0";
    deliveryDiscount = json['delivery_discount'] ?? "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['take_away_discount'] = takeAwayDiscount;
    data['delivery_discount'] = deliveryDiscount;
    return data;
  }
}
