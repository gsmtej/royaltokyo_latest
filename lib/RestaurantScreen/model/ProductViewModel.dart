import '../../cart/model/CartModel.dart';

class ProductViewModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  ProductViewModel({this.results,  this.errors, this.status,this.msg});

  ProductViewModel.fromJson(Map<String, dynamic> json) {
    results =
    json['results'] != null ? Results.fromJson(json['results']) : null;
  }
}

class Results {
  Product? product;
  List<String>? size;
  List<String>? saus;

  Results({this.product, this.size, this.saus});

  Results.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    size = json['size'].cast<String>();
    saus = json['saus'].cast<String>();
  }
}

class Product {
  String? id;
  String? restaurantId;
  String? restaurantName;
  String? categoryId;
  String? categoryName;
  String? subcategoryId;
  String? modelNr;
  String? productNameEn;
  String? productNameNl;
  String? productCode;
  String? ingredientSaus;
  String? productSizeEn;
  String? productSizeNl;
  String? sellingPrice;
  String? discountPrice;
  String? productSlug;
  String? productTags;
  String? longDescpEn;
  String? longDescpNl;
  String? productThambnail;
  String? hotDeals;
  String? featured;
  String? specialOffer;
  String? specialDeals;
  String? tax;
  int? status;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
        this.restaurantId,
        this.restaurantName,
        this.categoryId,
        this.categoryName,
        this.subcategoryId,
        this.modelNr,
        this.productNameEn,
        this.productNameNl,
        this.productCode,
        this.ingredientSaus,
        this.productSizeEn,
        this.productSizeNl,
        this.sellingPrice,
        this.discountPrice,
        this.productSlug,
        this.productTags,
        this.longDescpEn,
        this.longDescpNl,
        this.productThambnail,
        this.hotDeals,
        this.featured,
        this.specialOffer,
        this.specialDeals,
        this.tax,
        this.status,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    restaurantId = json['restaurant_id'].toString();
    restaurantName = json['restaurant_name'].toString();
    categoryId = json['category_id'].toString();
    categoryName = json['category_name'].toString();
    subcategoryId = json['subcategory_id'].toString();
    modelNr = json['model_nr'].toString();
    productNameEn = json['product_name_en'].toString();
    productNameNl = json['product_name_nl'].toString();
    productCode = json['product_code'].toString();
    ingredientSaus = json['ingredient_saus'].toString();
    productSizeEn = json['product_size_en'].toString();
    productSizeNl = json['product_size_nl'].toString();
    sellingPrice = json['selling_price'].toString();
    discountPrice = json['discount_price'].toString();
    productSlug = json['product_slug'].toString();
    productTags = json['product_tags'].toString();
    longDescpEn = json['long_descp_en'].toString();
    longDescpNl = json['long_descp_nl'].toString();
    productThambnail = json['product_thambnail'].toString();
    hotDeals = json['hot_deals'].toString();
    featured = json['featured'].toString();
    specialOffer = json['special_offer'].toString();
    specialDeals = json['special_deals'].toString();
    tax = json['tax'].toString();
    status = json['status'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }
}
