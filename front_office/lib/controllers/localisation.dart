
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
