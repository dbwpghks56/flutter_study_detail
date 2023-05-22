
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:first/common/const/colors.dart';
import 'package:first/common/const/data.dart';
import 'package:first/common/layout/default_layout.dart';
import 'package:first/common/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/component/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    final dio = Dio();

    return DefaultLayout(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Title(),
                  const SizedBox(height: 16.0,),
                  const _SubTitle(),
                  Image.asset(
                    'asset/img/misc/logo.png',
                    width: MediaQuery.of(context).size.width/ 3 * 2,
                  ),
                  CustomTextFormField(
                    hintText: "이메일을 입력해주세요.",
                    onChanged: (value) {
                      userName = value;
                    },
                  ),
                  const SizedBox(height: 16.0,),
                  CustomTextFormField(
                    hintText: "비밀번호를 입력해주세요.",
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(height: 16.0,),
                  ElevatedButton(
                      onPressed: () async {
                        // ID:password
                        final rawString = '${userName}:${password}';

                        // base64 encoding
                        Codec<String, String> stringToBase64 = utf8.fuse(base64);

                        String basicToken = stringToBase64.encode(rawString);

                        final resp = await dio.post(
                          'http://${ip}/auth/login',
                          options: Options(
                            headers: {
                              'authorization' : 'Basic ${basicToken}'
                            },
                          ),
                        );

                        final refreshToken = resp.data['refreshToken'];
                        final accessToken = resp.data['accessToken'];

                        await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
                        
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => RootTab())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text("로그인")
                  ),
                  TextButton(
                      onPressed: () async {
                        final resp = await dio.post(
                          'http://${ip}/auth/token',
                          options: Options(
                            headers: {
                              'authorization' : 'Bearer '
                            },
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black
                      ),
                      child: const Text("회원가입")
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다.',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "이메일과 비밀번호를 입력해서 로그인 해주세요! \n 오늘도 성공적인 주문이 되길 :)",
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR
      ),
    );
  }
}


