class ProductionYearsModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<DataYear>? data;

  ProductionYearsModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  ProductionYearsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => DataYear.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class DataYear {
  int? id;
  String? name;
  final String? createdAt;
  final String? updatedAt;

  DataYear({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  DataYear.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
