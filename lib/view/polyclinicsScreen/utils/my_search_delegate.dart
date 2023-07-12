import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/polyclinic.dart';
import '/models/polyclinic.dart';
import '../../utils/primary_text.dart';
import 'polyclinic_card.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query == ''
        ? Center(
            child: PrimaryText('polyclinicsPage_warningMessage'.tr, Colors.black),
          )
        : SearchResultsFutureBuilder(
            future: PolyclinicController.searchPolyclinic(query),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}

class SearchResultsFutureBuilder extends StatefulWidget {
  final Future future;

  SearchResultsFutureBuilder({@required this.future});

  @override
  _SearchResultsFutureBuilderState createState() => _SearchResultsFutureBuilderState();
}

class _SearchResultsFutureBuilderState extends State<SearchResultsFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            List<PolyclinicModel> polyclinics = snapshot.data;

            if (polyclinics.length == 0)
              return Center(
                child: PrimaryText('polyclinicDetailsPage_errMsg_doctorNotFound'.tr, Colors.black),
              );

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: polyclinics.length,
                itemBuilder: (context, i) => PolyclinicCard(polyclinics[i]),
              ),
            );
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
