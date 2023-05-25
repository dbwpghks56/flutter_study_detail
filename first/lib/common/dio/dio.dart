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
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401 에러 = Token 재발급 시도, 재발금 되변 새 토큰으로 요청
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if(refreshToken == null) {
      // 에러 던지는 법 handler.reject
      handler.reject(err);
      return;
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try{
        final resp = await dio.post(
          'http://${ip}/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer ${refreshToken}',
            },
          ),
        );

        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        // 토큰 변경
        options.headers.addAll({
          'authorization' : 'Bearer ${accessToken}'
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요청 재전송
        // 에러가 발생한 똑같은 요청을 Header 만 바꿔서 재요청
        final response = await dio.fetch(options);

        // 새로 보낸 요청에 대한 응답을 받아서
        return handler.resolve(response);
      } on DioError catch(e) {
        return handler.reject(err);
      }
    }
  }
}











