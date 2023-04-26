class BannerModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<Banners>? banners;

  BannerModel({
    this.code,
    this.status,
    this.message,
    this.banners,
  });

  BannerModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        banners = (json['Banners'] as List?)?.map((dynamic e) => Banners.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'code' : code,
    'status' : status,
    'message' : message,
    'Banners' : banners?.map((e) => e.toJson()).toList()
  };
}

class Banners {
  final int? id;
  final String? name;
  final String? photo;
  final int? status;
  final String? link;
  final String? createdAt;
  final String? updatedAt;

  Banners({
    this.id,
    this.name,
    this.photo,
    this.status,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  Banners.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        photo = json['photo'] as String?,
        status = json['status'] as int?,
        link = json['link'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'photo' : photo,
    'status' : status,
    'link' : link,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}