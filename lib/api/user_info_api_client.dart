import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/url_constant.dart';

// in userId email nickname
Future<void> insert_user_info_api(
    // String _userId,
    String _email,
    String _nickname) async {
  final String apiUrl = UrlConstant.apiUrl + "insertUserInfo";

  try {
    final response = await http.post(Uri.parse(apiUrl), body: {
      // "userId": _userId,
      "nickname": _nickname, "email": _email
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

// user情報取得
// in email
// out nickname
Future<List<Map<String, dynamic>>> get_user_nickname_api(String _email) async {
  final String apiUrl = UrlConstant.apiUrl + "getUserNickname";

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "email": _email,
      },
    );
    if (response.statusCode == 200) {
      // 成功した場合、レスポンスを解析または使用します。
      print('Response data: ${response.body.toString()}');
      // JSON データの場合
      List jsonData = jsonDecode(response.body);
      print("jsonData");
      print(jsonData.toString());
      return jsonData
          .map((item) => {
                "nickname": item["nickname"],
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
  // 上記で、groupListから本人が作った場合の取得
}
