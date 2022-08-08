import 'dart:developer';

import 'package:get/get.dart';
import 'package:weater_app/model/weather_model.dart';
import 'package:weater_app/service/http_service.dart';
import 'package:weater_app/service/http_service_imp.dart';

class WeatetController extends GetxController {
  WeatherModel? data;

  void onInit() {
    getWeather();
  }

  getWeather() async {
    final response = await HttpService().getAllWeather();
    log(response!.data);
    data = weatherModelFromJson(response.toString());
    print(data!.city.name.toString());
    update();
  }

  
}
