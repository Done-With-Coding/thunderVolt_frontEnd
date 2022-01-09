import 'package:http/http.dart' as http;
import 'package:thundervolt/utils/apis.dart';

class JourneyService {
  Future<dynamic> getQuerySearch(String query) async {
    try {
      var response = await http.Client().get(
        Apis.findQueryurl(query),
      );

      if (response.statusCode == 200) {
        print("quer");
        print(response);
        return response;
      }
    } catch (e) {
      print("Error while querying : $e");
    }
  }
}
