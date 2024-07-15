import 'package:fake_api_app/core/network/app_url.dart';
import 'package:http/http.dart' as http;

class HttpWrapper {
  static Future<http.Response> getRequest(String val) async {
    try {
      final url = Uri.parse(val);
      final res = await http.get(url);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
