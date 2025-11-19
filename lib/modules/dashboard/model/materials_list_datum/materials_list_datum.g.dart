// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materials_list_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialsListDatum _$MaterialsListDatumFromJson(Map<String, dynamic> json) =>
    MaterialsListDatum(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MaterialListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MaterialsListDatumToJson(MaterialsListDatum instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
