import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thundervolt/utils/apis.dart';

class BookingService {
  static Future getCurrentBookings(String phone) async {
    try {
      var response = await http.Client().post(Apis.findCurrentBooking,
          headers: {
            "Content-Type": 'application/json',
          },
          body: jsonEncode({"mobile_no": phone}));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        print("Booking data: $data");
        return data;
      }
    } catch (e) {
      print("Error while getting current booking history: $e");
    }
  }
}
