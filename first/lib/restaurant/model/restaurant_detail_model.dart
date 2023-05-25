import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/const/data.dart';
import '../../common/utils/data_utils.dart';
import '../../product/model/product_model.dart';
part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<ProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.thumbUrl,
    required super.name,
    required super.tags,
    required super.priceRange,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required super.ratings,
    required this.detail,
    required this.products
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) => _$RestaurantDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantDetailModelToJson(this);

  // factory RestaurantDetailModel.fromJson({
  //   required Map<String, dynamic> json
  // }) {
  //   return RestaurantDetailModel(
  //       id: json['id'],
  //       thumbUrl: 'http://${ip}${json['thumbUrl']}',
  //       name: json['name'],
  //       tags: List<String>.from(json['tags']),
  //       priceRange: RestaurantPriceRange.values.firstWhere((element) =>
  //       element.name == json['priceRange']
  //       ),
  //       ratingsCount: json['ratingsCount'],
  //       deliveryTime: json['deliveryTime'],
  //       deliveryFee: json['deliveryFee'],
  //       ratings: json['ratings'],
  //       detail: json['detail'],
  //       products: json['products'].map<ProductModel>(
  //           (x) => ProductModel.fromJson(json: x)
  //       ).toList()
  //   );
  // }

}