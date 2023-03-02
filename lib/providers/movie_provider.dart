import 'package:flutter/material.dart';
import 'package:movie_app_task/widgets/movie_title_widget.dart';

import '../constants/image_constants.dart';

class MovieProvider with ChangeNotifier {
  final List<MovieTitleWidget> _allMoviesWidgetsList = [
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
  List<MovieTitleWidget> get allMovies => _allMoviesWidgetsList;
}
