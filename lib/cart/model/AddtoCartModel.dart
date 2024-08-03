class AddtoCartModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;


  AddtoCartModel({this.results, this.errors, this.status,this.msg});

  AddtoCartModel.fromJson(Map<String, dynamic> json) {
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
  String? subtotal;
  num? grandtotal;
  String? message;
  // CartItems? cartItems;
  String? returnCartToken;

  Results(
      {this.subtotal,
        this.grandtotal,
        this.message,
        // this.cartItems,
        this.returnCartToken});

  Results.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    grandtotal = json['grandtotal'];
    message = json['message'];
    // cartItems = json['cart_items'] != null
    //     ? new CartItems.fromJson(json['cart_items'])
    //     : null;
    returnCartToken = json['returnCartToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['grandtotal'] = this.grandtotal;
    data['message'] = this.message;
    // if (this.cartItems != null) {
    //   data['cart_items'] = this.cartItems!.toJson();
    // }
    data['returnCartToken'] = this.returnCartToken;
    return data;
  }
}

// class CartItems {
//   String? rowId;
//   String? id;
//   int? qty;
//   String? name;
//   int? price;
//   int? weight;
//   Options? options;
//   int? taxRate;
//   String? instance;
//
//   CartItems(
//       {this.rowId,
//         this.id,
//         this.qty,
//         this.name,
//         this.price,
//         this.weight,
//         this.options,
//         this.taxRate,
//         this.instance});
//
//   CartItems.fromJson(Map<String, dynamic> json) {
//     rowId = json['rowId'];
//     id = json['id'];
//     qty = json['qty'];
//     name = json['name'];
//     price = json['price'];
//     weight = json['weight'];
//     options =
//     json['options'] != null ? new Options.fromJson(json['options']) : null;
//     taxRate = json['taxRate'];
//     instance = json['instance'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rowId'] = this.rowId;
//     data['id'] = this.id;
//     data['qty'] = this.qty;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['weight'] = this.weight;
//     if (this.options != null) {
//       data['options'] = this.options!.toJson();
//     }
//     data['taxRate'] = this.taxRate;
//     data['instance'] = this.instance;
//     return data;
//   }
// }
//
// class Options {
//   String? image;
//   String? size;
//   Null? saus;
//
//   Options({this.image, this.size, this.saus});
//
//   Options.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     size = json['size'];
//     saus = json['saus'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     data['size'] = this.size;
//     data['saus'] = this.saus;
//     return data;
//   }
// }

class Errors {

  String? errorMessage;

  Errors({ this.errorMessage});

  Errors.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}
