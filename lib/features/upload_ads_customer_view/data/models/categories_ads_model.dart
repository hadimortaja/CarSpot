class CategoriesAdsModel {
  final int? code;
  final bool? status;
  final String? message;
  final List<DataCategoryAds>? data;

  CategoriesAdsModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  CategoriesAdsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) =>
                DataCategoryAds.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class DataCategoryAds {
  final int? id;
  final String? name;
  final String? nameEn;

  DataCategoryAds({this.id, this.name, this.nameEn});

  DataCategoryAds.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameEn = json['name_en'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'name_en': nameEn};
}
