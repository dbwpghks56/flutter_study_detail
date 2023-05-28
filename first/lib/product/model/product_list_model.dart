import 'package:first/common/model/model_with_id.dart';
import 'package:first/common/utils/data_utils.dart';
import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list_model.g.dart';

@JsonSerializable()
class ProductListModel implements IModelWithId {
  final String id;
  final String name;
  final String detail;
  @JsonKey(
    fromJson: DataUtils.pathToUrl
  )
  final String imgUrl;
  final int price;
  final RestaurantModel restaurant;

  ProductListModel({
    required this.id, required this.name,
    required this.detail, required this.imgUrl, required this.price,
    required this.restaurant,
  });
  
  factory ProductListModel.fromJson(Map<String, dynamic> json) => _$ProductListModelFromJson(json);
}