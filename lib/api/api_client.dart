import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> callApi() async {
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
