/// success : true
/// restaurnt : [{"id":16,"seller_id":7,"ownername":"Rojina","restaurantname":"Sushi Sake","food_category_id":1,"category":"7","phone":"+48487821455","website":"http://localhost.com","email":"info@printhuis.be","btw":"6565656254","facebook":"restauranthub","twitter":"restaurant hub","address":"Windmolenstraat 67","postcode_id":2,"postcode":2140,"city_id":2,"city":"1","delivery_start_time":"16","delivery_gap":15,"delivery_end_time":"22","preparationtime":"30:00 min","deliverytime":"25:00 min","minimumorder":"20","deliverby":"Admin","delivery_distance":10,"serves":"Take Away","ispopular":1,"discount":15,"status":1,"res_image":"https://www.restauranthub.be/upload/restaurantimage/1724141277110265.jpg","res_bannerimage":"https://www.restauranthub.be/upload/restaurantbanner/1724141277192377.JPG","latitude":"51.2138078","longitude":"4.4439088","created_at":null,"updated_at":"2023-04-03T17:04:37.000000Z","restaurant_ratings":{"total_reviews":1,"average_rating":0,"food_ratings":0,"location_ratings":0,"service_ratings":0,"price_ratings":0}},{"id":17,"seller_id":12,"ownername":"Kishan Kc","restaurantname":"Sushi Kioku Duffel","food_category_id":1,"category":"7","phone":"0487821455","website":"sushikioku.be","email":"duffelsushi@yahoo.com","btw":"BE0754741954","facebook":"sushikioku.be","twitter":"kioku","address":"Kerkstraat 34","postcode_id":4,"postcode":2660,"city_id":4,"city":"Antwerpen","delivery_start_time":"15.30","delivery_gap":10,"delivery_end_time":"21.30","preparationtime":"15:00 min","deliverytime":"15:00 min","minimumorder":"10.00","deliverby":"Merchant","delivery_distance":18,"serves":"Restaurant, Take Away & Delivery","ispopular":1,"discount":0,"status":1,"res_image":"https://www.restauranthub.be/upload/restaurantimage/1760378074237122.jpg","res_bannerimage":"https://www.restauranthub.be/upload/restaurantbanner/1760378074249174.jpg","latitude":"51.1771171","longitude":"4.3532966","created_at":null,"updated_at":"2023-04-01T07:51:52.000000Z","restaurant_ratings":{"total_reviews":0,"average_rating":0,"food_ratings":0,"location_ratings":0,"service_ratings":0,"price_ratings":0}},{"id":18,"seller_id":7,"ownername":"Rojina","restaurantname":"Zeph Finch","food_category_id":3,"category":"7","phone":"+1 (372) 989-4327","website":"https://www.tiqykoz.mobi","email":"jalewyde@mailinator.com","btw":"Quia rem amet amet","facebook":"Rerum sed rerum obca","twitter":"Tempor natus et anim","address":"Placeat cillum comm","postcode_id":1,"postcode":1070,"city_id":6,"city":"1","delivery_start_time":"15:30","delivery_gap":20,"delivery_end_time":"23:30","preparationtime":"30:00 min","deliverytime":"60:00 min","minimumorder":"30","deliverby":"Merchant","delivery_distance":5,"serves":"Take Away & Delivery","ispopular":1,"discount":1,"status":1,"res_image":"https://www.restauranthub.be/upload/restaurantimage/1761959564970000.png","res_bannerimage":"https://www.restauranthub.be/upload/restaurantbanner/1761959565023005.jpg","latitude":"51.2269388","longitude":"4.4276298","created_at":null,"updated_at":"2023-04-03T17:07:44.000000Z","restaurant_ratings":{"total_reviews":0,"average_rating":0,"food_ratings":0,"location_ratings":0,"service_ratings":0,"price_ratings":0}}]

class RestaurantModel {
  RestaurantModel({
      bool? success, 
      List<Restaurnt>? restaurnt,}){
    _success = success;
    _restaurnt = restaurnt;
}

  RestaurantModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['restaurnt'] != null) {
      _restaurnt = [];
      json['restaurnt'].forEach((v) {
        _restaurnt?.add(Restaurnt.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Restaurnt>? _restaurnt;
RestaurantModel copyWith({  bool? success,
  List<Restaurnt>? restaurnt,
}) => RestaurantModel(  success: success ?? _success,
  restaurnt: restaurnt ?? _restaurnt,
);
  bool? get success => _success;
  List<Restaurnt>? get restaurnt => _restaurnt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_restaurnt != null) {
      map['restaurnt'] = _restaurnt?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 16
/// seller_id : 7
/// ownername : "Rojina"
/// restaurantname : "Sushi Sake"
/// food_category_id : 1
/// category : "7"
/// phone : "+48487821455"
/// website : "http://localhost.com"
/// email : "info@printhuis.be"
/// btw : "6565656254"
/// facebook : "restauranthub"
/// twitter : "restaurant hub"
/// address : "Windmolenstraat 67"
/// postcode_id : 2
/// postcode : 2140
/// city_id : 2
/// city : "1"
/// delivery_start_time : "16"
/// delivery_gap : 15
/// delivery_end_time : "22"
/// preparationtime : "30:00 min"
/// deliverytime : "25:00 min"
/// minimumorder : "20"
/// deliverby : "Admin"
/// delivery_distance : 10
/// serves : "Take Away"
/// ispopular : 1
/// discount : 15
/// status : 1
/// res_image : "https://www.restauranthub.be/upload/restaurantimage/1724141277110265.jpg"
/// res_bannerimage : "https://www.restauranthub.be/upload/restaurantbanner/1724141277192377.JPG"
/// latitude : "51.2138078"
/// longitude : "4.4439088"
/// created_at : null
/// updated_at : "2023-04-03T17:04:37.000000Z"
/// restaurant_ratings : {"total_reviews":1,"average_rating":0,"food_ratings":0,"location_ratings":0,"service_ratings":0,"price_ratings":0}

class Restaurnt {
  Restaurnt({
      num? id, 
      num? sellerId, 
      String? ownername, 
      String? restaurantname, 
      num? foodCategoryId, 
      String? category, 
      String? phone, 
      String? website, 
      String? email, 
      String? btw, 
      String? facebook, 
      String? twitter, 
      String? address, 
      num? postcodeId, 
      num? postcode, 
      num? cityId, 
      String? city, 
      String? deliveryStartTime, 
      num? deliveryGap, 
      String? deliveryEndTime, 
      String? preparationtime, 
      String? deliverytime, 
      String? minimumorder, 
      String? deliverby, 
      num? deliveryDistance, 
      String? serves, 
      num? ispopular, 
      num? discount, 
      num? status, 
      String? resImage, 
      String? resBannerimage, 
      String? latitude, 
      String? longitude, 
      dynamic createdAt, 
      String? updatedAt, 
      RestaurantRatings? restaurantRatings,}){
    _id = id;
    _sellerId = sellerId;
    _ownername = ownername;
    _restaurantname = restaurantname;
    _foodCategoryId = foodCategoryId;
    _category = category;
    _phone = phone;
    _website = website;
    _email = email;
    _btw = btw;
    _facebook = facebook;
    _twitter = twitter;
    _address = address;
    _postcodeId = postcodeId;
    _postcode = postcode;
    _cityId = cityId;
    _city = city;
    _deliveryStartTime = deliveryStartTime;
    _deliveryGap = deliveryGap;
    _deliveryEndTime = deliveryEndTime;
    _preparationtime = preparationtime;
    _deliverytime = deliverytime;
    _minimumorder = minimumorder;
    _deliverby = deliverby;
    _deliveryDistance = deliveryDistance;
    _serves = serves;
    _ispopular = ispopular;
    _discount = discount;
    _status = status;
    _resImage = resImage;
    _resBannerimage = resBannerimage;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _restaurantRatings = restaurantRatings;
}

  Restaurnt.fromJson(dynamic json) {
    _id = json['id'];
    _sellerId = json['seller_id'];
    _ownername = json['ownername'];
    _restaurantname = json['restaurantname'];
    _foodCategoryId = json['food_category_id'];
    _category = json['category'];
    _phone = json['phone'];
    _website = json['website'];
    _email = json['email'];
    _btw = json['btw'];
    _facebook = json['facebook'];
    _twitter = json['twitter'];
    _address = json['address'];
    _postcodeId = json['postcode_id'];
    _postcode = json['postcode'];
    _cityId = json['city_id'];
    _city = json['city'];
    _deliveryStartTime = json['delivery_start_time'];
    _deliveryGap = json['delivery_gap'];
    _deliveryEndTime = json['delivery_end_time'];
    _preparationtime = json['preparationtime'];
    _deliverytime = json['deliverytime'];
    _minimumorder = json['minimumorder'];
    _deliverby = json['deliverby'];
    _deliveryDistance = json['delivery_distance'];
    _serves = json['serves'];
    _ispopular = json['ispopular'];
    _discount = json['discount'];
    _status = json['status'];
    _resImage = json['res_image'];
    _resBannerimage = json['res_bannerimage'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _restaurantRatings = json['restaurant_ratings'] != null ? RestaurantRatings.fromJson(json['restaurant_ratings']) : null;
  }
  num? _id;
  num? _sellerId;
  String? _ownername;
  String? _restaurantname;
  num? _foodCategoryId;
  String? _category;
  String? _phone;
  String? _website;
  String? _email;
  String? _btw;
  String? _facebook;
  String? _twitter;
  String? _address;
  num? _postcodeId;
  num? _postcode;
  num? _cityId;
  String? _city;
  String? _deliveryStartTime;
  num? _deliveryGap;
  String? _deliveryEndTime;
  String? _preparationtime;
  String? _deliverytime;
  String? _minimumorder;
  String? _deliverby;
  num? _deliveryDistance;
  String? _serves;
  num? _ispopular;
  num? _discount;
  num? _status;
  String? _resImage;
  String? _resBannerimage;
  String? _latitude;
  String? _longitude;
  dynamic _createdAt;
  String? _updatedAt;
  RestaurantRatings? _restaurantRatings;
Restaurnt copyWith({  num? id,
  num? sellerId,
  String? ownername,
  String? restaurantname,
  num? foodCategoryId,
  String? category,
  String? phone,
  String? website,
  String? email,
  String? btw,
  String? facebook,
  String? twitter,
  String? address,
  num? postcodeId,
  num? postcode,
  num? cityId,
  String? city,
  String? deliveryStartTime,
  num? deliveryGap,
  String? deliveryEndTime,
  String? preparationtime,
  String? deliverytime,
  String? minimumorder,
  String? deliverby,
  num? deliveryDistance,
  String? serves,
  num? ispopular,
  num? discount,
  num? status,
  String? resImage,
  String? resBannerimage,
  String? latitude,
  String? longitude,
  dynamic createdAt,
  String? updatedAt,
  RestaurantRatings? restaurantRatings,
}) => Restaurnt(  id: id ?? _id,
  sellerId: sellerId ?? _sellerId,
  ownername: ownername ?? _ownername,
  restaurantname: restaurantname ?? _restaurantname,
  foodCategoryId: foodCategoryId ?? _foodCategoryId,
  category: category ?? _category,
  phone: phone ?? _phone,
  website: website ?? _website,
  email: email ?? _email,
  btw: btw ?? _btw,
  facebook: facebook ?? _facebook,
  twitter: twitter ?? _twitter,
  address: address ?? _address,
  postcodeId: postcodeId ?? _postcodeId,
  postcode: postcode ?? _postcode,
  cityId: cityId ?? _cityId,
  city: city ?? _city,
  deliveryStartTime: deliveryStartTime ?? _deliveryStartTime,
  deliveryGap: deliveryGap ?? _deliveryGap,
  deliveryEndTime: deliveryEndTime ?? _deliveryEndTime,
  preparationtime: preparationtime ?? _preparationtime,
  deliverytime: deliverytime ?? _deliverytime,
  minimumorder: minimumorder ?? _minimumorder,
  deliverby: deliverby ?? _deliverby,
  deliveryDistance: deliveryDistance ?? _deliveryDistance,
  serves: serves ?? _serves,
  ispopular: ispopular ?? _ispopular,
  discount: discount ?? _discount,
  status: status ?? _status,
  resImage: resImage ?? _resImage,
  resBannerimage: resBannerimage ?? _resBannerimage,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  restaurantRatings: restaurantRatings ?? _restaurantRatings,
);
  num? get id => _id;
  num? get sellerId => _sellerId;
  String? get ownername => _ownername;
  String? get restaurantname => _restaurantname;
  num? get foodCategoryId => _foodCategoryId;
  String? get category => _category;
  String? get phone => _phone;
  String? get website => _website;
  String? get email => _email;
  String? get btw => _btw;
  String? get facebook => _facebook;
  String? get twitter => _twitter;
  String? get address => _address;
  num? get postcodeId => _postcodeId;
  num? get postcode => _postcode;
  num? get cityId => _cityId;
  String? get city => _city;
  String? get deliveryStartTime => _deliveryStartTime;
  num? get deliveryGap => _deliveryGap;
  String? get deliveryEndTime => _deliveryEndTime;
  String? get preparationtime => _preparationtime;
  String? get deliverytime => _deliverytime;
  String? get minimumorder => _minimumorder;
  String? get deliverby => _deliverby;
  num? get deliveryDistance => _deliveryDistance;
  String? get serves => _serves;
  num? get ispopular => _ispopular;
  num? get discount => _discount;
  num? get status => _status;
  String? get resImage => _resImage;
  String? get resBannerimage => _resBannerimage;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  RestaurantRatings? get restaurantRatings => _restaurantRatings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['seller_id'] = _sellerId;
    map['ownername'] = _ownername;
    map['restaurantname'] = _restaurantname;
    map['food_category_id'] = _foodCategoryId;
    map['category'] = _category;
    map['phone'] = _phone;
    map['website'] = _website;
    map['email'] = _email;
    map['btw'] = _btw;
    map['facebook'] = _facebook;
    map['twitter'] = _twitter;
    map['address'] = _address;
    map['postcode_id'] = _postcodeId;
    map['postcode'] = _postcode;
    map['city_id'] = _cityId;
    map['city'] = _city;
    map['delivery_start_time'] = _deliveryStartTime;
    map['delivery_gap'] = _deliveryGap;
    map['delivery_end_time'] = _deliveryEndTime;
    map['preparationtime'] = _preparationtime;
    map['deliverytime'] = _deliverytime;
    map['minimumorder'] = _minimumorder;
    map['deliverby'] = _deliverby;
    map['delivery_distance'] = _deliveryDistance;
    map['serves'] = _serves;
    map['ispopular'] = _ispopular;
    map['discount'] = _discount;
    map['status'] = _status;
    map['res_image'] = _resImage;
    map['res_bannerimage'] = _resBannerimage;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_restaurantRatings != null) {
      map['restaurant_ratings'] = _restaurantRatings?.toJson();
    }
    return map;
  }

}

/// total_reviews : 1
/// average_rating : 0
/// food_ratings : 0
/// location_ratings : 0
/// service_ratings : 0
/// price_ratings : 0

class RestaurantRatings {
  RestaurantRatings({
      num? totalReviews, 
      num? averageRating, 
      num? foodRatings, 
      num? locationRatings, 
      num? serviceRatings, 
      num? priceRatings,}){
    _totalReviews = totalReviews;
    _averageRating = averageRating;
    _foodRatings = foodRatings;
    _locationRatings = locationRatings;
    _serviceRatings = serviceRatings;
    _priceRatings = priceRatings;
}

  RestaurantRatings.fromJson(dynamic json) {
    _totalReviews = json['total_reviews'];
    _averageRating = json['average_rating'];
    _foodRatings = json['food_ratings'];
    _locationRatings = json['location_ratings'];
    _serviceRatings = json['service_ratings'];
    _priceRatings = json['price_ratings'];
  }
  num? _totalReviews;
  num? _averageRating;
  num? _foodRatings;
  num? _locationRatings;
  num? _serviceRatings;
  num? _priceRatings;
RestaurantRatings copyWith({  num? totalReviews,
  num? averageRating,
  num? foodRatings,
  num? locationRatings,
  num? serviceRatings,
  num? priceRatings,
}) => RestaurantRatings(  totalReviews: totalReviews ?? _totalReviews,
  averageRating: averageRating ?? _averageRating,
  foodRatings: foodRatings ?? _foodRatings,
  locationRatings: locationRatings ?? _locationRatings,
  serviceRatings: serviceRatings ?? _serviceRatings,
  priceRatings: priceRatings ?? _priceRatings,
);
  num? get totalReviews => _totalReviews;
  num? get averageRating => _averageRating;
  num? get foodRatings => _foodRatings;
  num? get locationRatings => _locationRatings;
  num? get serviceRatings => _serviceRatings;
  num? get priceRatings => _priceRatings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_reviews'] = _totalReviews;
    map['average_rating'] = _averageRating;
    map['food_ratings'] = _foodRatings;
    map['location_ratings'] = _locationRatings;
    map['service_ratings'] = _serviceRatings;
    map['price_ratings'] = _priceRatings;
    return map;
  }

}