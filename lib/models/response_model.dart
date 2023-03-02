import 'dart:convert';

class ApiResponse {
  final int? status;
  final dynamic body;
  final String url;
  final dynamic parameters;

  ApiResponse(
      {required this.status,
      required this.body,
      required this.url,
      this.parameters});

  @override
  String toString() {
    return 'Response: [$url][$parameters][$status][$body]';
  }
}
