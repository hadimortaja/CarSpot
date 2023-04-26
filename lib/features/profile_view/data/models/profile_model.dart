class ProfileModel {
  final int? code;
  final bool? status;
  final String? message;
  final Data? data;

  ProfileModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'status' : status,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic phoneNumber;
  final String? type;
  final String? photo;
  final dynamic facebook;
  final dynamic youtube;
  final dynamic twitter;
  final dynamic address;
  final String? createdAt;
  final String? updatedAt;
  final String? description;
  final dynamic vendor;
  final dynamic customer;

  Data({
    this.id,
    this.name,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.phoneNumber,
    this.type,
    this.photo,
    this.facebook,
    this.youtube,
    this.twitter,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.vendor,
    this.customer,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        username = json['username'] as String?,
        email = json['email'] as String?,
        emailVerifiedAt = json['email_verified_at'],
        phoneNumber = json['phone_number'],
        type = json['type'] as String?,
        photo = json['photo'] as String?,
        facebook = json['facebook'],
        youtube = json['youtube'],
        twitter = json['twitter'],
        address = json['address'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        description = json['description'] as String?,
        vendor = json['vendor'],
        customer = json['customer'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'username' : username,
    'email' : email,
    'email_verified_at' : emailVerifiedAt,
    'phone_number' : phoneNumber,
    'type' : type,
    'photo' : photo,
    'facebook' : facebook,
    'youtube' : youtube,
    'twitter' : twitter,
    'address' : address,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'description' : description,
    'vendor' : vendor,
    'customer' : customer
  };
}