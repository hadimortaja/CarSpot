class TruckBrandsModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<DataTruckBrands>? data;

  TruckBrandsModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  TruckBrandsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) =>
                DataTruckBrands.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class DataTruckBrands {
   int? id;
   String? name;
  final dynamic nameAr;
  final String? logo;
  final String? createdAt;
  final String? updatedAt;
  final int? makeId;
  final String? type;

  DataTruckBrands({
    this.id,
    this.name,
    this.nameAr,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.makeId,
    this.type,
  });

  DataTruckBrands.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameAr = json['name_ar'],
        logo = json['logo'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        makeId = json['MakeId'] as int?,
        type = json['type'] as String?;

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
