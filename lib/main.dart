import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_suggestions_cubit/suggestions_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) => GetSuggestionCubit(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: getThemColor(
                      BlocProvider.of<GetWeatherCubit>(context)
                          .weatherModel
                          ?.condition),
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
                    color: getThemColor(
                        BlocProvider.of<GetWeatherCubit>(context)
                            .weatherModel
                            ?.condition),
                  ),
                ),
                home: HomeView(),
              ),
            );
          },
        );
      }),
    );
  }
}

MaterialColor getThemColor(String? condition) {
  switch (condition.toString().trim()) {
    case 'Sunny':
    case 'Clear':
      return Colors.orange;
    case 'Partly Cloudy':
    case 'Cloudy':
    case 'Overcast':
    case 'Mist':
      return Colors.grey;
    case 'Patchy rain possible':
    case 'Thundery outbreaks possible':
    case 'Blowing snow':
    case 'Blizzard':
    case 'Fog':
    case 'Freezing fog':
    case 'Patchy light drizzle':
    case 'Light drizzle':
    case 'Freezing drizzle':
    case 'Heavy freezing drizzle':
    case 'Patchy light rain':
    case 'Light rain':
    case 'Moderate rain at times':
    case 'Moderate rain':
    case 'Heavy rain at times':
    case 'Heavy rain':
    case 'Light freezing rain':
    case 'Moderate or heavy freezing rain':
    case 'Light sleet':
    case 'Moderate or heavy sleet':
    case 'Patchy light snow':
    case 'Light snow':
    case 'Patchy moderate snow':
    case 'Moderate snow':
    case 'Patchy heavy snow':
    case 'Heavy snow':
    case 'Ice pellets':
    case 'Light rain shower':
    case 'Moderate or heavy rain shower':
    case 'Torrential rain shower':
    case 'Light sleet showers':
    case 'Moderate or heavy sleet showers':
    case 'Light snow showers':
    case 'Moderate or heavy snow showers':
    case 'Light showers of ice pellets':
    case 'Moderate or heavy showers of ice pellets':
    case 'Patchy light rain with thunder':
    case 'Moderate or heavy rain with thunder':
    case 'Patchy light snow with thunder':
    case 'Moderate or heavy snow with thunder':
      return Colors.indigo;
    default:
      log('condition is $condition');
      return Colors.blue;
  }
}
