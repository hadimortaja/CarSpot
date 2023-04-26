class MostPopularModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<MostPobuler>? mostPobuler;

  MostPopularModel({
    this.code,
    this.status,
    this.message,
    this.mostPobuler,
  });

  MostPopularModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        mostPobuler = (json['Most_Pobuler'] as List?)
            ?.map(
                (dynamic e) => MostPobuler.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'Most_Pobuler': mostPobuler?.map((e) => e.toJson()).toList()
      };
}

class MostPobuler {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? slug;
  final String? photo;
  final String? createdAt;
  final String? updatedAt;
  final int? serviceId;
  final int? parentId;
  final List<Products>? products;

  MostPobuler({
    this.id,
    this.name,
    this.nameEn,
    this.slug,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.serviceId,
    this.parentId,
    this.products,
  });

  MostPobuler.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameEn = json['name_en'] as String?,
        slug = json['slug'] as String?,
        photo = json['photo'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        serviceId = json['service_id'] as int?,
        parentId = json['parent_id'] as int?,
        products = (json['products'] as List?)
            ?.map((dynamic e) => Products.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
    'name_en':nameEn,
        'slug': slug,
        'photo': photo,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'service_id': serviceId,
        'parent_id': parentId,
        'products': products?.map((e) => e.toJson()).toList()
      };
}

class Products {
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
  final dynamic content;
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
    int? isFavorit;
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
  final City? city;
  final Brand? brand;

  Products({
    this.id,
    this.userId,
    this.categoryId,
    this.cityId,
    this.planId,
    this.brandId,
    this.isFavorit,
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
    this.city,
    this.brand,
  });

  Products.fromJson(Map<String, dynamic> json)
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
        content = json['content'],
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
        isFavorit = json['isFavorit']??0,
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
        city = (json['city'] as Map<String, dynamic>?) != null
            ? City.fromJson(json['city'] as Map<String, dynamic>)
            : null,
  brand = (json['brand'] as Map<String, dynamic>?) != null
  ? Brand.fromJson(json['brand'] as Map<String, dynamic>)
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
        'city': city?.toJson(),
    'brand':brand?.toJson()
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

class Brand {
  final int? id;
  final String? name;
  final dynamic nameAr;
  final String? logo;
  final String? createdAt;
  final String? updatedAt;
  final int? makeId;
  final String? type;

  Brand({
    this.id,
    this.name,
    this.nameAr,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.makeId,
    this.type,
  });

  Brand.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameAr = json['name_ar'],
        logo = json['logo'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        makeId = json['MakeId'] as int?,
        type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_ar' : nameAr,
    'logo' : logo,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'MakeId' : makeId,
    'type' : type
  };
}
