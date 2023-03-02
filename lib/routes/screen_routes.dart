import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/movie_model.dart';
import '../screens/movie_detail_screen.dart';
import '../screens/starting_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: '/',
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: StartingScreen(),
      ),
    ),
    GoRoute(
      name: '/movieDetail',
      path: '/movieDetail',
      pageBuilder: (context, state) => MaterialPage(
        child: MovieDetailScreen(
          movie: state.extra as MovieModel,
          // imageUrl: state.params["backdrop_path"].toString(),
          // overview: state.params["overview"].toString(),
          // release_date: state.params["release_date"].toString(),
        ),
      ),
    ),
  ],
);
