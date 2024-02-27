import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/service/weather_service.dart';

class GetSuggestionCubit extends Cubit<List<String>> {
  GetSuggestionCubit() : super([]);
  
  List<String> suggestions = [];
  WeatherService weatherService = WeatherService(Dio());
  
  void fetchSuggestions(String query) async {
    try {
      if ( query.isEmpty) {
        suggestions = [];
      } else {
        suggestions = await weatherService.getAutocompleteSuggestions(query);
      }
      emit(suggestions);
    } on Exception catch (e) {
      emit([]);
      log('Error: $e');
    }
  }
  
  void clearSuggestions() {
    emit([]);
  }
}

