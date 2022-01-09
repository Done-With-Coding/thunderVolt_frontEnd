import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thundervolt/models/models.dart';
import 'package:thundervolt/services/bookingService.dart';

class BookingProvider extends ChangeNotifier {
  List<BookingModel> _CurrentBookingList = [];
  List<BookingModel> _previousBookingList = [];

  List<BookingModel> get currentBookingList => _CurrentBookingList;
  List<BookingModel> get prevousBookingList => _previousBookingList;

  bool isFetching = false;

  Future getCurrentBooking() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String phone = pref.getString("phone")!;

      var data = await BookingService.getCurrentBookings(phone);
      if (data != null) {
        _CurrentBookingList.clear();
        _previousBookingList.clear();

        if (data != null) {
          if (data["pastBooking"] != null) {
            data["pastBooking"].forEach((element) {
              _previousBookingList.add(BookingModel.fromJson(element));
            });
          }

          if (data["booking"] != null) {
            data["booking"].forEach((element) {
              _CurrentBookingList.add(BookingModel.fromJson(element));
            });
          }
        }
      }
    } catch (e) {
      print("Error while getting current bookings:$e");
    } finally {
      notifyListeners();
    }
  }

  // String getDate(String timeStamp){

  //   Da
  // }
}
