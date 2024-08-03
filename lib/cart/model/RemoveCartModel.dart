class RemoveCartModel {
  String? results;
  Errors? errors;
  bool? status;

  RemoveCartModel({this.results, this.errors, this.status});

  RemoveCartModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['status'] = this.status;
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
