class VendorProfileModel {
  final int? code;
  final bool? status;
  final String? message;
  final Data? data;

  VendorProfileModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  VendorProfileModel.fromJson(Map<String, dynamic> json)
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
  final String? address;
  final String? createdAt;
  final String? updatedAt;
  final String? description;
  final dynamic fcmToken;
  final int? normal;
  final int? premium;
  final int? turbo;
  final Vendor? vendor;
  final List<Phones>? phones;
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
    this.fcmToken,
    this.normal,
    this.premium,
    this.turbo,
    this.vendor,
    this.phones,
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
        address = json['address'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        description = json['description'] as String?,
        fcmToken = json['fcm_token'],
        normal = json['normal'] as int?,
        premium = json['premium'] as int?,
        turbo = json['turbo'] as int?,
        vendor = (json['vendor'] as Map<String,dynamic>?) != null ? Vendor.fromJson(json['vendor'] as Map<String,dynamic>) : null,
        phones = (json['phones'] as List?)?.map((dynamic e) => Phones.fromJson(e as Map<String,dynamic>)).toList(),
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
    'fcm_token' : fcmToken,
    'normal' : normal,
    'premium' : premium,
    'turbo' : turbo,
    'vendor' : vendor?.toJson(),
    'phones' : phones?.map((e) => e.toJson()).toList(),
    'customer' : customer
  };
}

class Vendor {
  final int? id;
  final int? userId;
  final int? serviceId;
  final int? categoryId;
  final int? cityId;
  final int? status;
  final String? passport;
  final String? license;
  final String? createdAt;
  final String? updatedAt;
  final List<WorkTime>? workTime;
  final City? city;

  Vendor({
    this.id,
    this.userId,
    this.serviceId,
    this.categoryId,
    this.cityId,
    this.status,
    this.passport,
    this.license,
    this.createdAt,
    this.updatedAt,
    this.workTime,
    this.city,
  });

  Vendor.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        serviceId = json['service_id'] as int?,
        categoryId = json['category_id'] as int?,
        cityId = json['city_id'] as int?,
        status = json['status'] as int?,
        passport = json['passport'] as String?,
        license = json['license'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        workTime = (json['work_time'] as List?)?.map((dynamic e) => WorkTime.fromJson(e as Map<String,dynamic>)).toList(),
        city = (json['city'] as Map<String,dynamic>?) != null ? City.fromJson(json['city'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'user_id' : userId,
    'service_id' : serviceId,
    'category_id' : categoryId,
    'city_id' : cityId,
    'status' : status,
    'passport' : passport,
    'license' : license,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'work_time' : workTime?.map((e) => e.toJson()).toList(),
    'city' : city?.toJson()
  };
}

class WorkTime {
  final String? day;
  final String? from;
  final String? to;

  WorkTime({
    this.day,
    this.from,
    this.to,
  });

  WorkTime.fromJson(Map<String, dynamic> json)
      : day = json['day'] as String?,
        from = json['from'] as String?,
        to = json['to'] as String?;

  Map<String, dynamic> toJson() => {
    'day' : day,
    'from' : from,
    'to' : to
  };
}

class City {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? createdAt;
  final String? updatedAt;
  final String? logo;
  final dynamic normalPlat;
  final dynamic classicPlat;

  City({
    this.id,
    this.name,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
    this.logo,
    this.normalPlat,
    this.classicPlat,
  });

  City.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameEn = json['name_en'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        logo = json['logo'] as String?,
        normalPlat = json['normal_plat'],
        classicPlat = json['classic_plat'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_en' : nameEn,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'logo' : logo,
    'normal_plat' : normalPlat,
    'classic_plat' : classicPlat
  };
}

class Phones {
  final int? id;
  final int? userId;
  final String? number;
  final String? createdAt;
  final String? updatedAt;

  Phones({
    this.id,
    this.userId,
    this.number,
    this.createdAt,
    this.updatedAt,
  });

  Phones.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        number = json['number'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'user_id' : userId,
    'number' : number,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}