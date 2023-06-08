import 'package:first/common/component/pagination_list_view.dart';
import 'package:first/order/model/order_model.dart';
import 'package:first/order/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/order_card.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<OrderModel>(
        provider: orderProvider,
        itemBuilder: <OrderModel> (context, index, model) {
          return OrderCard.fromModel(model: model);
        },
    );
  }
}
