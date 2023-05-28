import '../const/data.dart';

class DataUtils{
  static pathToUrl(String value) {
    return 'http://${ip}${value}';
  }
  static listPathsToUrls(List<String> paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}