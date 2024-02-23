import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(NoWeatherState());
  // Your code here
  getWeather({required String city}) async {
    try {
      WeatherModel weatherModel =
          await WeatherService(Dio()).getWeather(cityName: city);
      emit(WeatherLoadedState());
    } catch (e) {
      emit(WeatherFailedState());
    }
  }
}
