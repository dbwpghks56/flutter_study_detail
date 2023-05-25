import 'package:json_annotation/json_annotation.dart';

import '../../common/const/data.dart';
import '../../common/utils/data_utils.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel{
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl
  )
  final String imgUrl;
  final String detail;
  final int price;

  ProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // factory ProductModel.fromJson({
  //   required Map<String, dynamic> json
  // }) {
  //   return ProductModel(
  //       id: json['id'],
  //       name: json['name'],
  //       imgUrl: 'http://${ip}${json['imgUrl']}',
  //       detail: json['detail'],
  //       price: json['price']
  //   );
  // }
}