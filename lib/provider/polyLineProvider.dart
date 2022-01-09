// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
// import 'package:thundervolt/models/models.dart';
// import 'package:thundervolt/services/journeyService.dart';
// import 'package:thundervolt/services/mapService.dart';
// import 'package:thundervolt/views/journey/journey.dart';

// class PolyProvider extends ChangeNotifier {
//   List<LocationModel> _polyMarkersList = [];

//   List<LocationModel> get polyMarkerLocationList => _polyMarkersList;

//   Future getRouteList({
//     String? destiantion,
//     String? departedAt,
//     String? origin,
//     String? range,
//     BuildContext? context,
//   }) async {
//     try {
//       final res = await MapService.getRouteData(
//           destination: destiantion!,
//           departedAt: departedAt!,
//           origin: origin!,
//           range: range!,
//           context: context!);

//       if (res != null) {
//         _polyMarkersList.clear();
//         final locationData = res["rows"];
//         locationData.forEach((element) {
//           _polyMarkersList.add(LocationModel.fromJson(element));
//         });
//       } else
//         return false;
//     } catch (e) {
//       print(e.toString());
//       throw e.toString();
//     } finally {
//       notifyListeners();
//     }
//   }
// }
