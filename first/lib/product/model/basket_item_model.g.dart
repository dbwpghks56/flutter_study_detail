// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketItemModel _$BasketItemModelFromJson(Map<String, dynamic> json) =>
    BasketItemModel(
      productModel:
          ProductModel.fromJson(json['productModel'] as Map<String, dynamic>),
      count: json['count'] as int,
    );

Map<String, dynamic> _$BasketItemModelToJson(BasketItemModel instance) =>
    <String, dynamic>{
      'productModel': instance.productModel,
      'count': instance.count,
    };
