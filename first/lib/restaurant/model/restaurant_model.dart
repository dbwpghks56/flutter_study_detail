import '../../common/const/data.dart';

enum RestaurantPriceRange{
  expensive,
  medium,
  cheap
}

class RestaurantModel{
  final String id;
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
  
  factory RestaurantModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantModel(
        id: json['id'],
        name: json['name'],
        thumbUrl: 'http://${ip}${json['thumbUrl']}',
        tags: List<String>.from(json['tags']),
        priceRange: RestaurantPriceRange.values.firstWhere((element) =>
        element.name == json['priceRange']
        ),
        ratings: json['ratings'],
        ratingsCount: json['ratingsCount'],
        deliveryTime: json['deliveryTime'],
        deliveryFee: json['deliveryFee']
    );
  }
}






