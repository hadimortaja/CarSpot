class CategoriesModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<Categories>? categories;

  CategoriesModel({
    this.code,
    this.status,
    this.message,
    this.categories,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        categories = (json['Categories'] as List?)?.map((dynamic e) => Categories.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'code' : code,
    'status' : status,
    'message' : message,
    'Categories' : categories?.map((e) => e.toJson()).toList()
  };
}

class Categories {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? slug;
  final String? photo;
  final String? createdAt;
  final String? updatedAt;
  final int? serviceId;
  final int? parentId;

  Categories({
    this.id,
    this.name,
    this.nameEn,
    this.slug,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.serviceId,
    this.parentId,
  });

  Categories.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameEn = json['name_en'] as String?,
        slug = json['slug'] as String?,
        photo = json['photo'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        serviceId = json['service_id'] as int?,
        parentId = json['parent_id'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_en' : nameEn,
    'slug' : slug,
    'photo' : photo,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'service_id' : serviceId,
    'parent_id' : parentId
  };
}