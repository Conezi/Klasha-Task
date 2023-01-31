import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../handlers/request_handler.dart';
import '../../res/app_strings.dart';
import 'exceptions.dart';

class HttpHelper {
  HttpHelper._();
  static final _instance = HttpHelper._();
  static HttpHelper get instance => _instance;

  Future<dynamic> get(String route, {Map<String, String>? headers}) async {
    late dynamic map;
    debugPrint(route);
    final client = RetryClient(http.Client());
    try {
      await client.get(Uri.parse(route),
          headers: headers ?? {'Content-Type': 'application/json'})
          .then((response) {
        map = json.decode(RequestHandler.handleServerError(response));

      });
    } on SocketException {
      throw NetworkException(AppStrings.networkErrorMessage);
    } on HandshakeException {
      throw NetworkException(AppStrings.networkErrorMessage);
    } on FormatException catch (e) {
      throw NetworkException(e.toString());
    } finally {
      client.close();
    }
    return map;
  }

}
