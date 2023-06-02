import 'package:dio/dio.dart';
import 'package:first/common/model/login_response.dart';
import 'package:first/common/model/token_response.dart';
import 'package:first/common/utils/data_utils.dart';

import '../../common/const/data.dart';

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio
  });

  Future<LoginResponse> login({
    required String username,
    required String password
  }) async {
    final serialized = DataUtils.plainBase64("${username}:${password}");

    final resp = await dio.post(
      '${baseUrl}/login',
      options: Options(
        headers: {
          'authorization' : 'Basic ${serialized}'
        }
      )
    );

    return LoginResponse.fromJson(resp.data);
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      "${baseUrl}/token",
      options: Options(
        headers: {
          "refreshToken": "true"
        }
      )
    );

    return TokenResponse.fromJson(resp.data);
  }
}












