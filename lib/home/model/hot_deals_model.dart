import '../../DishesScreen/model/DishesRestaurantModel.dart';

class HotDealsModel {
  int? id;
  int? restaurantId;
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
  int? hotDeals;
  int? featured;
  int? specialOffer;
  String? specialDeals;
  String? tax;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? resImage;
  String? preparationtime;
  String? deliverytime;
  String? minimumorder;
  RestaurantRatings? restaurantRatings;

  HotDealsModel(
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
        this.updatedAt,
        this.address,
        this.resImage,
        this.preparationtime,
        this.deliverytime,
        this.minimumorder,
        this.restaurantRatings,
      });

  HotDealsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subcategoryId = json['subcategory_id'].toString();
    modelNr = json['model_nr'];
    productNameEn = json['product_name_en'];
    productNameNl = json['product_name_nl'];
    productCode = json['product_code'];
    ingredientSaus = json['ingredient_saus'];
    productSizeEn = json['product_size_en'];
    productSizeNl = json['product_size_nl'];
    sellingPrice = json['selling_price'];
    discountPrice = json['discount_price'];
    productSlug = json['product_slug'];
    productTags = json['product_tags'].toString();
    longDescpEn = json['long_descp_en'];
    longDescpNl = json['long_descp_nl'];
    productThambnail = json['product_thambnail'];
    hotDeals = json['hot_deals'];
    featured = json['featured'];
    specialOffer = json['special_offer'];
    specialDeals = json['special_deals'].toString();
    tax = json['tax'];
    status = json['status'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'];
    address = json['address'];
    resImage = json['res_image'];
    preparationtime = json['preparationtime'];
    deliverytime = json['deliverytime'];
    minimumorder = json['minimumorder'];
    restaurantRatings = json['restaurant_ratings'] != null
        ? RestaurantRatings.fromJson(json['restaurant_ratings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['restaurant_id'] = restaurantId;
    data['restaurant_name'] = restaurantName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['subcategory_id'] = subcategoryId;
    data['model_nr'] = modelNr;
    data['product_name_en'] = productNameEn;
    data['product_name_nl'] = productNameNl;
    data['product_code'] = productCode;
    data['ingredient_saus'] = ingredientSaus;
    data['product_size_en'] = productSizeEn;
    data['product_size_nl'] = productSizeNl;
    data['selling_price'] = sellingPrice;
    data['discount_price'] = discountPrice;
    data['product_slug'] = productSlug;
    data['product_tags'] = productTags;
    data['long_descp_en'] = longDescpEn;
    data['long_descp_nl'] = longDescpNl;
    data['product_thambnail'] = productThambnail;
    data['hot_deals'] = hotDeals;
    data['featured'] = featured;
    data['special_offer'] = specialOffer;
    data['special_deals'] = specialDeals;
    data['tax'] = tax;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['address'] = address;
    data['res_image'] = resImage;
    data['preparationtime'] = preparationtime;
    data['deliverytime'] = deliverytime;
    data['minimumorder'] = minimumorder;
    if (this.restaurantRatings != null) {
      data['restaurant_ratings'] = this.restaurantRatings!.toJson();
    }
    return data;
  }
}
