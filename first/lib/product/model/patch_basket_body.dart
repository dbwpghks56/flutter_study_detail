
import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

@JsonSerializable()
class BasketBody{
  final List<PathBasketBodyBasket> basketBodyBasket;

  BasketBody({
    required this.basketBodyBasket
  });

  factory BasketBody.fromJson(Map<String, dynamic> json) => _$BasketBodyFromJson(json);
  Map<String, dynamic> toJson() => _$BasketBodyToJson(this);
}

@JsonSerializable()
class PathBasketBodyBasket {
  final String productId;
  final int count;


  PathBasketBodyBasket({
    required this.productId,
    required this.count
  });

  Map<String, dynamic> toJson() => _$PathBasketBodyBasketToJson(this);
  factory PathBasketBodyBasket.fromJson(Map<String, dynamic> json) => _$PathBasketBodyBasketFromJson(json);
}