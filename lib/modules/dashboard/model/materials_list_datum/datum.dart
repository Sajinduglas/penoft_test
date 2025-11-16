import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class MaterialListModel {
  String? title;
  String? brand;
  String? price;
  String? originalPrice;
  double? rating;
  int? reviews;
  String? tag;
  String? image;

  MaterialListModel({
    this.title,
    this.brand,
    this.price,
    this.originalPrice,
    this.rating,
    this.reviews,
    this.tag,
    this.image,
  });

  factory MaterialListModel.fromJson(Map<String, dynamic> json) => _$MaterialListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialListModelToJson(this);
}
