// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_basket_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketBody _$BasketBodyFromJson(Map<String, dynamic> json) => BasketBody(
      basketBodyBasket: (json['basketBodyBasket'] as List<dynamic>)
          .map((e) => PathBasketBodyBasket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BasketBodyToJson(BasketBody instance) =>
    <String, dynamic>{
      'basketBodyBasket': instance.basketBodyBasket,
    };

PathBasketBodyBasket _$PathBasketBodyBasketFromJson(
        Map<String, dynamic> json) =>
    PathBasketBodyBasket(
      productId: json['productId'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$PathBasketBodyBasketToJson(
        PathBasketBodyBasket instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
    };
