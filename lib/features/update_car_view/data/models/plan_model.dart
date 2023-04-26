class PlansModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<DataPlans>? data;

  PlansModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  PlansModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => DataPlans.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class DataPlans {
  final int? id;
  final String? title;
  final int? resentCount;
  final int? special;
  final String? createdAt;
  final String? updatedAt;

  DataPlans({
    this.id,
    this.title,
    this.resentCount,
    this.special,
    this.createdAt,
    this.updatedAt,
  });

  DataPlans.fromJson(Map<String, dynamic> json)
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
