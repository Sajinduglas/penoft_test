import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'courses_list_datum.g.dart';

@JsonSerializable()
class CoursesListDatum {
  String? message;
  List<CourseListModel>? data;

  CoursesListDatum({this.message, this.data});

  factory CoursesListDatum.fromJson(Map<String, dynamic> json) {
    return _$CoursesListDatumFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CoursesListDatumToJson(this);
}
