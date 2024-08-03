import '../../RestaurantScreen/model/RestaurantProductModel.dart';

class RestaurantTimingModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  RestaurantTimingModel({this.results, this.errors, this.status, this.msg});

  RestaurantTimingModel.fromJson(Map<String, dynamic> json) {
    results =
    json['results'] != null ? Results.fromJson(json['results']) : null;
    errors =
    json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    status = json['status'];
  }
}

class Results {
  String? timing1;
  String? timing2;
  String? timing3;
  String? timing4;
  String? day;
  List<String>? deliveryTimings;

  Results({this.timing1, this.timing2, this.timing3, this.timing4, this.day, this.deliveryTimings});

  Results.fromJson(Map<String, dynamic> json) {
    timing1 = json['openingClosingTiming']['timing1'];
    timing2 = json['openingClosingTiming']['timing2'];
    timing3 = json['openingClosingTiming']['timing3'];
    timing4 = json['openingClosingTiming']['timing4'];
    day = json['openingClosingTiming']['day'];
    deliveryTimings = json['deliveryTimings'].cast<String>();
  }

}
