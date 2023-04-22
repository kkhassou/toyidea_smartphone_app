import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/url_constant.dart';

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

// グループネーム、コードを追加するAPI
Future<void> group_member_list_input_api(
    String _userId, String _userName, String _code) async {
  final String apiUrl = UrlConstant.apiUrl + "groupMemberListInput";

  try {
    final response = await http.post(Uri.parse(apiUrl), body: {
      "userId": _userId,
      "userName": _userName,
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

// in userId email nickname
Future<void> insert_user_info_api(
    String _userId, String _email, String _nickname) async {
  final String apiUrl = UrlConstant.apiUrl + "insertUserInfo";

  try {
    final response = await http.post(Uri.parse(apiUrl),
        body: {"userId": _userId, "nickname": _nickname, "email": _email});
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
      return jsonData
          .map((item) => {
                "name": item["name"],
                "code": item["code"],
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

// user情報取得
// in userId
// out nickname
Future<List<Map<String, dynamic>>> get_user_info_api(String _userId) async {
  final String apiUrl = UrlConstant.apiUrl + "getUserInfo";

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
