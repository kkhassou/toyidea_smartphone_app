import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> testCallApi() async {
  final String apiUrl =
      'https://us-central1-toyidea-api.cloudfunctions.net/api/getWorkPatterns';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // 成功した場合、レスポンスを解析または使用します。
      print('Response data: ${response.body}');
      // JSON データの場合
      // Map<String, dynamic> jsonData = jsonDecode(response.body);
    } else {
      // エラーの場合
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 例外が発生した場合
    print('Request failed with error: $e');
  }
}

Future<void> s_r_u_input_api() async {
  final String apiUrl =
      // "https://us-central1-toyidea-api.cloudfunctions.net/api/skyRainUmbrellaInput";
      "http://10.0.2.2:5001/toyidea-api/us-central1/api/skyRainUmbrellaInput";
  // ios     : localhost または 127.0.0.1
  // android : 10.0.2.2

  try {
    // final response = await http.post(Uri.parse(apiUrl), body: "test_kake");
    // final response = await http.post(Uri.parse(apiUrl));
    final response = await http.post(Uri.parse(apiUrl), body: "data");
    if (response.statusCode == 200) {
      // 成功した場合、レスポンスを解析または使用します。
      print('Response data: ${response.body}');
      // JSON データの場合
      // Map<String, dynamic> jsonData = jsonDecode(response.body);
    } else {
      // エラーの場合
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 例外が発生した場合
    print('Request failed with error: $e');
  }
}
