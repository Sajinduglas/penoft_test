// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_list_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectListDatum _$SubjectListDatumFromJson(Map<String, dynamic> json) =>
    SubjectListDatum(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SubjectListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectListDatumToJson(SubjectListDatum instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
