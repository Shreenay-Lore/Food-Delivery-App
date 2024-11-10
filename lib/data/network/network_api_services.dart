import 'dart:convert';

import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final box = GetStorage();

  Future<http.Response> getRequest(String endpoint) async {
    String accessToken = box.read('token');
    Uri url = Uri.parse('${AppUrl.baseUrl}$endpoint');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      print('Making request to: $url');
      var response = await http.get(url, headers: headers);
      return response;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }

  Future<http.Response> postRequest({required String endpoint, required String body}) async {
    String accessToken = box.read('token');
    Uri url = Uri.parse('${AppUrl.baseUrl}$endpoint');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      print('Making request to: $url');
      var response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      throw Exception('Failed to make POST request: $e');
    }
  }

  Future<http.Response> putRequest(String endpoint, Map<String, dynamic> body) async {
    String accessToken = box.read('token');
    Uri url = Uri.parse('${AppUrl.baseUrl}$endpoint');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      var response = await http.put(url, headers: headers, body: jsonEncode(body));
      return response;
    } catch (e) {
      throw Exception('Failed to make PUT request: $e');
    }
  }

  Future<http.Response> patchRequest(String endpoint) async {
    String accessToken = box.read('token');
    Uri url = Uri.parse('${AppUrl.baseUrl}$endpoint');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      print('Making request to: $url');
      var response = await http.patch(url, headers: headers);
      return response;
    } catch (e) {
      throw Exception('Failed to make PATCH request: $e');
    }
  }

  Future<http.Response> deleteRequest(String endpoint, [Map<String, dynamic>? body]) async {
    String accessToken = box.read('token');
    Uri url = Uri.parse('${AppUrl.baseUrl}$endpoint');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      var response = body != null
          ? await http.delete(url, headers: headers, body: jsonEncode(body))
          : await http.delete(url, headers: headers);
      return response;
    } catch (e) {
      throw Exception('Failed to make DELETE request: $e');
    }
  }
}
