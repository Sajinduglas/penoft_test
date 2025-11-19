import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class CourseListModel {
  String? title;
  String? author;
  String? duration;
  String? price;
  String? originalPrice;
  double? rating;
  int? reviews;
  String? tag;
  String? image;

  CourseListModel({
    this.title,
    this.author,
    this.duration,
    this.price,
    this.originalPrice,
    this.rating,
    this.reviews,
    this.tag,
    this.image,
  });

  factory CourseListModel.fromJson(Map<String, dynamic> json) =>
      _$CourseListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseListModelToJson(this);
}
