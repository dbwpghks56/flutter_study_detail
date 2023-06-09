
import 'package:dio/dio.dart' hide Headers;
import 'package:first/common/dio/dio.dart';
import 'package:first/product/model/basket_item_model.dart';
import 'package:first/product/model/patch_basket_body.dart';
import 'package:first/user/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio  = ref.watch(dioProvider);

  return UserMeRepository(dio, baseUrl: "http://${ip}/user/me");
});

@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET("/")
  @Headers({
    "accessToken": "True"
  })
  Future<UserModel> getMe();

  @GET("/basket")
  @Headers({
    'accessToken':'true'
  })
  Future<List<BasketItemModel>> getBasket();

  @PATCH("/basket")
  @Headers({
    'accessToken':'true'
  })
  Future<List<BasketItemModel>> patchBasket({
    @Body() required BasketBody body
  });

}