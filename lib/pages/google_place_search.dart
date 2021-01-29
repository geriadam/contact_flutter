import 'dart:async';

import 'package:contact_flutter/models/contact.dart';
import 'package:contact_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import "package:google_maps_webservice/places.dart";
import "package:flutter_google_places/flutter_google_places.dart";

const kGoogleApiKey = GOOGLE_PLACE_API_KEY;

GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey:kGoogleApiKey);

final placeSearchPageKey = new GlobalKey<ScaffoldState>();

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    String lat = detail.result.geometry.location.lat.toString();
    String lng = detail.result.geometry.location.lng.toString();
    Contact contact = new Contact(address: p.description, latitude: lat, longitude: lng);
    Navigator.pop(scaffold.context, contact);
  }
}

class PlaceSearchPage extends PlacesAutocompleteWidget {
  PlaceSearchPage()
      : super(
    apiKey: kGoogleApiKey,
    language: "en",
  );

  @override
  _PlaceSearchPageState createState() => new _PlaceSearchPageState();
}

class _PlaceSearchPageState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    final appBar = new AppBar(title: new AppBarPlacesAutoCompleteTextField());
    final body = new PlacesAutocompleteResult(onTap: (p) {
      displayPrediction(p, placeSearchPageKey.currentState);
    });
    return new Scaffold(key: placeSearchPageKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    placeSearchPageKey.currentState
        .showSnackBar(new SnackBar(content: new Text(response.errorMessage)));
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {}
  }
}