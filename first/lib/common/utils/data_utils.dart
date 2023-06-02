import 'dart:convert';

import '../const/data.dart';

class DataUtils{
  static String pathToUrl(String value) {
    return 'http://${ip}${value}';
  }
  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String plainBase64(String plain) {
    // base64 encoding
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String basicToken = stringToBase64.encode(plain);

    return basicToken;
  }
}