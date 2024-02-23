import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: getThemColor(
                    BlocProvider.of<GetWeatherCubit>(context)
                        .weatherModel
                        ?.condition),
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  color: getThemColor(BlocProvider.of<GetWeatherCubit>(context)
                      .weatherModel
                      ?.condition),
                ),
              ),
              home: HomeView(),
            );
          },
        );
      }),
    );
  }

  MaterialColor getThemColor(String? condition) {
    if (condition == null) return Colors.blue;
    if (condition == 'Sunny' || condition == 'Clear') {
      return Colors.amber;
    } else if (condition == 'Partly Cloudy') {
      return Colors.blue;
    } else if (condition == 'Cloudy' ||
        condition == 'Overcast' ||
        condition == 'Mist') {
      return Colors.blue;
    } else if (condition == 'Patchy rain possible' ||
        condition == 'Thundery outbreaks possible' ||
        condition == 'Blowing snow' ||
        condition == 'Blizzard' ||
        condition == 'Fog' ||
        condition == 'Freezing fog' ||
        condition == 'Patchy light drizzle' ||
        condition == 'Light drizzle' ||
        condition == 'Freezing drizzle' ||
        condition == 'Heavy freezing drizzle' ||
        condition == 'Patchy light rain' ||
        condition == 'Light rain' ||
        condition == 'Moderate rain at times' ||
        condition == 'Moderate rain' ||
        condition == 'Heavy rain at times' ||
        condition == 'Heavy rain' ||
        condition == 'Light freezing rain' ||
        condition == 'Moderate or heavy freezing rain' ||
        condition == 'Light sleet' ||
        condition == 'Moderate or heavy sleet' ||
        condition == 'Patchy light snow' ||
        condition == 'Light snow' ||
        condition == 'Patchy moderate snow' ||
        condition == 'Moderate snow' ||
        condition == 'Patchy heavy snow' ||
        condition == 'Heavy snow' ||
        condition == 'Ice pellets' ||
        condition == 'Light rain shower' ||
        condition == 'Moderate or heavy rain shower' ||
        condition == 'Torrential rain shower' ||
        condition == 'Light sleet showers' ||
        condition == 'Moderate or heavy sleet showers' ||
        condition == 'Light snow showers' ||
        condition == 'Moderate or heavy snow showers' ||
        condition == 'Light showers of ice pellets' ||
        condition == 'Moderate or heavy showers of ice pellets' ||
        condition == 'Patchy light rain with thunder' ||
        condition == 'Moderate or heavy rain with thunder' ||
        condition == 'Patchy light snow with thunder' ||
        condition == 'Moderate or heavy snow with thunder') {
      return Colors.indigo;
    } else {
      return Colors.grey;
    }
  }
}
