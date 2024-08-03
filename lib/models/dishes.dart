/// dish : [{"id":1,"foodcategory":"Japanese Sushi","fc_image":"https://www.restauranthub.be/upload/foodcategory/1724124702146430.jpg","fc_features":"1","fc_averageprice":"25","created_at":null,"updated_at":"2022-04-01T17:25:40.000000Z"},{"id":2,"foodcategory":"Indian & Nepali Food","fc_image":"https://www.restauranthub.be/upload/foodcategory/1724124813103027.jpg","fc_features":"1","fc_averageprice":"20","created_at":null,"updated_at":"2022-03-19T06:59:00.000000Z"},{"id":3,"foodcategory":"PIzza","fc_image":"https://www.restauranthub.be/upload/foodcategory/1724124832120737.JPG","fc_features":"1","fc_averageprice":"Pizza","created_at":null,"updated_at":null},{"id":4,"foodcategory":"Maxican Food","fc_image":"https://www.restauranthub.be/upload/foodcategory/1724124852056312.JPG","fc_features":"1","fc_averageprice":"10","created_at":null,"updated_at":null},{"id":5,"foodcategory":"Italian Pizza","fc_image":"https://www.restauranthub.be/upload/foodcategory/1724124876334739.jpg","fc_features":"1","fc_averageprice":"10","created_at":null,"updated_at":null},{"id":6,"foodcategory":"Belgische Food","fc_image":"https://www.restauranthub.be/upload/category/1760375177257309.png","fc_features":"1","fc_averageprice":"20","created_at":null,"updated_at":null},{"id":7,"foodcategory":"African Food","fc_image":"https://www.restauranthub.be/upload/category/1760376505845350.jpg","fc_features":"1","fc_averageprice":"10","created_at":null,"updated_at":null}]

class DishesList {
  DishesList({
      List<Dish>? dish,}){
    _dish = dish;
}

  DishesList.fromJson(dynamic json) {
    if (json['dish'] != null) {
      _dish = [];
      json['dish'].forEach((v) {
        _dish?.add(Dish.fromJson(v));
      });
    }
  }
  List<Dish>? _dish;
DishesList copyWith({  List<Dish>? dish,
}) => DishesList(  dish: dish ?? _dish,
);
  List<Dish>? get dish => _dish;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dish != null) {
      map['dish'] = _dish?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// foodcategory : "Japanese Sushi"
/// fc_image : "https://www.restauranthub.be/upload/foodcategory/1724124702146430.jpg"
/// fc_features : "1"
/// fc_averageprice : "25"
/// created_at : null
/// updated_at : "2022-04-01T17:25:40.000000Z"

class Dish {
  Dish({
      num? id, 
      String? foodcategory, 
      String? fcImage, 
      String? fcFeatures, 
      String? fcAverageprice, 
      dynamic createdAt, 
      String? updatedAt,}){
    _id = id;
    _foodcategory = foodcategory;
    _fcImage = fcImage;
    _fcFeatures = fcFeatures;
    _fcAverageprice = fcAverageprice;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Dish.fromJson(dynamic json) {
    _id = json['id'];
    _foodcategory = json['foodcategory'];
    _fcImage = json['fc_image'];
    _fcFeatures = json['fc_features'];
    _fcAverageprice = json['fc_averageprice'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _foodcategory;
  String? _fcImage;
  String? _fcFeatures;
  String? _fcAverageprice;
  dynamic _createdAt;
  String? _updatedAt;
Dish copyWith({  num? id,
  String? foodcategory,
  String? fcImage,
  String? fcFeatures,
  String? fcAverageprice,
  dynamic createdAt,
  String? updatedAt,
}) => Dish(  id: id ?? _id,
  foodcategory: foodcategory ?? _foodcategory,
  fcImage: fcImage ?? _fcImage,
  fcFeatures: fcFeatures ?? _fcFeatures,
  fcAverageprice: fcAverageprice ?? _fcAverageprice,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get foodcategory => _foodcategory;
  String? get fcImage => _fcImage;
  String? get fcFeatures => _fcFeatures;
  String? get fcAverageprice => _fcAverageprice;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['foodcategory'] = _foodcategory;
    map['fc_image'] = _fcImage;
    map['fc_features'] = _fcFeatures;
    map['fc_averageprice'] = _fcAverageprice;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}