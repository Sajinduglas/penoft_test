import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'materials_list_datum.g.dart';

@JsonSerializable()
class MaterialsListDatum {
  String? message;
  List<MaterialListModel>? data;

  MaterialsListDatum({this.message, this.data});

  factory MaterialsListDatum.fromJson(Map<String, dynamic> json) {
    return _$MaterialsListDatumFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MaterialsListDatumToJson(this);
}
