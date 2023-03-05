import 'package:flutter/material.dart';
import 'package:movie_app_task/utils/widget_extensions.dart';
import 'package:provider/provider.dart';

import '../models/movie_model.dart';
import '../providers/movie_provider.dart';

class MovieOverview extends StatelessWidget {
  const MovieOverview({Key? key, required this.movie}) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.ph,
        const Text(
          "Genres",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        16.ph,
        Consumer<MovieProvider>(
          builder: (context, movieProvider, child) => Wrap(
            spacing: 10,
            children: movieProvider.genreChips,
          ),
        ),
        30.ph,
        const Text(
          "Overview",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        10.ph,
        Text(
          movie.overview ?? "",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    ).paddingAll(20);
  }
}
