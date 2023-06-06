import 'package:first/order/model/order_model.dart';
import 'package:first/order/model/post_order_body.dart';
import 'package:first/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../repository/order_repository.dart';

final orderProvider = StateNotifierProvider
  <OrderStateProvider, List<OrderModel>>((ref) {
    final orderRepository = ref.watch(orderRepositoryProvider);

    return OrderStateProvider(ref: ref,repository: orderRepository);
});

class OrderStateProvider extends StateNotifier<List<OrderModel>> {
  final Ref ref;
  final OrderRepository repository;

  OrderStateProvider({
    required this.ref,
    required this.repository
  }) : super([]);

  Future<bool> postOder() async{
    try{
      final uuid = Uuid();
      final state = ref.read(basketProvider);
      final id = uuid.v4();

      final resp = await repository.postOrder(
          body: PostOrderBody(
              id: id,
              products: state.map((e) => PostOrderBodyProduct(
                  productId: e.productModel.id,
                  count: e.count
              )).toList(),
              totalPrice: state.fold<int>(
                  0,
                      (pre, next) => pre + next.count * next.productModel.price),
              createdAt: DateTime.now().toString()
          )
      );

      return true;
    } catch(e) {
      return false;
    }
  }
}