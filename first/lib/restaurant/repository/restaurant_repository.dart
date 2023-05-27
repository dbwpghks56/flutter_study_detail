import 'package:dio/dio.dart' hide Headers;
import 'package:first/common/dio/dio.dart';
import 'package:first/common/model/cursor_pagination_model.dart';
import 'package:first/restaurant/model/restaurant_detail_model.dart';
import 'package:first/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = RestaurantRepository(dio, baseUrl: "http://${ip}/restaurant");

  return repository;
});

@RestApi()
abstract class RestaurantRepository {
  // http://${ip}/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl})
   = _RestaurantRepository;


  @GET('/')
  @Headers({
    'accessToken' : 'true'
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  // http://${ip}/restaurant/{id}
  @GET('/{id}')
  @Headers({
    'accessToken' : 'true'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}