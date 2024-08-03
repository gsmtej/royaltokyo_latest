class LoginModel {
  Results? results;
  Errors? errors;
  bool? status;
  String? msg;

  LoginModel({this.results, this.errors, this.status,this.msg});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  bool? success;
  String? message;
  String? token;
  String? mollieKey;
  User? user;

  Results({this.success, this.mollieKey, this.message, this.token, this.user});

  Results.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    mollieKey = json['mollie_key'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['mollie_key'] = this.mollieKey;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {

  int? id;
  String? name;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  int? status;
  String? profilePhotoPath;
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
    emailVerifiedAt = json['email_verified_at'].toString();
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
  List<ValidationMessage>? validationMessage;
  String? errorMessage;

  Errors({this.validationMessage, this.errorMessage});

  Errors.fromJson(Map<String, dynamic> json) {
    if (json['validationMessage'] != null) {
      validationMessage = <ValidationMessage>[];
      json['validationMessage'].forEach((v) {
        validationMessage!.add(new ValidationMessage.fromJson(v));
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

class ValidationMessage {
  String? email;
  String? password;

  ValidationMessage({this.email, this.password});

  ValidationMessage.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
