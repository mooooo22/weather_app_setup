import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // dismiss keyboard
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search a city'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: TextField(
              onChanged: (query) {},
              onSubmitted: (value) {
                BlocProvider.of<GetWeatherCubit>(context)
                    .getWeather(city: value);
                Navigator.of(context).pop();
              },
              autofillHints: const [AutofillHints.addressCity],
              autocorrect: const bool.fromEnvironment('true'),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 32, horizontal: 10.0),
                suffixIcon: Icon(Icons.search),
                labelText: 'Search',
                border: OutlineInputBorder(),
                hintFadeDuration: Duration(milliseconds: 100),
                hintText: 'Enter city name',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
