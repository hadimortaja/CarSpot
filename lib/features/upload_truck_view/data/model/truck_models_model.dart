class TruckModelsModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<DataTruckModel>? data;

  TruckModelsModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  TruckModelsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) =>
                DataTruckModel.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class DataTruckModel {
   int? id;
   String? name;
  final int? brandId;

  DataTruckModel({
    this.id,
    this.name,
    this.brandId,
  });

  DataTruckModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        brandId = json['brand_id'] as int?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'brand_id': brandId};
}
