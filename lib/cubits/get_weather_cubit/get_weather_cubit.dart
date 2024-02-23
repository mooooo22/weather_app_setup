import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(NoWeatherState());
  // Your code here
  WeatherModel? weatherModel;
  getWeather({required String city}) async {
    try {
      weatherModel = await WeatherService(Dio()).getWeather(cityName: city);
      log(weatherModel!.condition);
      emit(WeatherLoadedState(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherFailedState(
          errorMessage: e.toString().replaceRange(0, 10, '')));
    }
  }
}
