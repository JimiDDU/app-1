import 'package:flutter/material.dart';
import 'package:grocery_onlineapp/models/businessLayer/placeService.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;

  PlaceApiProvider apiClient;
  @override
  InputDecorationTheme searchFieldDecorationTheme = InputDecorationTheme(
    border: UnderlineInputBorder(borderSide: BorderSide.none),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
    hintStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
  );

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isNotEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == "" ? null : apiClient.fetchSuggestions(query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text((snapshot.data[index] as Suggestion).description),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(
                  child: Text(
                  'Loading...',
                )),
    );
  }
}
