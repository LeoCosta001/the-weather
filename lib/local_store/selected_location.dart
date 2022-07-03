import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_weather/models/positionstack_api/positionstack_location_normalize.dart';

const selectedLocationKey = 'SELECTED_LOCATION';

class LocalStoreSelectedLocation {
  // Save selected location
  void save(PositionstackLocationNormalize selectedLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      selectedLocationKey,
      json.encode(selectedLocation.toJson()),
    );
  }

  // Get selected location
  Future<PositionstackLocationNormalize?> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSelectedLocation = prefs.getString(selectedLocationKey);
    return jsonSelectedLocation != null
        ? PositionstackLocationNormalize.fromJson(json.decode(jsonSelectedLocation))
        : null;
  }

  // Remove selected location
  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(selectedLocationKey);
  }
}
