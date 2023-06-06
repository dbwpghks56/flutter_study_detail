import 'package:first/common/const/colors.dart';
import 'package:first/order/provider/order_provider.dart';
import 'package:first/order/view/order_done_screen.dart';
import 'package:first/product/component/product_card.dart';
import 'package:first/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/layout/default_layout.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => "basket";
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    if(basket.isEmpty) {
      return DefaultLayout(
        title: "장바구니",
        child: Center(
          child:
            Text(
              "장바구니가 비어있습니다. ㅠㅠ"
            )
          ,
        ),
      );
    }

    final productsTotal = basket.fold(0, (p, n) => p + (n.productModel.price * n.count));
    final deliveryFee = basket.first.productModel.restaurant.deliveryFee;

    return DefaultLayout(
      title: "장바구니",
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return Divider(height: 32.0,);
                  },
                  itemCount: basket.length,
                  itemBuilder: (context, index) {
                    final model = basket[index];

                    return ProductCard.fromProductListModel(
                      listModel: model.productModel,
                      onAdd: () {
                        ref.read(basketProvider.notifier).addToBasket(productModel: model.productModel);
                      },
                      onMinus: () {
                        ref.read(basketProvider.notifier).removeFromBasket(productModel: model.productModel);
                      },
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "장바구니 금액",
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,

                        ),
                      ),
                      Text(
                        "${productsTotal} 원"
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "배달비",
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      if (basket.length > 0)
                        Text(
                          "${deliveryFee} 원"
                        )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "총액",
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        "${productsTotal + deliveryFee} 원"
                      )
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final resp = await ref.read(orderProvider.notifier).postOder();
                        print(resp);
                        if(resp) {
                          context.goNamed(OrderDoneScreen.routeName);
                        }else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(content: Text("결제 실패!"))
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR
                      ),
                      child: Text(
                        "결제하기 (${productsTotal + deliveryFee} 원)"
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}














