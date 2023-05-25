import 'package:dio/dio.dart';
import 'package:first/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청 보낼 때
  /// 요청을 보낼 때마다
  /// 요청의 headers 에서 accessToken에 해당하는 value를 가져와서 true이면
  /// 실제 토큰을 가져와서 header 에 인증정보(Token)을 넣업서 보낸다.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: implement onRequest
    if(options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 Token 으로 대체
      options.headers.addAll({
        'authorization' : 'Bearer ${token}'
      });
    }

    if(options.headers['refreshToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 Token 으로 대체
      options.headers.addAll({
        'authorization' : 'Bearer ${token}'
      });
    }

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을 때

  // 3) 에러가 났을 때
}











