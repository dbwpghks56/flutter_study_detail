import '../../common/const/data.dart';

class ProductModel{
  final String id;
  final String name;
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

  factory ProductModel.fromJson({
    required Map<String, dynamic> json
  }) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        imgUrl: 'http://${ip}${json['imgUrl']}',
        detail: json['detail'],
        price: json['price']
    );
  }
}