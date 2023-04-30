import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/url_constant.dart';

// グループネーム、コードを追加するAPI
Future<void> group_list_input_api(
    String _userId, String _name, String _code) async {
  final String apiUrl = UrlConstant.apiUrl + "groupListInput";

  try {
    final response = await http.post(Uri.parse(apiUrl), body: {
      "userId": _userId,
      "name": _name,
      "code": _code,
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

Future<List<Map<String, dynamic>>> belong_group_list_api(String _userId) async {
  final String apiUrl = UrlConstant.apiUrl + "belongGroupList";

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "userId": _userId,
      },
    );
    if (response.statusCode == 200) {
      // 成功した場合、レスポンスを解析または使用します。
      print('Response data: ${response.body.toString()}');
      // JSON データの場合
      List jsonData = jsonDecode(response.body);
      print("jsonData");
      print(jsonData.toString());
      // 重複削除
      Set names = jsonData.map((item) => item["name"]).toSet();
      List<Map<String, dynamic>> distinctList = names
          .map((name) => {
                "name": name,
                "code":
                    jsonData.firstWhere((item) => item["name"] == name)["code"]
              })
          .toList();
      return distinctList;
    } else {
      // エラーの場合
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 例外が発生した場合
    throw Exception('Request failed with error: $e');
  }
  // 上記で、groupListから本人が作った場合の取得
}
