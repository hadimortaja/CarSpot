class ServicesModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<DataService>? data;

  ServicesModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  ServicesModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map(
                (dynamic e) => DataService.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class DataService {
  final int? id;
  final String? name;

  DataService({
    this.id,
    this.name,
  });

  DataService.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
