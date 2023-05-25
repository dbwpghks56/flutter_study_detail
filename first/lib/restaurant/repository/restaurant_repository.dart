import 'package:dio/dio.dart' hide Headers;
import 'package:first/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://${ip}/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl})
   = _RestaurantRepository;


  // @GET('/')
  // paginate();

  // http://${ip}/restaurant/{id}
  @GET('/{id}')
  @Headers({
    'authorization' : 'Bearer '
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}