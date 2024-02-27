import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/service/weather_service.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchController = TextEditingController();
  Key _futureBuilderKey = UniqueKey(); // Key for FutureBuilder
  bool _shouldFetchSuggestions =
      true; // Flag to control whether to fetch suggestions
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
                  setState(() {
                    _futureBuilderKey = UniqueKey(); // Change the key
                    _shouldFetchSuggestions = true;
                  });
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
            FutureBuilder(
              key: _futureBuilderKey,
              future: WeatherService(Dio()).getAutocompleteSuggestions(
                  _searchController.text, _shouldFetchSuggestions),
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index]),
                          onTap: () {
                            setState(() {
                              _searchController.text = snapshot.data![index];
                              _shouldFetchSuggestions = false;
                              _futureBuilderKey = UniqueKey();
                            });
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
