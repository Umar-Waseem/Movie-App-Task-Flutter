// ignore_for_file: constant_identifier_names

import "package:flutter_dotenv/flutter_dotenv.dart";

// get apiKey from .env file
String apiKey = dotenv.env['apiKey']!;

enum EndPoint { MOVIE_SEARCH, MOVIE_GENRES, MOVIE_UPCOMING, MOVIE_TRAILER }

String baseUrl(List<String> query, EndPoint endPoint) {
  String url = "https://api.themoviedb.org";
  switch (endPoint) {
    case EndPoint.MOVIE_SEARCH:
      url += "/3/search/movie";
      Map<String, String> parameters = {
        "?api_key=": apiKey,
        "&language=": "en-US",
        "&query=": query[0],
        "&page=": "1",
        "&include_adult=": "false",
      };

      parameters.forEach((key, value) {
        url += key + value;
      });
      break;
    case EndPoint.MOVIE_GENRES:
      url += "/3/genre/movie/list";
      Map<String, String> parameters = {
        "?api_key=": apiKey,
        "&language=": "en-US",
      };

      parameters.forEach((key, value) {
        url += key + value;
      });
      break;
    case EndPoint.MOVIE_UPCOMING:
      url += "/3/movie/upcoming";
      Map<String, String> parameters = {
        "?api_key=": apiKey,
        "&language=": "en-US",
        "&page=": "1",
      };

      parameters.forEach((key, value) {
        url += key + value;
      });
      break;
    case EndPoint.MOVIE_TRAILER:
      url += "/3/movie/${query[0]}/videos";
      Map<String, String> parameters = {
        "?api_key=": apiKey,
        "&language=": "en-US",
      };

      parameters.forEach((key, value) {
        url += key + value;
      });
      break;
  }

  print("returning url: $url");

  return url;
}
