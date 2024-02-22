import 'package:flutter/material.dart';

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
        body: Center(
          child: TextField(
            onChanged: (query) {},
            onSubmitted: (value) {},
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
    );
  }
}
