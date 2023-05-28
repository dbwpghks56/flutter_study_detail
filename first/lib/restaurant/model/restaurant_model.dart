import 'package:first/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/const/data.dart';
import '../../common/utils/data_utils.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange{
  expensive,
  medium,
  cheap
}

@JsonSerializable()
class RestaurantModel implements IModelWithId{
  final String id;

  @JsonKey(
    fromJson: DataUtils.pathToUrl
  )
  final String thumbUrl;
  final String name;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;

  RestaurantModel({
    required this.id,
    required this.thumbUrl,
    required this.name,
    required this.tags,
    required this.priceRange,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => _$RestaurantModelFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);


  // factory RestaurantModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantModel(
  //       id: json['id'],
  //       name: json['name'],
  //       thumbUrl: 'http://${ip}${json['thumbUrl']}',
  //       tags: List<String>.from(json['tags']),
  //       priceRange: RestaurantPriceRange.values.firstWhere((element) =>
  //       element.name == json['priceRange']
  //       ),
  //       ratings: json['ratings'],
  //       ratingsCount: json['ratingsCount'],
  //       deliveryTime: json['deliveryTime'],
  //       deliveryFee: json['deliveryFee']
  //   );
  // }
}






