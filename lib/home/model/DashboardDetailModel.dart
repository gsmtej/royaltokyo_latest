import 'hot_deals_model.dart';

class DashboadrdDetailsModel {
  Data? data;
  Errors? errors;
  bool? status;
  String? msg;

  DashboadrdDetailsModel({this.data, this.errors, this.status,this.msg});

  DashboadrdDetailsModel.fromJson(Map<String, dynamic> json) {
    data =
    json['results'] != null ? Data.fromJson(json['results']) : null;
    errors =
    json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    status = json['status'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['results'] = this.data!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  List<Restaurants>? restaurants;
  List<NearbyRestaurants>? nearbyRestaurants;
  List<Dishes>? dishes;
  List<Category>? category;
  List<HotDealsModel>? hotDeals;

  Data({this.restaurants,
    this.nearbyRestaurants,
    this.dishes, this.category, this.hotDeals});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(Restaurants.fromJson(v));
      });
    }
    if (json['nearbyRestaurants'] != null) {
      nearbyRestaurants = <NearbyRestaurants>[];
      json['nearbyRestaurants'].forEach((v) {
        nearbyRestaurants!.add(NearbyRestaurants.fromJson(v));
      });
    }
    if (json['dishes'] != null) {
      dishes = <Dishes>[];
      print("dishes==>${json['dishes']}");
      json['dishes'].forEach((v) {
        dishes!.add(Dishes.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    if (json['hot_deals'] != null) {
      hotDeals = <HotDealsModel>[];
      json['hot_deals'].forEach((v) {
        hotDeals!.add(HotDealsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    if (this.nearbyRestaurants != null) {
      data['nearbyRestaurants'] =
          this.nearbyRestaurants!.map((v) => v.toJson()).toList();
    }
    if (this.dishes != null) {
      data['dishes'] = this.dishes!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.hotDeals != null) {
      data['hot_deals'] = this.hotDeals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
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
  Null? createdAt;
  String? updatedAt;
  RestaurantRatings? restaurantRatings;

  Restaurants(
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
        this.createdAt,
        this.updatedAt,
        this.restaurantRatings});

  Restaurants.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantRatings = json['restaurant_ratings'] != null
        ? RestaurantRatings.fromJson(json['restaurant_ratings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.restaurantRatings != null) {
      data['restaurant_ratings'] = this.restaurantRatings!.toJson();
    }
    return data;
  }
}

class NearbyRestaurants {
  int? id;
  int? sellerId;
  String? ownername;
  String? restaurantname;
  int? foodCategoryId;
  String? category;
  String? phone;
  String? website;
  String? email;
  String? btw;
  String? facebook;
  String? twitter;
  String? address;
  int? postcodeId;
  int? postcode;
  int? cityId;
  String? city;
  String? deliveryStartTime;
  int? deliveryGap;
  String? deliveryEndTime;
  String? preparationtime;
  String? deliverytime;
  String? minimumorder;
  String? deliverby;
  int? deliveryDistance;
  String? serves;
  int? ispopular;
  int? discount;
  int? status;
  String? resImage;
  String? resBannerimage;
  String? latitude;
  String? longitude;
  Null? createdAt;
  String? updatedAt;
  RestaurantRatings? restaurantRatings;

  NearbyRestaurants(
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
        this.createdAt,
        this.updatedAt,
        this.restaurantRatings});

  NearbyRestaurants.fromJson(Map<String, dynamic> json) {
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
    discount = json['discount'];
    status = json['status'];
    resImage = json['res_image'];
    resBannerimage = json['res_bannerimage'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantRatings = json['restaurant_ratings'] != null
        ? RestaurantRatings.fromJson(json['restaurant_ratings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.restaurantRatings != null) {
      data['restaurant_ratings'] = this.restaurantRatings!.toJson();
    }
    return data;
  }
}

class RestaurantRatings {
  num? totalReviews;
  num? averageRating;
  num? foodRatings;
  num? locationRatings;
  num? serviceRatings;
  num? priceRatings;

  RestaurantRatings(
      {this.totalReviews,
        this.averageRating,
        this.foodRatings,
        this.locationRatings,
        this.serviceRatings,
        this.priceRatings});

  RestaurantRatings.fromJson(Map<String, dynamic> json) {
    totalReviews = json['total_reviews'];
    averageRating = json['average_rating'];
    foodRatings = json['food_ratings'];
    locationRatings = json['location_ratings'];
    serviceRatings = json['service_ratings'];
    priceRatings = json['price_ratings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_reviews'] = this.totalReviews;
    data['average_rating'] = this.averageRating;
    data['food_ratings'] = this.foodRatings;
    data['location_ratings'] = this.locationRatings;
    data['service_ratings'] = this.serviceRatings;
    data['price_ratings'] = this.priceRatings;
    return data;
  }
}

class Dishes {
  int? id;
  String? foodcategory;
  String? fcImage;
  String? fcFeatures;
  String? fcAverageprice;
  Null? createdAt;
  String? updatedAt;
  String? count;

  Dishes(
      {this.id,
        this.foodcategory,
        this.fcImage,
        this.fcFeatures,
        this.fcAverageprice,
        this.createdAt,
        this.count,
        this.updatedAt});

  Dishes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodcategory = json['foodcategory'];
    fcImage = json['fc_image'];
    fcFeatures = json['fc_features'];
    fcAverageprice = json['fc_averageprice'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    count = json['count'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['foodcategory'] = this.foodcategory;
    data['fc_image'] = this.fcImage;
    data['fc_features'] = this.fcFeatures;
    data['fc_averageprice'] = this.fcAverageprice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['count'] = this.count;
    return data;
  }
}

class Category {
  num? id;
  num? restaurantId;
  String? restaurantName;
  String? categoryNameEn;
  String? categoryNameNl;
  String? categoryIcon;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.restaurantId,
        this.restaurantName,
        this.categoryNameEn,
        this.categoryNameNl,
        this.categoryIcon,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    categoryNameEn = json['category_name_en'];
    categoryNameNl = json['category_name_nl'];
    categoryIcon = json['category_icon'];
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['category_name_en'] = this.categoryNameEn;
    data['category_name_nl'] = this.categoryNameNl;
    data['category_icon'] = this.categoryIcon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Errors {
  List<dynamic>? validationMessage;
  String? errorMessage;

  Errors({this.validationMessage, this.errorMessage});

  Errors.fromJson(Map<String, dynamic> json) {
    if (json['validationMessage'] != dynamic) {
      validationMessage = <dynamic>[];
      // json['validationMessage'].forEach((v) {
      //   validationMessage!.add(dynamic.fromJson(v));
      // });
    }
    errorMessage = json['errorMessage'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.validationMessage != dynamic) {
      data['validationMessage'] =
          this.validationMessage!.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}















/*


class DashboadrdDetailsModel {
  bool? success;
  Data? data;

  DashboadrdDetailsModel({this.success, this.data});

  DashboadrdDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Restaurants>? restaurants;
  List<NearbyRestaurants>? nearbyRestaurants;
  List<Dishes>? dishes;
  List<Category>? category;

  Data({this.restaurants,
    this.nearbyRestaurants,
    this.dishes, this.category});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
    if (json['nearbyRestaurants'] != null) {
      nearbyRestaurants = <NearbyRestaurants>[];
      json['nearbyRestaurants'].forEach((v) {
        nearbyRestaurants!.add(new NearbyRestaurants.fromJson(v));
      });
    }
    if (json['dishes'] != null) {
      dishes = <Dishes>[];
      json['dishes'].forEach((v) {
        dishes!.add(new Dishes.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    if (this.nearbyRestaurants != null) {
      data['nearbyRestaurants'] =
          this.nearbyRestaurants!.map((v) => v.toJson()).toList();
    }
    if (this.dishes != null) {
      data['dishes'] = this.dishes!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
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
  num? discount;
  num? status;
  String? resImage;
  String? resBannerimage;
  String? latitude;
  String? longitude;
  Null? createdAt;
  String? updatedAt;
  RestaurantRatings? restaurantRatings;

  Restaurants(
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
        this.createdAt,
        this.updatedAt,
        this.restaurantRatings});

  Restaurants.fromJson(Map<String, dynamic> json) {
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
    discount = json['discount'];
    status = json['status'];
    resImage = json['res_image'];
    resBannerimage = json['res_bannerimage'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantRatings = json['restaurant_ratings'] != null
        ? new RestaurantRatings.fromJson(json['restaurant_ratings'])
        : null;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.restaurantRatings != null) {
      data['restaurant_ratings'] = this.restaurantRatings!.toJson();
    }
    return data;
  }
}

class NearbyRestaurants {
  int? id;
  int? sellerId;
  String? ownername;
  String? restaurantname;
  int? foodCategoryId;
  String? category;
  String? phone;
  String? website;
  String? email;
  String? btw;
  String? facebook;
  String? twitter;
  String? address;
  int? postcodeId;
  int? postcode;
  int? cityId;
  String? city;
  String? deliveryStartTime;
  int? deliveryGap;
  String? deliveryEndTime;
  String? preparationtime;
  String? deliverytime;
  String? minimumorder;
  String? deliverby;
  int? deliveryDistance;
  String? serves;
  int? ispopular;
  int? discount;
  int? status;
  String? resImage;
  String? resBannerimage;
  String? latitude;
  String? longitude;
  Null? createdAt;
  String? updatedAt;
  RestaurantRatings? restaurantRatings;

  NearbyRestaurants(
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
        this.createdAt,
        this.updatedAt,
        this.restaurantRatings});

  NearbyRestaurants.fromJson(Map<String, dynamic> json) {
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
    discount = json['discount'];
    status = json['status'];
    resImage = json['res_image'];
    resBannerimage = json['res_bannerimage'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantRatings = json['restaurant_ratings'] != null
        ? new RestaurantRatings.fromJson(json['restaurant_ratings'])
        : null;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.restaurantRatings != null) {
      data['restaurant_ratings'] = this.restaurantRatings!.toJson();
    }
    return data;
  }
}

class RestaurantRatings {
  num? totalReviews;
  num? averageRating;
  num? foodRatings;
  num? locationRatings;
  num? serviceRatings;
  num? priceRatings;

  RestaurantRatings(
      {this.totalReviews,
        this.averageRating,
        this.foodRatings,
        this.locationRatings,
        this.serviceRatings,
        this.priceRatings});

  RestaurantRatings.fromJson(Map<String, dynamic> json) {
    totalReviews = json['total_reviews'];
    averageRating = json['average_rating'];
    foodRatings = json['food_ratings'];
    locationRatings = json['location_ratings'];
    serviceRatings = json['service_ratings'];
    priceRatings = json['price_ratings'];
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

class Dishes {
  num? id;
  String? foodcategory;
  String? fcImage;
  String? fcFeatures;
  String? fcAverageprice;
  Null? createdAt;
  String? updatedAt;

  Dishes(
      {this.id,
        this.foodcategory,
        this.fcImage,
        this.fcFeatures,
        this.fcAverageprice,
        this.createdAt,
        this.updatedAt});

  Dishes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodcategory = json['foodcategory'];
    fcImage = json['fc_image'];
    fcFeatures = json['fc_features'];
    fcAverageprice = json['fc_averageprice'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['foodcategory'] = this.foodcategory;
    data['fc_image'] = this.fcImage;
    data['fc_features'] = this.fcFeatures;
    data['fc_averageprice'] = this.fcAverageprice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Category {
  num? id;
  num? restaurantId;
  String? restaurantName;
  String? categoryNameEn;
  String? categoryNameNl;
  String? categoryIcon;
  Null? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.restaurantId,
        this.restaurantName,
        this.categoryNameEn,
        this.categoryNameNl,
        this.categoryIcon,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    categoryNameEn = json['category_name_en'];
    categoryNameNl = json['category_name_nl'];
    categoryIcon = json['category_icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['category_name_en'] = this.categoryNameEn;
    data['category_name_nl'] = this.categoryNameNl;
    data['category_icon'] = this.categoryIcon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
*/

