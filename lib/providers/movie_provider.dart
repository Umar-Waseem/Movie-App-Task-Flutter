import 'package:flutter/material.dart';
import 'package:movie_app_task/api/api_service.dart';
import 'package:movie_app_task/constants/api_constants.dart';
import 'package:movie_app_task/models/movie_model.dart';
import 'package:movie_app_task/widgets/movie_title_widget.dart';

import '../models/response_model.dart';

import 'dart:math' as math;

class MovieProvider with ChangeNotifier {
  List<MovieTitleWidget> moviesToShowList = [];

  List<MovieTitleWidget> get allMovies => moviesToShowList;

  List<MovieTitleWidget> _searchedMoviesWidgetsList = [];

  List<MovieTitleWidget> get searchedMovies => _searchedMoviesWidgetsList;

  void searchMovies(String query) async {
    ApiResponse? response = await ApiService.executeRequest(
        [query], RequestType.GET, EndPoint.MOVIE_SEARCH);

    print("Results: ${response!.body["results"]}");

    List<MovieModel> movieModelsList =
        MovieModel.toList(response.body["results"]);

    _searchedMoviesWidgetsList = movieModelsList
        .map(
          (movie) => MovieTitleWidget(
            movie: movie,
          ),
        )
        .toList();

    moviesToShowList = _searchedMoviesWidgetsList;

    notifyListeners();
  }

  List<Chip> genreChips = [];

  Future<List<Chip>> getMovieGenres(MovieModel movieModel) async {
    int index = moviesToShowList.indexWhere(
      (movie) => movie.movie.original_title == movieModel.original_title,
    );

    List<String>? genres = [];

    for (var genre in movieModel.genre_ids!) {
      genres.add(genre.toString());
    }

    ApiResponse? response = await ApiService.executeRequest(
        [...genres], RequestType.GET, EndPoint.MOVIE_GENRES);
    print("Genres: ${response!.body["genres"]}");

    for (var genre in response.body["genres"]) {
      if (movieModel.genre_ids!.contains(genre["id"])) {
        genreChips.add(
          Chip(
            label: Text(
              genre["name"],
              style: const TextStyle(color: Colors.black),
            ),
            // random color
            backgroundColor:
                Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
          ),
        );
      }
    }

    notifyListeners();

    return genreChips;
  }

  void getUpcomingMovies() async {
    ApiResponse? response = await ApiService.executeRequest(
        [], RequestType.GET, EndPoint.MOVIE_UPCOMING);

    print("Upcoming Movies: ${response!.body["results"]}");

    List<MovieModel> movieModelsList =
        MovieModel.toList(response.body["results"]);

    moviesToShowList = movieModelsList
        .map(
          (movie) => MovieTitleWidget(
            movie: movie,
          ),
        )
        .toList();

    notifyListeners();
  }

  Future<String> getMovieTrailer(String id) async {
    ApiResponse? response = await ApiService.executeRequest(
        [id], RequestType.GET, EndPoint.MOVIE_TRAILER);

    print("Trailer: ${response!.body["results"]}");

    String trailerKey = "";

    for (var item in response.body["results"]) {
      if (item["type"] == "Trailer") {
        trailerKey = item["key"];
      }
    }

    return trailerKey;
  }

  void clearSearch() {
    getUpcomingMovies();
    notifyListeners();
  }
}
