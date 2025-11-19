// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialListModel _$MaterialListModelFromJson(Map<String, dynamic> json) =>
    MaterialListModel(
      title: json['title'] as String?,
      brand: json['brand'] as String?,
      price: json['price'] as String?,
      originalPrice: json['originalPrice'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviews: (json['reviews'] as num?)?.toInt(),
      tag: json['tag'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$MaterialListModelToJson(MaterialListModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'brand': instance.brand,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'tag': instance.tag,
      'image': instance.image,
    };
