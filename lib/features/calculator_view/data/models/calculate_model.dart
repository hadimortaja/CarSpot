class CalculateModel {
  final int? code;
  final bool? status;
  final String? message;
  final String? data;

  CalculateModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  CalculateModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = json['data'].toString();

  Map<String, dynamic> toJson() =>
      {'code': code, 'status': status, 'message': message, 'data': data};
}
