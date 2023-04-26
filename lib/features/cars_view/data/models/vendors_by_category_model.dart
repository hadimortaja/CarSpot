class VendorsByCategoryModel {
  final int? code;
  final bool? status;
  final String? message;
  final Data? data;

  VendorsByCategoryModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  VendorsByCategoryModel.fromJson(Map<String, dynamic> json)
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
  final int? currentPage;
  final List<DataVendors>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Links>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] as int?,
        data = (json['data'] as List?)?.map((dynamic e) => DataVendors.fromJson(e as Map<String,dynamic>)).toList(),
        firstPageUrl = json['first_page_url'] as String?,
        from = json['from'] as int?,
        lastPage = json['last_page'] as int?,
        lastPageUrl = json['last_page_url'] as String?,
        links = (json['links'] as List?)?.map((dynamic e) => Links.fromJson(e as Map<String,dynamic>)).toList(),
        nextPageUrl = json['next_page_url'] as String?,
        path = json['path'] as String?,
        perPage = json['per_page'] as int?,
        prevPageUrl = json['prev_page_url'],
        to = json['to'] as int?,
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
    'current_page' : currentPage,
    'data' : data?.map((e) => e.toJson()).toList(),
    'first_page_url' : firstPageUrl,
    'from' : from,
    'last_page' : lastPage,
    'last_page_url' : lastPageUrl,
    'links' : links?.map((e) => e.toJson()).toList(),
    'next_page_url' : nextPageUrl,
    'path' : path,
    'per_page' : perPage,
    'prev_page_url' : prevPageUrl,
    'to' : to,
    'total' : total
  };
}

class DataVendors {
  final int? id;
  final int? userId;
  final int? serviceId;
  final int? categoryId;
  final int? cityId;
  final int? status;
  final String? passport;
  final dynamic license;
  final String? createdAt;
  final dynamic updatedAt;
  final String? workTime;
  final User? user;
  final City? city;

  DataVendors({
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
    this.user,
    this.city,
  });

  DataVendors.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        serviceId = json['service_id'] as int?,
        categoryId = json['category_id'] as int?,
        cityId = json['city_id'] as int?,
        status = json['status'] as int?,
        passport = json['passport'] as String?,
        license = json['license'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'],
        workTime = json['work_time'] as String?,
        user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null,
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
    'work_time' : workTime,
    'user' : user?.toJson(),
    'city' : city?.toJson()
  };
}

class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? phoneNumber;
  final String? type;
  final String? photo;
  final dynamic facebook;
  final dynamic youtube;
  final dynamic twitter;
  final String? address;
  final String? createdAt;
  final String? updatedAt;
  final dynamic description;
  final dynamic fcmToken;
  final List<Phones>? phones;

  User({
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
    this.phones,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        username = json['username'] as String?,
        email = json['email'] as String?,
        emailVerifiedAt = json['email_verified_at'],
        phoneNumber = json['phone_number'] as String?,
        type = json['type'] as String?,
        photo = json['photo'] as String?,
        facebook = json['facebook'],
        youtube = json['youtube'],
        twitter = json['twitter'],
        address = json['address'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        description = json['description'],
        fcmToken = json['fcm_token'],
        phones = (json['phones'] as List?)?.map((dynamic e) => Phones.fromJson(e as Map<String,dynamic>)).toList();

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
    'phones' : phones?.map((e) => e.toJson()).toList()
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

class Links {
  final dynamic url;
  final String? label;
  final bool? active;

  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        label = json['label'] as String?,
        active = json['active'] as bool?;

  Map<String, dynamic> toJson() => {
    'url' : url,
    'label' : label,
    'active' : active
  };
}