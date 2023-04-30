import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/url_constant.dart';

// グループネーム、コードを追加するAPI
Future<void> group_member_list_input_api(
    String _userId, String _userName, String _code, String _email) async {
  final String apiUrl = UrlConstant.apiUrl + "groupMemberListInput";

  try {
    final response = await http.post(Uri.parse(apiUrl), body: {
      "userId": _userId,
      "userName": _userName,
      "code": _code,
      "email": _email,
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

Future<List<Map<String, dynamic>>> get_group_member_list(String _code) async {
  final String apiUrl = UrlConstant.apiUrl + "getGroupMemberList";

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "code": _code,
      },
    );
    if (response.statusCode == 200) {
      // 成功した場合、レスポンスを解析または使用します。
      print('Response data: ${response.body.toString()}');
      // JSON データの場合
      List jsonData = jsonDecode(response.body);
      print("jsonData");
      print(jsonData.toString());
      // const nicknameArr = jsonData.map(item => item.app_user.nickname);
      // 重複削除
      List<Map<String, dynamic>> list = jsonData
          .map((item) => {
                "nickname": item["app_user"]["nickname"],
              })
          .toList();
      return list;
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
