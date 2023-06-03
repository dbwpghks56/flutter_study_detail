
import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

@JsonSerializable()
class BasketBody{
  final String productId;
  final int count;

  BasketBody({
    required this.productId,
    required this.count
  });

  factory BasketBody.fromJson(Map<String, dynamic> json) => _$BasketBodyFromJson(json);
  Map<String, dynamic> toJson() => _$BasketBodyToJson(this);
}