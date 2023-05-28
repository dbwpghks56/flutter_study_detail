import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/model/pagination_params.dart';
import 'package:first/common/provider/pagination_provider.dart';
import 'package:first/product/model/product_list_model.dart';
import 'package:first/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>
  ((ref) {
    final repository = ref.watch(productRepositoryProvider);

    return ProductStateNotifier(repository: repository);
} );

class ProductStateNotifier extends PaginationProvider<ProductListModel, ProductRepository> {
  ProductStateNotifier({
    required super.repository
  });
}