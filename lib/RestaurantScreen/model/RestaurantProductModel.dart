class RestaurantProductModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  RestaurantProductModel({this.results, this.errors, this.status,this.msg});

  RestaurantProductModel.fromJson(Map<String, dynamic> json) {
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
  List<Category>? category;
  List<Restaurant>? restaurant;

  Results({this.category, this.restaurant});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['restaurant'] != null) {
      restaurant = <Restaurant>[];
      json['restaurant'].forEach((v) {
        restaurant!.add(new Restaurant.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? categoryName;
  List<Product>? product;

  Category({this.categoryName, this.product});

  Category.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
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
  dynamic? specialDeals;
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
        this.status,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subcategoryId = json['subcategory_id'];
    modelNr = json['model_nr'];
    productNameEn = json['product_name_en'];
    productNameNl = json['product_name_nl'];
    productCode = json['product_code'];
    ingredientSaus = json['ingredient_saus'];
    productSizeEn = json['product_size_en'];
    productSizeNl = json['product_size_nl'];
    sellingPrice = json['selling_price'];
    discountPrice = json['discount_price'].toString();
    productSlug = json['product_slug'];
    productTags = json['product_tags'];
    longDescpEn = json['long_descp_en'];
    longDescpNl = json['long_descp_nl'];
    productThambnail = json['product_thambnail'];
    hotDeals = json['hot_deals'];
    featured = json['featured'];
    specialOffer = json['special_offer'];
    specialDeals = json['special_deals'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['subcategory_id'] = this.subcategoryId;
    data['model_nr'] = this.modelNr;
    data['product_name_en'] = this.productNameEn;
    data['product_name_nl'] = this.productNameNl;
    data['product_code'] = this.productCode;
    data['ingredient_saus'] = this.ingredientSaus;
    data['product_size_en'] = this.productSizeEn;
    data['product_size_nl'] = this.productSizeNl;
    data['selling_price'] = this.sellingPrice;
    data['discount_price'] = this.discountPrice;
    data['product_slug'] = this.productSlug;
    data['product_tags'] = this.productTags;
    data['long_descp_en'] = this.longDescpEn;
    data['long_descp_nl'] = this.longDescpNl;
    data['product_thambnail'] = this.productThambnail;
    data['hot_deals'] = this.hotDeals;
    data['featured'] = this.featured;
    data['special_offer'] = this.specialOffer;
    data['special_deals'] = this.specialDeals;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Restaurant {
  num? id;
  num? sellerId;
  String? ownername;
  String? restaurantname;
  num? foodCategoryId;
  String? category;
  String? phone;
  String? website;
  String? email;
  String? btw;
  String? facebook;
  String? twitter;
  String? address;
  num? postcodeId;
  num? postcode;
  num? cityId;
  String? city;
  String? deliveryStartTime;
  num? deliveryGap;
  String? deliveryEndTime;
  String? preparationtime;
  String? deliverytime;
  String? minimumorder;
  String? deliverby;
  num? deliveryDistance;
  String? serves;
  num? ispopular;
  String? discount;
  num? status;
  String? resImage;
  String? resBannerimage;
  String? latitude;
  String? longitude;
  String? updatedAt;
  RestaurantRatings? restaurantRatings;
  List<Review>? review;

  Restaurant(
      {this.id,
        this.sellerId,
        this.ownername,
        this.restaurantname,
        this.foodCategoryId,
        this.category,
        this.phone,
        this.website,
        this.email,
        this.btw,
        this.facebook,
        this.twitter,
        this.address,
        this.postcodeId,
        this.postcode,
        this.cityId,
        this.city,
        this.deliveryStartTime,
        this.deliveryGap,
        this.deliveryEndTime,
        this.preparationtime,
        this.deliverytime,
        this.minimumorder,
        this.deliverby,
        this.deliveryDistance,
        this.serves,
        this.ispopular,
        this.discount,
        this.status,
        this.resImage,
        this.resBannerimage,
        this.latitude,
        this.longitude,

        this.updatedAt,
        this.restaurantRatings,
        this.review});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    ownername = json['ownername'];
    restaurantname = json['restaurantname'];
    foodCategoryId = json['food_category_id'];
    category = json['category'];
    phone = json['phone'];
    website = json['website'];
    email = json['email'];
    btw = json['btw'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    address = json['address'];
    postcodeId = json['postcode_id'];
    postcode = json['postcode'];
    cityId = json['city_id'];
    city = json['city'];
    deliveryStartTime = json['delivery_start_time'];
    deliveryGap = json['delivery_gap'];
    deliveryEndTime = json['delivery_end_time'];
    preparationtime = json['preparationtime'];
    deliverytime = json['deliverytime'];
    minimumorder = json['minimumorder'];
    deliverby = json['deliverby'];
    deliveryDistance = json['delivery_distance'];
    serves = json['serves'];
    ispopular = json['ispopular'];
    discount = json['discount'].toString();
    status = json['status'];
    resImage = json['res_image'];
    resBannerimage = json['res_bannerimage'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    updatedAt = json['updated_at'];
    restaurantRatings = json['restaurant_ratings'] != null
        ? new RestaurantRatings.fromJson(json['restaurant_ratings'])
        : null;
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['ownername'] = this.ownername;
    data['restaurantname'] = this.restaurantname;
    data['food_category_id'] = this.foodCategoryId;
    data['category'] = this.category;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['email'] = this.email;
    data['btw'] = this.btw;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['address'] = this.address;
    data['postcode_id'] = this.postcodeId;
    data['postcode'] = this.postcode;
    data['city_id'] = this.cityId;
    data['city'] = this.city;
    data['delivery_start_time'] = this.deliveryStartTime;
    data['delivery_gap'] = this.deliveryGap;
    data['delivery_end_time'] = this.deliveryEndTime;
    data['preparationtime'] = this.preparationtime;
    data['deliverytime'] = this.deliverytime;
    data['minimumorder'] = this.minimumorder;
    data['deliverby'] = this.deliverby;
    data['delivery_distance'] = this.deliveryDistance;
    data['serves'] = this.serves;
    data['ispopular'] = this.ispopular;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['res_image'] = this.resImage;
    data['res_bannerimage'] = this.resBannerimage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['updated_at'] = this.updatedAt;
    if (this.restaurantRatings != null) {
      data['restaurant_ratings'] = this.restaurantRatings!.toJson();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantRatings {
  int? totalReviews;
  String? averageRating;
  int? foodRatings;
  String? locationRatings;
  int? serviceRatings;
  String? priceRatings;

  RestaurantRatings(
      {this.totalReviews,
        this.averageRating,
        this.foodRatings,
        this.locationRatings,
        this.serviceRatings,
        this.priceRatings});

  RestaurantRatings.fromJson(Map<String, dynamic> json) {
    totalReviews = json['total_reviews'];
    averageRating = json['average_rating'].toString();
    foodRatings = json['food_ratings'];
    locationRatings = json['location_ratings'].toString();
    serviceRatings = json['service_ratings'];
    priceRatings = json['price_ratings'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_reviews'] = this.totalReviews;
    data['average_rating'] = this.averageRating;
    data['food_ratings'] = this.foodRatings;
    data['location_ratings'] = this.locationRatings;
    data['service_ratings'] = this.serviceRatings;
    data['price_ratings'] = this.priceRatings;
    return data;
  }
}

class Review {
  num? id;
  String? status;
  num? restaurantId;
  num? userId;
  String? title;
  String? review;
  num? foodRating;
  num? locationRating;
  num? serviceRating;
  num? priceRating;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  num? likeCount;
  num? dislikeCount;
  User? user;
  // List<Null>? reviewReply;

  Review(
      {this.id,
        this.status,
        this.restaurantId,
        this.userId,
        this.title,
        this.review,
        this.foodRating,
        this.locationRating,
        this.serviceRating,
        this.priceRating,
        this.averageRating,
        this.createdAt,
        this.updatedAt,
        this.likeCount,
        this.dislikeCount,
        this.user,
        // this.reviewReply
      });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    restaurantId = json['restaurant_id'];
    userId = json['user_id'];
    title = json['title'];
    review = json['review'];
    foodRating = json['food_rating'];
    locationRating = json['location_rating'];
    serviceRating = json['service_rating'];
    priceRating = json['price_rating'];
    averageRating = json['average_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likeCount = json['like_count'];
    dislikeCount = json['dislike_count'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    // if (json['review_reply'] != null) {
    //   reviewReply = <Null>[];
      // json['review_reply'].forEach((v) {
      //   reviewReply!.add(new Null.fromJson(v));
      // });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['restaurant_id'] = this.restaurantId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['review'] = this.review;
    data['food_rating'] = this.foodRating;
    data['location_rating'] = this.locationRating;
    data['service_rating'] = this.serviceRating;
    data['price_rating'] = this.priceRating;
    data['average_rating'] = this.averageRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['like_count'] = this.likeCount;
    data['dislike_count'] = this.dislikeCount;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    // if (this.reviewReply != null) {
    //   data['review_reply'] = this.reviewReply!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class User {
  num? id;
  String? name;
  String? phone;
  String? email;
  Null? emailVerifiedAt;
  num? status;
  Null? profilePhotoPath;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.emailVerifiedAt,
        this.status,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

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



/*
class Errors {
  List<Null>? validationMessage;
  String? errorMessage;

  Errors({this.validationMessage, this.errorMessage});

  Errors.fromJson(Map<String, dynamic> json) {
    if (json['validationMessage'] != null) {
      validationMessage = <Null>[];
      json['validationMessage'].forEach((v) {
        validationMessage!.add(new Null.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.validationMessage != null) {
      data['validationMessage'] =
          this.validationMessage!.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}
*/

