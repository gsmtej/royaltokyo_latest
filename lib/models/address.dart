class Address
{
  String? name;
  String? phoneNumber;
   String? email;
  String? address;
  String? postcode;
  String? city;
  
  String? fullAddress;
  double? lat;
  double? lng;

  Address({
    this.name,
    this.phoneNumber,
    this.email,
    this.address,
    this.postcode,
    this.city,
    this.fullAddress,
    this.lat,
    this.lng, 
  });

  Address.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    postcode = json['postcode'];
    city = json['city'];
        fullAddress = json['fullAddress'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['postcode'] = postcode;
    data['city'] = city;
    data['fullAddress'] = fullAddress;
    data['lat'] = lat;
    data['lng'] = lng;

    return data;
  }
}