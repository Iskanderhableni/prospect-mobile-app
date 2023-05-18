/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  List<Prediction> _predictionList = [];
  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text != null && text.isNotEmpty) {
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      print("status" + data["status"]);
      if (data['status'] == 'ok') {
        _predictionList = [];
        data['prediction'].forEach((Prediction) =>
            _predictionList.add(Prediction.fromJson(Prediction)));
      }
    }
  }
}
*/

/*

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Places Autocomplete'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Prediction? p = await PlacesAutocomplete.show(
              context: context,
              apiKey: 'YOUR_API_KEY',
              mode: Mode
                  .overlay, // Change this to Mode.fullscreen to open fullscreen
              language: "en",
              components: [Component(Component.country, "us")],
            );

            if (p != null) {
              PlacesDetailsResponse detail =
                  await GoogleMapsPlaces(apiKey: 'YOUR_API_KEY')
                      .getDetailsByPlaceId(p.placeId!);
              var lat = detail.result.geometry!.location.lat;
              var lng = detail.result.geometry!.location.lng;
              print("${p.description} - $lat/$lng");
            }
          },
          child: Text('Search for a place'),
        ),
      ),
    );
  }
}
*/

import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:flutter/material.dart';

void showModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 600,
        color: Colors.red,
        child: Center(
            child: OpenStreetMapSearchAndPick(
                center: LatLong(2, 52),
                buttonColor: Colors.blue,
                buttonText: 'Choisir la Localisation',
                onPicked: (pickedData) {})),
      );
    },
  );
}
