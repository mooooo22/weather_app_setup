import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_suggestions_cubit/suggestions_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  TextEditingController _searchController = TextEditingController();
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  BlocProvider.of<GetSuggestionCubit>(context)
                      .fetchSuggestions(query);
                },
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
            SizedBox(height: 10),
            BlocBuilder<GetSuggestionCubit, List<String>>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state[index]),
                        onTap: () {
                          _searchController.text = state[index];
                          BlocProvider.of<GetWeatherCubit>(context)
                              .getWeather(city: state[index]);
                          BlocProvider.of<GetSuggestionCubit>(context)
                              .clearSuggestions();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
