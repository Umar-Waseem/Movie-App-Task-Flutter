import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app_task/models/response_model.dart';

import '../constants/api_constants.dart';

enum RequestType {
  GET,
  POST,
}

class ApiService {
  static Future<ApiResponse?> executeRequest(
    List<String> searchQuery,
    RequestType requestType,
    EndPoint endPoint, {
    dynamic data,
  }) async {
    ApiResponse? response;
    Dio dio = Dio();
    Response result;

    try {
      switch (requestType) {
        case RequestType.GET:
          log("Get request on: ${baseUrl([...searchQuery], endPoint)}");
          result = await dio.get(baseUrl([...searchQuery], endPoint));
          response = ApiResponse(
            status: result.statusCode,
            body: result.data,
            url: baseUrl([...searchQuery], endPoint),
          );
          break;
        case RequestType.POST:
          result = await dio.post(baseUrl([...searchQuery], endPoint), data: jsonEncode(data));
          response = ApiResponse(
            status: result.statusCode,
            body: result.data,
            url: baseUrl([...searchQuery], endPoint).toString(),
          );
          break;
        default:
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }

    return response;
  }
}
