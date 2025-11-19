import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'subject_list_datum.g.dart';

@JsonSerializable()
class SubjectListDatum {
  String? message;
  List<SubjectListModel>? data;

  SubjectListDatum({this.message, this.data});

  factory SubjectListDatum.fromJson(Map<String, dynamic> json) {
    return _$SubjectListDatumFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SubjectListDatumToJson(this);
}
