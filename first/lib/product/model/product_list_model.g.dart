// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListModel _$ProductListModelFromJson(Map<String, dynamic> json) =>
    ProductListModel(
      id: json['id'] as String,
      name: json['name'] as String,
      detail: json['detail'] as String,
      imgUrl: DataUtils.pathToUrl(json['imgUrl'] as String),
      price: json['price'] as int,
      restaurant:
          RestaurantModel.fromJson(json['restaurant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductListModelToJson(ProductListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detail': instance.detail,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
      'restaurant': instance.restaurant,
    };
