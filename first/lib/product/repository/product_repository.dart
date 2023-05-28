import 'package:dio/dio.dart' hide Headers;
import 'package:first/common/dio/dio.dart';
import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/common/model/pagination_params.dart';
import 'package:first/common/repository/base_pagination_repository.dart';
import 'package:first/product/model/product_list_model.dart';
import 'package:first/product/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return ProductRepository(dio,baseUrl: "http://${ip}/product");
});

@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<ProductListModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @GET('/')
  @Headers({
    'accessToken' : 'true'
  })
  Future<CursorPagination<ProductListModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams()
  });
}