class DishesRestaurantModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  DishesRestaurantModel({this.results, this.errors, this.status,this.msg});

  DishesRestaurantModel.fromJson(Map<String, dynamic> json) {
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
  List<Restaurants>? restaurants;
  Dishes? dishes;

  Results({this.restaurants, this.dishes});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
    dishes =
    json['dishes'] != null ? new Dishes.fromJson(json['dishes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    if (this.dishes != null) {
      data['dishes'] = this.dishes!.toJson();
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
  String? deliveryDiscountPercentage;
  String? takeawayDiscountPercentage;
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
        this.deliveryDiscountPercentage,
        this.takeawayDiscountPercentage,
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
    deliveryDiscountPercentage = json['delivery_discount_percentage'];
    takeawayDiscountPercentage = json['takeaway_discount_percentage'];
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
    data['delivery_discount_percentage'] = this.deliveryDiscountPercentage;
    data['takeaway_discount_percentage'] = this.takeawayDiscountPercentage;
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
