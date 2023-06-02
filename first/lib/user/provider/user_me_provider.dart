import 'package:first/common/const/data.dart';
import 'package:first/user/model/user_model.dart';
import 'package:first/user/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repository/user_me_repository.dart';



class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final AuthRepository authRepository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.repository,
    required this.storage,
    required this.authRepository
  }) :super(UserModelLoading()) {
    // 내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String username,
    required String password
  }) async {

    try {
      state = UserModelLoading();

      final resp = await authRepository.login(username: username, password: password);

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);

      final userResp = await repository.getMe();

      state = userResp;

      return userResp;
    } catch(e) {
      state = UserModelError(message: "로그인에 실패했습니다.");

      return Future.value(state);
    }

  }

  Future<void> logout() async {
    state = null;

    await Future.wait([ // 동시에 실행
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY)
    ]);

  }
}
















