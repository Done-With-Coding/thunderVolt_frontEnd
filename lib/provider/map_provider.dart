import 'package:flutter/foundation.dart';
import 'package:thundervolt/models/models.dart';
import 'package:thundervolt/services/mapService.dart';

class MapProvider extends ChangeNotifier {
  List<LocationModel> _locationList = [];
  bool _isFetching = false;
  List<LocationModel> get locationList => _locationList;
  bool get isFetching => _isFetching;

  Future getMapLocationList({required double lat, required double long}) async {
    try {
      _isFetching = true;
      final res = await MapService.getMapLocationList(lat: lat, lng: long);

      if (res != null) {
        _locationList.clear();
        final locationData = res["rows"];
        locationData.forEach((element) {
          _locationList.add(LocationModel.fromJson(element));
        });
      } else
        return false;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future navigateToGoogleMaps(
      {required double sourceLat,
      required double sourcelong,
      required double destlat,
      required double destlong}) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&origin=${sourceLat.toString()},${sourcelong.toString()}&destination=${destlat.toString()},${destlong.toString()}&travelmode=car&dir_action=navigate';

    try {
      await MapService.launchUrl(url);
    } catch (e) {
      print("Error while getting map url");
      print(e);
    }
  }
}
