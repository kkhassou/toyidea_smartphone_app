import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/url_constant.dart';

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

Future<void> s_r_u_input_api(String _userId, String _trigger, String _sky,
    String _rain, String _umbrella) async {
  final String apiUrl = UrlConstant.apiUrl + "skyRainUmbrellaInput";

  try {
    final response = await http.post(Uri.parse(apiUrl), body: {
      "userId": _userId,
      "trigger": _trigger,
      "sky": _sky,
      "rain": _rain,
      "umbrella": _umbrella
    });
    if (response.statusCode == 200) {
      // 成功した場合、レスポンスを解析または使用します。
      print('Response data: ${response.body.toString()}');
      // JSON データの場合
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      print("jsonData");
      print(jsonData.toString());
    } else {
      // エラーの場合
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 例外が発生した場合
    print('Request failed with error: $e');
  }
}

// in userId
// out list(sky,rain,umbrella)
Future<List<Map<String, dynamic>>> s_r_u_list_api(String _userId) async {
  final String apiUrl = UrlConstant.apiUrl + "skyRainUmbrellaList";

  try {
    final response = await http.post(Uri.parse(apiUrl), body: {
      "userId": _userId,
    });
    if (response.statusCode == 200) {
      // 成功した場合、レスポンスを解析または使用します。
      print('Response data: ${response.body.toString()}');
      // JSON データの場合
      // Map<String, dynamic>
      List jsonData = jsonDecode(response.body);
      print("jsonData");
      print(jsonData.toString());
      return jsonData
          .map((item) => {
                "trigger": item["trigger"],
                "sky": item["sky"],
                "rain": item["rain"],
                "umbrella": item["umbrella"],
              })
          .toList()
          .cast<Map<String, dynamic>>(); // 型変換を追加
    } else {
      // エラーの場合
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 例外が発生した場合
    throw Exception('Request failed with error: $e');
  }
}
