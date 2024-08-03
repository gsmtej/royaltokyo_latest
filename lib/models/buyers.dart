class Users {
  String? userUID;
  String? userName;
  String? userEmail;
  String? userAvatarUrl;
  String? address;

  Users({
    this.userUID,
    this.userName,
    this.userEmail,
    this.userAvatarUrl,
    this.address,
  });

  Users.fromJson(Map<String, dynamic> json) {
    userUID = json["userUID"];
    userName = json["userName"];
    userEmail = json["userEmail"];
    userAvatarUrl = json["userAvatarUrl"];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["userUID"] = userUID;
    data["userName"] = userName;
    data["userEmail"] = userEmail;
    data["userAvatarUrl"] = userAvatarUrl;
    data["address"] = address;

    return data;
  }
}