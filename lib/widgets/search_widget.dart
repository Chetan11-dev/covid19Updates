import 'dart:convert';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';
import 'package:responsive_ui_by_default/responsiveui.dart';

import '../models/country.dart';

class SearchCountryWidget extends StatefulWidget {
  final dartz.Function1<Country, void> onCountrySelected;

  const SearchCountryWidget({
    Key key,
    @required this.onCountrySelected,
  }) : super(key: key);

  @override
  _SearchCountryWidgetState createState() => _SearchCountryWidgetState();
}

class _SearchCountryWidgetState extends State<SearchCountryWidget> {
  List<Country> countries = [];
  bool isCountriesDataFormed = false;
  @override
  void initState() {
    super.initState();

    getCountries().then((r) => setState(() {
          isCountriesDataFormed = true;
          countries = r;
        }));
  }

  Future<List<Country>> getCountries() async {
    final countriesJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/countries.json');

    final countriesJson = json.decode(countriesJsonString) as List;

    List<Country> countriesLocal = [];

    for (var country in countriesJson)
      countriesLocal.add(Country.fromJson(country));

    return countriesLocal;
  }

  @override
  Widget build(BuildContext context) {
    if (!isCountriesDataFormed)
      return CircularProgressIndicator(strokeWidth: 2);
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SearchWidget<Country>(
          dataList: countries,
          hideSearchBoxWhenItemSelected: false,
          listContainerHeight: MediaQuery.of(context).size.height / 4,
          popupListItemBuilder: (Country country) {
            return Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    ' ${country.flag}   ${country.name}',
                    style: t.headline,
                  ),
                ),
                // Icon(Icons.arrow_drop_down, size: 6.0)
              ],
            );
          },
          queryBuilder: (String query, List<Country> countries) => countries
              .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
              .toList(),
          onItemSelected: widget.onCountrySelected,
          selectedItemBuilder:
              (Country country, VoidCallback deleteSelectedItem) {
            return sbh(0);
          },
          // widget customization
        ),
      );
  }
}
