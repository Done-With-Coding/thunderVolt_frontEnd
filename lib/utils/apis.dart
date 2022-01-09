const baseUrl = "http://10.0.2.2:4000/";

class Apis {
  static Uri findNearbyStation =
      Uri.parse(baseUrl + 'station/findNearbyStation');

  static Uri findCurrentBooking =
      Uri.parse(baseUrl + 'booking/getBookingHistory');

  static Uri findQueryurl(String city) =>
      Uri.https("https://atlas.microsoft.com", "/search/address/json", {
        "key": "U_UjmieaWHcBzrgRbM5WCJLFrRgOSGZ3jem9UzIQXY0",
        "api-version": "1.0",
        "query": city,
        "typeahead": "true",
        // "limit": "3",
        "countrySet": "IN",
        "view": "IN"
      });

  static Uri getPolylines = Uri.parse(baseUrl + "route/planRoute");
}
