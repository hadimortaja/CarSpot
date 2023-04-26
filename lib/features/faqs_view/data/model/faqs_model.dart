class FaqsModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<Data>? data;

  FaqsModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  FaqsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class Data {
  final int? id;
  final String? quastion;
  final String? answer;
  final String? createdAt;
  final dynamic updatedAt;

  Data({
    this.id,
    this.quastion,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        quastion = json['quastion'] as String?,
        answer = json['answer'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'quastion': quastion,
        'answer': answer,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
