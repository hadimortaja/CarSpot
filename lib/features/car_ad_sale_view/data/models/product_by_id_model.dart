import '../../../my_ads_view/data/models/my_ads_model.dart';
import 'package:get/get.dart';

class ProductByIDModel {
  final int? code;
  final bool? status;
  final String? message;
  final Data? data;

  ProductByIDModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  ProductByIDModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.toJson()
      };
}

class Data {
  final int? id;
  final int? userId;
  final int? categoryId;
  final int? cityId;
  final int? planId;
  final int? brandId;
  final int? styleId;
  final int? colorId;
  final String? name;
  final String? slug;
  final String? photo;
  final String? price;
  final dynamic priceDaily;
  final dynamic priceMonthly;
  final dynamic priceYearly;
  final String? content;
  final String? typeProduct;
  final String? condition;
  final String? productionYear;
  final String? kilometer;
  final String? address;
  final String? phone;
  final String? whatsapp;
  final String? description;
  final int? status;
  final int? active;
  final int? views;
  final int? republish;
  final String? createdAt;
  final String? updatedAt;
  final int? vendorId;
  final dynamic vehicleType;
  final dynamic numberType;
  final dynamic vehicleNumber;
  final dynamic code;
  final dynamic simType;
  final int? isFavorit;
  final List<Related>? related;
  final Plan? plan;
  final Color? color;
  final Style? style;
  final Brand? brand;
  final Category? category;
  List<Pictures>? pictures;
  final User? user;
  final City? city;

  Data({
    this.id,
    this.userId,
    this.categoryId,
    this.cityId,
    this.planId,
    this.brandId,
    this.styleId,
    this.colorId,
    this.name,
    this.slug,
    this.photo,
    this.price,
    this.priceDaily,
    this.priceMonthly,
    this.priceYearly,
    this.content,
    this.typeProduct,
    this.condition,
    this.productionYear,
    this.kilometer,
    this.address,
    this.phone,
    this.whatsapp,
    this.description,
    this.status,
    this.active,
    this.views,
    this.republish,
    this.createdAt,
    this.updatedAt,
    this.vendorId,
    this.vehicleType,
    this.numberType,
    this.vehicleNumber,
    this.code,
    this.simType,
    this.isFavorit,
    this.related,
    this.plan,
    this.color,
    this.style,
    this.brand,
    this.category,
    this.pictures,
    this.user,
    this.city,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        categoryId = json['category_id'] as int?,
        cityId = json['city_id'] as int?,
        planId = json['plan_id'] as int?,
        brandId = json['brand_id'] as int?,
        styleId = json['style_id'] as int?,
        colorId = json['color_id'] as int?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        photo = json['photo'] as String?,
        price = json['price'].toString(),
        priceDaily = json['price_daily'],
        priceMonthly = json['price_monthly'],
        priceYearly = json['price_yearly'],
        content = json['content'] as String?,
        typeProduct = json['type_product'] as String?,
        condition = json['condition'] as String?,
        productionYear = json['production_year'] as String?,
        kilometer = json['kilometer'] as String?,
        address = json['address'] as String?,
        phone = json['phone'] as String?,
        whatsapp = json['whatsapp'] as String?,
        description = json['description'] as String?,
        status = json['status'] as int?,
        active = json['active'] as int?,
        views = json['views'] as int?,
        republish = json['republish'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        vendorId = json['vendor_id'] as int?,
        vehicleType = json['vehicle_type'],
        numberType = json['number_type'],
        vehicleNumber = json['vehicle_number'],
        code = json['code'],
        simType = json['sim_type'],
        isFavorit = json['isFavorit'] as int?,
        related = (json['related'] as List?)
            ?.map((dynamic e) => Related.fromJson(e as Map<String, dynamic>))
            .toList(),
        plan = (json['plan'] as Map<String, dynamic>?) != null
            ? Plan.fromJson(json['plan'] as Map<String, dynamic>)
            : null,
        color = (json['color'] as Map<String, dynamic>?) != null
            ? Color.fromJson(json['color'] as Map<String, dynamic>)
            : null,
        style = (json['style'] as Map<String, dynamic>?) != null
            ? Style.fromJson(json['style'] as Map<String, dynamic>)
            : null,
        brand = (json['brand'] as Map<String, dynamic>?) != null
            ? Brand.fromJson(json['brand'] as Map<String, dynamic>)
            : null,
        category = (json['category'] as Map<String, dynamic>?) != null
            ? Category.fromJson(json['category'] as Map<String, dynamic>)
            : null,
        pictures = (json['pictures'] as List?)
            ?.map((dynamic e) => Pictures.fromJson(e as Map<String, dynamic>))
            .toList(),
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        city = (json['city'] as Map<String, dynamic>?) != null
            ? City.fromJson(json['city'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'category_id': categoryId,
        'city_id': cityId,
        'plan_id': planId,
        'brand_id': brandId,
        'style_id': styleId,
        'color_id': colorId,
        'name': name,
        'slug': slug,
        'photo': photo,
        'price': price,
        'price_daily': priceDaily,
        'price_monthly': priceMonthly,
        'price_yearly': priceYearly,
        'content': content,
        'type_product': typeProduct,
        'condition': condition,
        'production_year': productionYear,
        'kilometer': kilometer,
        'address': address,
        'phone': phone,
        'whatsapp': whatsapp,
        'description': description,
        'status': status,
        'active': active,
        'views': views,
        'republish': republish,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'vendor_id': vendorId,
        'vehicle_type': vehicleType,
        'number_type': numberType,
        'vehicle_number': vehicleNumber,
        'code': code,
        'sim_type': simType,
        'isFavorit': isFavorit,
        'related': related?.map((e) => e.toJson()).toList(),
        'plan': plan?.toJson(),
        'color': color?.toJson(),
        'style': style?.toJson(),
        'brand': brand?.toJson(),
        'category': category?.toJson(),
        'pictures': pictures?.map((e) => e.toJson()).toList(),
        'user': user?.toJson(),
        'city': city?.toJson(),
      };
}

class Related {
  final int? id;
  final int? userId;
  final int? categoryId;
  final int? cityId;
  final int? planId;
  final int? brandId;
  final int? styleId;
  final int? colorId;
  final String? name;
  final String? slug;
  final String? photo;
  final String? price;
  final dynamic priceDaily;
  final dynamic priceMonthly;
  final dynamic priceYearly;
  final String? content;
  final String? typeProduct;
  final String? condition;
  final String? productionYear;
  final String? kilometer;
  final String? address;
  final String? phone;
  final String? whatsapp;
  final String? description;
  final int? status;
  final int? active;
  final int? views;
  final int? republish;
  final String? createdAt;
  final String? updatedAt;
  final int? vendorId;
  final dynamic vehicleType;
  final dynamic numberType;
  final dynamic vehicleNumber;
  final dynamic code;
  final dynamic simType;
  final CityRelated? cityRelated;
  final BrandRelated? brandRelated;

  Related({
    this.id,
    this.userId,
    this.categoryId,
    this.cityId,
    this.planId,
    this.brandId,
    this.styleId,
    this.colorId,
    this.name,
    this.slug,
    this.photo,
    this.price,
    this.priceDaily,
    this.priceMonthly,
    this.priceYearly,
    this.content,
    this.typeProduct,
    this.condition,
    this.productionYear,
    this.kilometer,
    this.address,
    this.phone,
    this.whatsapp,
    this.description,
    this.status,
    this.active,
    this.views,
    this.republish,
    this.createdAt,
    this.updatedAt,
    this.vendorId,
    this.vehicleType,
    this.numberType,
    this.vehicleNumber,
    this.code,
    this.simType,
    this.cityRelated,
    this.brandRelated,
  });

  Related.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        categoryId = json['category_id'] as int?,
        cityId = json['city_id'] as int?,
        planId = json['plan_id'] as int?,
        brandId = json['brand_id'] as int?,
        styleId = json['style_id'] as int?,
        colorId = json['color_id'] as int?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        photo = json['photo'] as String?,
        price = json['price'].toString(),
        priceDaily = json['price_daily'],
        priceMonthly = json['price_monthly'],
        priceYearly = json['price_yearly'],
        content = json['content'] as String?,
        typeProduct = json['type_product'] as String?,
        condition = json['condition'] as String?,
        productionYear = json['production_year'] as String?,
        kilometer = json['kilometer'] as String?,
        address = json['address'] as String?,
        phone = json['phone'] as String?,
        whatsapp = json['whatsapp'] as String?,
        description = json['description'] as String?,
        status = json['status'] as int?,
        active = json['active'] as int?,
        views = json['views'] as int?,
        republish = json['republish'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        vendorId = json['vendor_id'] as int?,
        vehicleType = json['vehicle_type'],
        numberType = json['number_type'],
        vehicleNumber = json['vehicle_number'],
        code = json['code'],
        simType = json['sim_type'],
        brandRelated = (json['brand'] as Map<String, dynamic>?) != null
            ? BrandRelated.fromJson(json['brand'] as Map<String, dynamic>)
            : null,
        cityRelated = (json['city'] as Map<String, dynamic>?) != null
            ? CityRelated.fromJson(json['city'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'category_id': categoryId,
        'city_id': cityId,
        'plan_id': planId,
        'brand_id': brandId,
        'style_id': styleId,
        'color_id': colorId,
        'name': name,
        'slug': slug,
        'photo': photo,
        'price': price,
        'price_daily': priceDaily,
        'price_monthly': priceMonthly,
        'price_yearly': priceYearly,
        'content': content,
        'type_product': typeProduct,
        'condition': condition,
        'production_year': productionYear,
        'kilometer': kilometer,
        'address': address,
        'phone': phone,
        'whatsapp': whatsapp,
        'description': description,
        'status': status,
        'active': active,
        'views': views,
        'republish': republish,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'vendor_id': vendorId,
        'vehicle_type': vehicleType,
        'number_type': numberType,
        'vehicle_number': vehicleNumber,
        'code': code,
        'sim_type': simType,
        'city': cityRelated?.toJson(),
        'brand': brandRelated?.toJson()
      };
}

class CityRelated {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? createdAt;
  final String? updatedAt;
  final String? logo;
  final dynamic normalPlat;
  final dynamic classicPlat;

  CityRelated({
    this.id,
    this.name,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
    this.logo,
    this.normalPlat,
    this.classicPlat,
  });

  CityRelated.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameEn = json['name_en'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        logo = json['logo'] as String?,
        normalPlat = json['normal_plat'],
        classicPlat = json['classic_plat'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_en': nameEn,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'logo': logo,
        'normal_plat': normalPlat,
        'classic_plat': classicPlat
      };
}

class BrandRelated {
  final int? id;
  final String? name;
  final dynamic nameAr;
  final String? logo;
  final String? createdAt;
  final String? updatedAt;
  final int? makeId;
  final dynamic type;

  BrandRelated({
    this.id,
    this.name,
    this.nameAr,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.makeId,
    this.type,
  });

  BrandRelated.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameAr = json['name_ar'],
        logo = json['logo'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        makeId = json['MakeId'] as int?,
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_ar': nameAr,
        'logo': logo,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'MakeId': makeId,
        'type': type
      };
}

class Plan {
  final int? id;
  final String? title;
  final int? resentCount;
  final int? special;
  final String? createdAt;
  final String? updatedAt;

  Plan({
    this.id,
    this.title,
    this.resentCount,
    this.special,
    this.createdAt,
    this.updatedAt,
  });

  Plan.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        resentCount = json['resent_count'] as int?,
        special = json['special'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'resent_count': resentCount,
        'special': special,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class Color {
  final int? id;
  final String? name;
  final String? nameEn;

  final String? code;
  final String? createdAt;
  final String? updatedAt;

  Color({
    this.id,
    this.name,
    this.nameEn,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  Color.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameEn = json['name_en'] as String?,
        code = json['code'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_en': nameEn,
        'code': code,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class Style {
  final int? id;
  final int? brandId;
  final String? name;
  final dynamic nameAr;
  final dynamic photo;
  final String? createdAt;
  final String? updatedAt;
  final int? modelID;

  Style({
    this.id,
    this.brandId,
    this.name,
    this.nameAr,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.modelID,
  });

  Style.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        brandId = json['brand_id'] as int?,
        name = json['name'] as String?,
        nameAr = json['name_ar'],
        photo = json['photo'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        modelID = json['Model_ID'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand_id': brandId,
        'name': name,
        'name_ar': nameAr,
        'photo': photo,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'Model_ID': modelID
      };
}

class Brand {
  final int? id;
  final String? name;
  final dynamic nameAr;
  final String? logo;
  final String? createdAt;
  final String? updatedAt;
  final int? makeId;

  Brand({
    this.id,
    this.name,
    this.nameAr,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.makeId,
  });

  Brand.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameAr = json['name_ar'],
        logo = json['logo'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        makeId = json['MakeId'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_ar': nameAr,
        'logo': logo,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'MakeId': makeId
      };
}

class Category {
  final int? id;
  final String? name;
  final String? slug;
  final String? photo;
  final String? createdAt;
  final String? updatedAt;
  final int? serviceId;
  final int? parentId;

  Category({
    this.id,
    this.name,
    this.slug,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.serviceId,
    this.parentId,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        photo = json['photo'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        serviceId = json['service_id'] as int?,
        parentId = json['parent_id'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'photo': photo,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'service_id': serviceId,
        'parent_id': parentId
      };
}

// class Pictures {
//   final int? id;
//   final int? productId;
//   final String? image;
//   final String? createdAt;
//   final String? updatedAt;
//
//   Pictures({
//     this.id,
//     this.productId,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Pictures.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         productId = json['product_id'] as int?,
//         image = json['image'] as String?,
//         createdAt = json['created_at'] as String?,
//         updatedAt = json['updated_at'] as String?;
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'product_id': productId,
//         'image': image,
//         'created_at': createdAt,
//         'updated_at': updatedAt
//       };
// }

class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic phoneNumber;
  final String? type;
  final dynamic photo;
  final dynamic facebook;
  final dynamic youtube;
  final dynamic twitter;
  final dynamic address;
  final String? createdAt;
  final String? updatedAt;
  final String? description;
  final List<dynamic>? phones;

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
    this.phones,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        username = json['username'] as String?,
        email = json['email'] as String?,
        emailVerifiedAt = json['email_verified_at'],
        phoneNumber = json['phone_number'],
        type = json['type'] as String?,
        photo = json['photo'],
        facebook = json['facebook'],
        youtube = json['youtube'],
        twitter = json['twitter'],
        address = json['address'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        description = json['description'] as String?,
        phones = json['phones'] as List?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'phone_number': phoneNumber,
        'type': type,
        'photo': photo,
        'facebook': facebook,
        'youtube': youtube,
        'twitter': twitter,
        'address': address,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'description': description,
        'phones': phones
      };
}

class City {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? createdAt;
  final String? updatedAt;
  final String? logo;

  City({
    this.id,
    this.name,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
    this.logo,
  });

  City.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameEn = json['name_en'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        logo = json['logo'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_en': nameEn,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'logo': logo
      };
}
