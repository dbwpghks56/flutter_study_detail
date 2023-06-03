import 'package:first/product/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'basket_item_model.g.dart';

@JsonSerializable()
class BasketItemModel {
  final ProductModel productModel;
  final int count;

  BasketItemModel({
    required this.productModel,
    required this.count
  });

  BasketItemModel copyWith({
    ProductModel? productModel,
    int? count
  }) {
    return BasketItemModel(
        productModel: productModel ?? this.productModel,
        count: count ?? this.count
    );
  }
  
  factory BasketItemModel.fromJson(Map<String, dynamic> json) => _$BasketItemModelFromJson(json);
}