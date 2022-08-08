import 'package:dio/dio.dart';

class HttpService {
  static const baseUrl = 'http://api.openweathermap.org/data/2.5/forecast?';

  final dio =
      Dio(BaseOptions(baseUrl: baseUrl, responseType: ResponseType.plain));

  Future<Response<dynamic>?> getAllWeather() async {
    print("Working get all post");

    final response =
        await dio.get('id=524901&appid=68d62bada62a0fe46b1dcfd511eb08f1');

    return response;
  }
}
