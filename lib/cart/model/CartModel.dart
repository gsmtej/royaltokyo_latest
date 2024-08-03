class CartModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  CartModel({this.results, this.errors, this.status,this.msg});

  CartModel.fromJson(Map<String, dynamic> json) {
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Results {
  // List<Carts>? carts;
  // num? totalQty;
  // num? cartQty;
  // num? cartSubtotal;
  // num? discountApplied;
  // dynamic? orderTypeDiscount;
  // double? cartTotal;
  // dynamic? cartTax;
  // String? returnCartToken;


  List<Carts>? carts;
  dynamic cartQty;
  dynamic itemQty;
  dynamic cartSubtotal;
  dynamic discountApplied;
  dynamic orderTypeDiscount;
  dynamic cartTotal;
  dynamic cartTax;
  dynamic returnCartToken;
  dynamic restaurantId;


  Results(
      {this.carts,
        this.cartQty,
        this.cartSubtotal,
        this.discountApplied,
        this.orderTypeDiscount,
        this.cartTotal,
        this.cartTax,
        this.returnCartToken,
      this.restaurantId});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
    cartQty = json['cartQty'];
    cartSubtotal = json['cartSubtotal'];
    discountApplied = json['discountApplied'];
    orderTypeDiscount = json['orderTypeDiscount'];
    cartTotal = json['cartTotal'];
    cartTax = json['cartTax'];
    returnCartToken = json['returnCartToken'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    data['cartQty'] = this.cartQty;
    data['cartSubtotal'] = this.cartSubtotal;
    data['discountApplied'] = this.discountApplied;
    data['orderTypeDiscount'] = this.orderTypeDiscount;
    data['cartTotal'] = this.cartTotal;
    data['cartTax'] = this.cartTax;
    data['returnCartToken'] = this.returnCartToken;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}


class Carts {
  // String? rowId;
  // String? id;
  // String? name;
  // dynamic? qty;
  // dynamic? price;
  // num? weight;
  // Options? options;
  // num? discount;
  // dynamic? tax;
  // num? subtotal;

  String? rowId;
  int? id;
  String? name;
  String? qty;
  String? price;
  String? weight;
  Options? options;
  int? discount;
  String? tax;
  String? subtotal;

  Carts(
      {this.rowId,
        this.id,
        this.name,
        this.qty,
        this.price,
        this.weight,
        this.options,
        this.discount,
        this.tax,
        this.subtotal});

  Carts.fromJson(Map<String, dynamic> json) {
    rowId = json['rowId'];
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    price = json['price'];
    weight = json['weight'];
    options =
    json['options'] != null ? Options.fromJson(json['options']) : null;
    discount = json['discount'];
    tax = json['tax'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowId'] = this.rowId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['weight'] = this.weight;
    if (this.options != null) {
      data['options'] = this.options!.toJson();
    }
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['subtotal'] = this.subtotal;
    return data;
  }
}

class Options {
  String? image;
  String? size;
  String? saus;

  Options({this.image, this.size, this.saus});

  Options.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    size = json['size'];
    saus = json['saus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['size'] = this.size;
    data['saus'] = this.saus;
    return data;
  }
}

class Errors {
  String? errorMessage;

  Errors({this.errorMessage});

  Errors.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}
