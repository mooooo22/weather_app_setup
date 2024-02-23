import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String key = 'add19fb89abc49d6953165951240601';
  WeatherService(this.dio);
  Future<WeatherModel> getWeather({required String cityName}) async {
    try {
      Response response =
          await dio.get('$baseUrl/forecast.json?key=$key&q=$cityName&days=1');
      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      final String error =
          e.response?.data['error']['message'] ?? 'Opps,Something went wrong';
      throw Exception(error);
    } catch (e) {
      log(e.toString());
      throw Exception('Something went wrong');
    }
  }

  Future<List<String>> getAutocompleteSuggestions(
      String query, bool shouldFetchSuggestions) async {
    try {
      if (!shouldFetchSuggestions || query.isEmpty) {
        return [];
      }

      final response = await dio.get(
        '$baseUrl/search.json',
        queryParameters: {
          'key': key,
          'q': query,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return List<String>.from(data.map((item) => item['name']));
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load suggestions');
    }
  }
}
