import '../RestaurantScreen/model/RestaurantProductModel.dart';

class MyOrdersModel {
  List<Results>? results;
  Errors? errors;
  bool? status;
  String? msg;

  MyOrdersModel({this.results, this.errors, this.status, this.msg});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
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
}

class Results {
  String? id;
  String? restaurantId;
  String? userableId;
  String? userableType;
  String? customerAddressId;
  String? orderStatus;
  String? orderType;
  String? notes;
  String? paymentMethod;
  String? paymentType;
  String? transactionId;
  String? currency;
  String? amount;
  String? originalAmount;
  String? tax;
  String? couponDiscountAmount;
  String? orderTypeDiscountAmount;
  String? giftCardAmount;
  String? orderNumber;
  String? invoiceNo;
  String? orderDate;
  String? pickupDate;
  String? deliveryDate;
  String? orderTime;
  String? deliveredDate;
  String? cancelledDate;
  String? cancelledReason;
  String? cancelledBy;
  String? returnReason;
  String? returnDate;
  String? createdAt;
  String? updatedAt;
  CustomerAddress? customerAddress;
  List<OrderItems>? orderItems;

  Results(
      {this.id,
        this.restaurantId,
        this.userableId,
        this.userableType,
        this.customerAddressId,
        this.orderStatus,
        this.orderType,
        this.notes,
        this.paymentMethod,
        this.paymentType,
        this.transactionId,
        this.currency,
        this.amount,
        this.originalAmount,
        this.tax,
        this.couponDiscountAmount,
        this.orderTypeDiscountAmount,
        this.giftCardAmount,
        this.orderNumber,
        this.invoiceNo,
        this.orderDate,
        this.pickupDate,
        this.deliveryDate,
        this.orderTime,
        this.deliveredDate,
        this.cancelledDate,
        this.cancelledReason,
        this.cancelledBy,
        this.returnReason,
        this.returnDate,
        this.createdAt,
        this.updatedAt,
        this.customerAddress,
        this.orderItems});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    restaurantId = json['restaurant_id'].toString();
    userableId = json['userable_id'].toString();
    userableType = json['userable_type'];
    customerAddressId = json['customer_address_id'].toString();
    orderStatus = json['order_status'];
    orderType = json['order_type'];
    notes = json['notes'];
    paymentMethod = json['payment_method'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'].toString();
    currency = json['currency'];
    amount = json['amount'];
    originalAmount = json['original_amount'];
    tax = json['tax'];
    couponDiscountAmount = json['coupon_discount_amount'];
    orderTypeDiscountAmount = json['order_type_discount_amount'];
    giftCardAmount = json['gift_card_amount'] ?? "0.0";
    orderNumber = json['order_number'];
    invoiceNo = json['invoice_no'].toString();
    orderDate = json['order_date'];
    pickupDate = json['pickup_date'];
    deliveryDate = json['delivery_date'];
    orderTime = json['order_time'];
    deliveredDate = json['delivered_date'];
    cancelledDate = json['cancelled_date'];
    cancelledReason = json['cancelled_reason'];
    cancelledBy = json['cancelled_by'];
    returnReason = json['return_reason'];
    returnDate = json['return_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerAddress = json['customer_address'] != null
        ? CustomerAddress.fromJson(json['customer_address'])
        : null;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
  }
}

class CustomerAddress {
  String? name;
  String? phoneNumber;
  String? addressRegister;
  String? cityRegister;
  String? postcodeRegister;

  CustomerAddress(
      {this.name,
        this.phoneNumber,
        this.addressRegister,
        this.cityRegister,
        this.postcodeRegister});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    addressRegister = json['address_register'];
    cityRegister = json['city_register'];
    postcodeRegister = json['postcode_register'];
  }
}

class OrderItems {
  String? id;
  String? orderId;
  String? productId;
  String? productname;
  String? productcode;
  String? productsaus;
  String? productsize;
  String? qty;
  String? price;
  String? createdAt;
  String? updatedAt;

  OrderItems(
      {this.id,
        this.orderId,
        this.productId,
        this.productname,
        this.productcode,
        this.productsaus,
        this.productsize,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    orderId = json['order_id'].toString();
    productId = json['product_id'].toString();
    productname = json['productname'];
    productcode = json['productcode'];
    productsaus = json['productsaus'];
    productsize = json['productsize'];
    qty = json['qty'];
    price = json['price'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}


