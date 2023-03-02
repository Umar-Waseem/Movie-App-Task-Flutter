import 'package:flutter/material.dart';
import 'package:movie_app_task/api/api_service.dart';
import 'package:movie_app_task/models/movie_model.dart';
import 'package:movie_app_task/widgets/movie_title_widget.dart';

import '../constants/image_constants.dart';
import '../models/response_model.dart';

class MovieProvider with ChangeNotifier {
  List<MovieTitleWidget> moviesToShowList = [
    MovieTitleWidget(
      movieImage: freeGuyMovie,
      movieTitle: "Free Guy",
      onPress: () {},
    ),
    MovieTitleWidget(
      movieImage: freeGuyMovie,
      movieTitle: "Free Guy",
      onPress: () {},
    ),
    MovieTitleWidget(
      movieImage: freeGuyMovie,
      movieTitle: "Free Guy",
      onPress: () {},
    ),
  ];

  List<MovieTitleWidget> get allMovies => moviesToShowList;

  List<MovieTitleWidget> _searchedMoviesWidgetsList = [];

  List<MovieTitleWidget> get searchedMovies => _searchedMoviesWidgetsList;

  void searchMovies(String query) async {
    ApiResponse? response =
        await ApiService.executeRequest(query, RequestType.GET);

    print("Results: ${response!.body["results"]}");

    List<MovieModel> movieModelsList =
        MovieModel.toList(response.body["results"]);

    _searchedMoviesWidgetsList = movieModelsList
        .map(
          (movie) => MovieTitleWidget(
            movieImage: movie.backdrop_path,
            movieTitle: movie.original_title,
            onPress: () {},
          ),
        )
        .toList();

    moviesToShowList = _searchedMoviesWidgetsList;

    notifyListeners();
  }

  void clearSearch() {
    moviesToShowList = [];
    notifyListeners();
  }
}
