import 'package:weather_app/models/weather_model.dart';

class WeatherState {}

class NoWeatherState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherModel;
  WeatherLoadedState({required this.weatherModel});
}

class WeatherFailedState extends WeatherState {
  final String originalErrorMessage;
  final String errorMessage;

  WeatherFailedState({required this.originalErrorMessage})
      : errorMessage = originalErrorMessage.substring(10);
}
