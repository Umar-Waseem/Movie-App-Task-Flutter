import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app_task/models/response_model.dart';

enum RequestType {
  GET,
  POST,
}

const baseUrl = "";

class ApiService {
  static Future<ApiResponse?> executeRequest(
    String endPoint,
    RequestType requestType, {
    dynamic data,
  }) async {
    ApiResponse? response;
    Dio dio = Dio();
    Uri requestUrl = Uri.parse(baseUrl + endPoint);
    Response result;

    try {
      switch (requestType) {
        case RequestType.GET:
          result = await dio.get(requestUrl.toString());
          response = ApiResponse(
            status: result.statusCode,
            body: result.data,
            url: requestUrl.toString(),
          );
          break;
        case RequestType.POST:
          result = await dio.post(requestUrl.toString(), data: data);
          response = ApiResponse(
            status: result.statusCode,
            body: result.data,
            url: requestUrl.toString(),
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
