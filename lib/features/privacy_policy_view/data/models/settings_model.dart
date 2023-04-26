class SettingsModel {
  final int? code;
  final bool? status;
  final String? message;
  final Data? data;

  SettingsModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  SettingsModel.fromJson(Map<String, dynamic> json)
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
  final String? policy;
  final String? logo;
  final String? createdAt;
  final dynamic updatedAt;

  Data({
    this.id,
    this.policy,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        policy = json['policy'] as String?,
        logo = json['logo'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'policy': policy,
        'logo': logo,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
