import 'package:dio/dio.dart';

class HttpsClient {
  // 域名
  static String domain = "https://miapp.itying.com/";
  // 网络请求库
  static Dio dio = Dio();
  
  HttpsClient() {
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = Duration(milliseconds: 5000);
    dio.options.receiveTimeout = Duration(milliseconds: 5000);
  }
  
  static Future get(String apiUrl) async {
    HttpsClient();
    try {
      var response = await dio.get(apiUrl);
      return response;
    } catch (e) {
      DioException error = e as DioException;
      return error.response;
    }
  }

  // 替换图片的地址
  static replacePic(String pic) {
    var imageUrl = domain + pic;
    return  imageUrl.replaceAll("\\", "/");
  }

}