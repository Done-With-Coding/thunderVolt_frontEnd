import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:thundervolt/models/models.dart';
import 'package:thundervolt/utils/apis.dart';
import 'package:thundervolt/views/journey/polylineMap.dart';

class MapService {
  static Future<dynamic> getMapLocationList(
      {required double lat, required double lng}) async {
    try {
      var response = await http.Client().post(Apis.findNearbyStation,
          headers: {
            "Content-Type": 'application/json',
          },
          body: jsonEncode({
            'lat': lat.toString(),
            'long': lng.toString(),
          }));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(data);
        return data;
      } else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future launchUrl(url) async {
    try {
      launchUrl(url);
    } catch (e) {
      print(e);
    }
  }

  static Future getRouteData({
    required String destination,
    required String departedAt,
    required String origin,
    required String range,
    required BuildContext context,
  }) async {
    List<LocationModel> polyLocationList = [];

    final res = await http.Client().post(Apis.getPolylines,
        headers: {
          "Content-Type": 'application/json',
        },
        body: jsonEncode({
          'destination': destination,
          'departAt': departedAt,
          'origin': origin,
          'range': range,
        }));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      print(res.body);

      final legs = data['result']['routes'][0]['legs'];
      List<MapLatLng> points = [];
      (legs as List).forEach((element) {
        (element['points'] as List).forEach((e) {
          points.add(MapLatLng(double.tryParse(e['latitude'].toString()) ?? 0,
              double.tryParse(e['longitude'].toString()) ?? 0));
        });
      });

      data["stationArray"].forEach((element) {
        polyLocationList.add(LocationModel.fromJson(element));
      });

      print("Station array");
      print(data["stationArray"][0]["latitude"]);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => PolyLineMap(
                points: points,
                polyLocation: polyLocationList,
              )));
    }
  }
}
