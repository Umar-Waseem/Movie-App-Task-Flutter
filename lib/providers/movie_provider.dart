import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app_task/api/api_service.dart';
import 'package:movie_app_task/constants/api_constants.dart';
import 'package:movie_app_task/models/movie_model.dart';
import 'package:movie_app_task/storage/dao.dart';
import 'package:movie_app_task/utils/connection.dart';
import 'package:movie_app_task/widgets/movie_title_widget.dart';

import '../models/response_model.dart';

import 'dart:math' as math;

import '../storage/local_db.dart';

class MovieProvider with ChangeNotifier {
  bool loading = false;

  List<MovieTitleWidget> moviesToShowList = [];
  List<MovieTitleWidget> _searchedMoviesWidgetsList = [];
  List<MovieTitleWidget> get searchedMovies => _searchedMoviesWidgetsList;

  void searchMovies(String query) async {
    if (ConnectionUtility.connected) {
      loading = true;

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

      loading = false;

      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Internet required to search movies");
    }
  }

  List<Chip> genreChips = [];

  Future<List<Chip>> getMovieGenres(MovieModel movieModel) async {
    List<String>? genres = [];
    genreChips = [];
    if (ConnectionUtility.connected) {
      int index = moviesToShowList.indexWhere(
        (movie) => movie.movie.original_title == movieModel.original_title,
      );

      for (var genre in movieModel.genre_ids) {
        genres.add(genre.toString());
      }

      ApiResponse? response = await ApiService.executeRequest(
          [...genres], RequestType.GET, EndPoint.MOVIE_GENRES);
      print("Genres: ${response!.body["genres"]}");

      for (var genre in response.body["genres"]) {
        if (movieModel.genre_ids.contains(genre["id"])) {
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
    }

    return genreChips;
  }

  Future<void> getUpcomingMovies() async {
    loading = true;
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

    loading = false;
    notifyListeners();
  }

  Future<String> getMovieTrailer(String id) async {
    if (ConnectionUtility.connected) {
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
    return "";
  }

  void saveMoviesToDb() async {
    print("Inside save function");
    final database =
        await $FloorLocalDatabase.databaseBuilder('moviesDatabase.db').build();
    final movieDao = database.movieDao;

    for (var movie in moviesToShowList) {
      print("Checking ${movie.movie.original_title}");
      MovieDatabaseModel? movieModel =
          await movieDao.findMovieById(int.parse(movie.movie.id));

      if (movieModel == null) {
        log("${movie.movie.original_title} saved to database");

        MovieDatabaseModel movieDatabaseModel = MovieDatabaseModel(
          id: int.parse(movie.movie.id),
          original_title: movie.movie.original_title,
          backdrop_path: movie.movie.backdrop_path,
          poster_path: movie.movie.poster_path,
          overview: movie.movie.overview,
          release_date: movie.movie.release_date,
        );

        await movieDao.insertMovie(movieDatabaseModel);
      } else {
        log("${movie.movie.original_title} already saved to database");
      }
    }

    notifyListeners();
  }

  void getMoviesFromDb() async {
    final database =
        await $FloorLocalDatabase.databaseBuilder('moviesDatabase.db').build();
    final movieDao = database.movieDao;

    List<MovieDatabaseModel> movies = await movieDao.findAllMovies();

    moviesToShowList = movies.map(
      (movie) {
        print("Found ${movie.original_title} from db");
        return MovieTitleWidget(
          movie: MovieModel(
            original_title: movie.original_title,
            backdrop_path: movie.backdrop_path,
            release_date: movie.release_date,
            overview: movie.overview,
            poster_path: movie.poster_path,
            id: movie.id.toString(),
            genre_ids: [],
          ),
        );
      },
    ).toList();

    notifyListeners();
  }

  void getMovies() {
    print(ConnectionUtility.connected);
    if (!ConnectionUtility.connected) {
      log("Fetching from local DB");
      getMoviesFromDb();
    } else {
      log("Fetching from api");
      getUpcomingMovies().then((value) => saveMoviesToDb());
    }
  }

  void clearSearch() {
    getUpcomingMovies();
    notifyListeners();
  }
}
