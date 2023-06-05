import 'dart:ffi';

import 'package:first/common/const/colors.dart';
import 'package:first/product/model/product_list_model.dart';
import 'package:first/product/model/product_model.dart';
import 'package:first/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onMinus;
  final VoidCallback? onAdd;

  const ProductCard({
    required this.id,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    this.onMinus,
    this.onAdd,
    Key? key,
  }) : super(key: key);

  factory ProductCard.fromProductListModel({
    required ProductListModel listModel,
    VoidCallback? onMinus,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: listModel.id,
      image: Image.network(
        listModel.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: listModel.name,
      detail: listModel.detail,
      price: listModel.price,
      onMinus: onMinus,
      onAdd: onAdd,
    );
  }

  factory ProductCard.fromProductModel({
    required ProductModel model,
    VoidCallback? onMinus,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onMinus: onMinus,
      onAdd: onAdd,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                child: image,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      detail,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: BODY_TEXT_COLOR,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      '￦$price',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if(onMinus != null && onAdd != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _Footer(
              total: (basket.firstWhere((element) => element.productModel.id == id).count *
                  basket.firstWhere((element) => element.productModel.id == id).productModel.price).toString(),
              count: basket.firstWhere((element) => element.productModel.id == id).count,
              onMinus: onMinus!,
              onAdd: onAdd!
            ),
          ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onMinus;
  final VoidCallback onAdd;

  const _Footer({
    required this.total,
    required this.count,
    required this.onMinus,
    required this.onAdd,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '총액 \\ ${total}',
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        Row(
          children: [
            renderButton(
              icon: Icons.remove,
              onTap: onMinus
            ),
            const SizedBox(width: 8.0),
            Text(
              count.toString(),
              style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(width: 8.0),
            renderButton(
              icon: Icons.add,
              onTap: onAdd
            )
          ],
        )
      ],
    );
  }
  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: PRIMARY_COLOR,
          width: 1.0
        )
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(icon, color: PRIMARY_COLOR,),
      ),
    );
  }
}


















