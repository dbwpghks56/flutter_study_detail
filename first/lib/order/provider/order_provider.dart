import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/provider/pagination_provider.dart';
import 'package:first/order/model/order_model.dart';
import 'package:first/order/model/post_order_body.dart';
import 'package:first/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../repository/order_repository.dart';

final orderProvider = StateNotifierProvider
  <OrderStateProvider, CursorPaginationBase>((ref) {
    final orderRepository = ref.watch(orderRepositoryProvider);

    return OrderStateProvider(ref: ref, repository: orderRepository);
});

class OrderStateProvider extends PaginationProvider<
  OrderModel,
  OrderRepository
> {
  final Ref ref;

  OrderStateProvider({
    required this.ref,
    required super.repository
  });

  Future<bool> postOder() async{
    try{
      final uuid = Uuid();
      final state = ref.read(basketProvider);
      final id = uuid.v4();
      print(DateTime.now().toString());
      final resp = await repository.postOrder(
          body: PostOrderBody(
              id: id,
              products: state.map((e) => PostOrderBodyProduct(
                  productId: e.productModel.id,
                  count: e.count
              )).toList(),
              totalPrice: state.fold<int>(
                  0, (pre, next) => pre + next.count * next.productModel.price),
              createdAt: DateTime.now().toString()
          )
      );

      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }
}