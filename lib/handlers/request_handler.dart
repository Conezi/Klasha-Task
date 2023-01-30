import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import '../requests/utils/exceptions.dart';
import 'app_handler.dart';

class RequestHandler{

  static String handleServerError(Response response){
    AppHandler.logPrint("Response status: ${response.statusCode}");
    AppHandler.logPrint("Response body: ${response.body}");
    final map=json.decode(response.body);

    switch(response.statusCode){
      case 201:
        return response.body;
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(handleApiError(map));
      case 401:
      case 403:
        throw UnauthorisedException(handleApiError(map));
      case 404:
        throw FileNotFoundException(handleApiError(map));
      case 422:
        throw AlreadyRegisteredException(handleApiError(map));
      case 500:
        throw NetworkException(response.reasonPhrase?? 'Network error');
      default:
        throw NetworkException('Network error');
    }
  }

  static Future<String> handleStreamedServerError(StreamedResponse response) async{
    List res=[];
    await response.stream.forEach((message) {
      res.add(String.fromCharCodes(message));
      debugPrint(String.fromCharCodes(message));
    });
    AppHandler.logPrint("Response status: ${response.statusCode}");
    AppHandler.logPrint("Response body: ${res.join('')}");
    final map=json.decode(res.join(''));

    switch(response.statusCode){
      case 201:
        return res.join('');
      case 200:
        return res.join('');
      case 400:
      throw BadRequestException(handleApiError(map));
      case 401:
      case 403:
      throw UnauthorisedException(handleApiError(map));
      case 404:
     throw FileNotFoundException(handleApiError(map));
      case 422:
      throw AlreadyRegisteredException(handleApiError(map));
      case 500:
        throw NetworkException(response.reasonPhrase ?? 'Network error');
      default:
        throw NetworkException('Network error');
    }
  }

  static String handleApiError(Map map){
    try{
      return map["errors"] as String;
    } catch (e){
      debugPrint(e.toString());
      return map.toString();
    }
  }

}