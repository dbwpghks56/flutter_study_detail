import 'package:first/common/const/colors.dart';
import 'package:first/product/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  const ProductCard({
    required this.productModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight( // 내부에 존재하는 모든 위젯이 최대크기를 차지하는 위젯의 크기만큼을 가지게 된다.
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                productModel.imgUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                      productModel.detail,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: BODY_TEXT_COLOR,
                      fontSize: 14.0,

                    ),
                  ),
                  Text(
                    '₩${productModel.price}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              )
            )
          ],
        ),
      );
  }
}
