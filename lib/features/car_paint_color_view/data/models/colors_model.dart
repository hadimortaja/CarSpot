class ColorsModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<DataColors>? data;

  ColorsModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  ColorsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => DataColors.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'code' : code,
    'status' : status,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class DataColors {
    int? id;
   String? name;
   String? nameEn;
  final String? code;

  DataColors({
    this.id,
    this.name,
    this.nameEn,
    this.code,
  });

  DataColors.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameEn = json['name_en'] as String?,
        code = json['code'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_en' : nameEn,
    'code' : code
  };
}