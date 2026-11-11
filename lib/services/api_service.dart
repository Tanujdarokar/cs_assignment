import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_session.dart';

class ApiService {
  static const String baseUrl = 'https://mock-api.calleyacd.com/api';

  // 1. Register User
  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    final data = _parseResponse(response);
    UserSession.instance.setUser(
      username: username,
      email: email,
      userId: data['userId'] ?? data['_id'] ?? data['id'],
    );
    return data;
  }

  // 2. Send OTP
  static Future<Map<String, dynamic>> sendOtp({
    required String email,
  }) async {
    final url = Uri.parse('$baseUrl/auth/send-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
      }),
    );

    return _parseResponse(response);
  }

  // 3. Verify OTP
  static Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/auth/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'otp': otp,
      }),
    );

    final data = _parseResponse(response);
    if (data['token'] != null) {
      UserSession.instance.token = data['token'];
    }
    return data;
  }

  // 4. Login User
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = _parseResponse(response);
    UserSession.instance.setUser(
      email: email,
      userId: data['userId'] ?? data['_id'] ?? data['user']?['_id'] ?? data['user']?['id'],
      token: data['token'],
    );
    return data;
  }

  // 5. Get Calling Lists
  static Future<List<dynamic>> getCallingLists({
    String? userId,
    String? email,
  }) async {
    final effectiveUserId = userId ?? UserSession.instance.userId ?? '68626f9497757cb741f449b0';
    final effectiveEmail = email ?? UserSession.instance.email ?? 'dhrubo@yopmail.com';

    final url = Uri.parse('$baseUrl/list?userId=$effectiveUserId');

    final request = http.Request('GET', url)
      ..headers.addAll({'Content-Type': 'application/json'})
      ..body = jsonEncode({'email': effectiveEmail});

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final data = _parseResponse(response);
    if (data is List) {
      UserSession.instance.userLists = data;
      return data;
    } else if (data is Map && data.containsKey('lists')) {
      final listData = data['lists'] as List;
      UserSession.instance.userLists = listData;
      return listData;
    } else if (data is Map && data.containsKey('data')) {
      final listData = data['data'] as List;
      UserSession.instance.userLists = listData;
      return listData;
    }
    return [data];
  }

  // 6. Get List Details
  static Future<Map<String, dynamic>> getListDetails({
    required String listId,
    String? email,
  }) async {
    final effectiveEmail = email ?? UserSession.instance.email ?? 'dhrubo@yopmail.com';
    final url = Uri.parse('$baseUrl/list/$listId');

    final request = http.Request('GET', url)
      ..headers.addAll({'Content-Type': 'application/json'})
      ..body = jsonEncode({'email': effectiveEmail});

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final data = _parseResponse(response);
    if (data is Map<String, dynamic>) {
      UserSession.instance.selectedListDetails = data;
      return data;
    }
    return {'data': data};
  }

  // Helper parser
  static dynamic _parseResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      try {
        return jsonDecode(response.body);
      } catch (e) {
        return {'message': response.body};
      }
    } else {
      String errorMessage = 'Request failed with status code ${response.statusCode}';
      try {
        final body = jsonDecode(response.body);
        if (body is Map && body.containsKey('message')) {
          errorMessage = body['message'];
        } else if (body is Map && body.containsKey('error')) {
          errorMessage = body['error'];
        }
      } catch (_) {}
      throw Exception(errorMessage);
    }
  }
}
