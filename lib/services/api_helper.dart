import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String _baseUrl = "http://newsapi.org/v2/";

  Future<dynamic> get(String endPoint) async {
    var responseJson;
    try {
      print("$_baseUrl$endPoint");
      final response = await http.get(_baseUrl + endPoint);
      responseJson = _responseChecker(response);
      debugPrint("$endPoint API $response $responseJson");
    } catch (error) {
      throw error;
    }
    return responseJson;
  }

  dynamic _responseChecker(response) {
    print("RES ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        return responseJson;
      case 400:
        throw response;
      case 401:
        throw response;
      case 403:
        throw response;
      case 426:
        throw response;
      case 500:
        throw response;
      default:
        throw response;
    }
  }
}
