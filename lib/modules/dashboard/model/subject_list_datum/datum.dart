import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class SubjectListModel {
  String? subject;
  String? icon;
  @JsonKey(name: 'main-color')
  String? mainColor;
  @JsonKey(name: 'gradient-color')
  String? gradientColor;

  SubjectListModel(
      {this.subject, this.icon, this.mainColor, this.gradientColor});

  factory SubjectListModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectListModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectListModelToJson(this);
}
