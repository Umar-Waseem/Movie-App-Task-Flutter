import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app_task/providers/movie_provider.dart';
import 'package:movie_app_task/utils/connection.dart';
import 'package:movie_app_task/widgets/movie_overview_widget.dart';
import 'package:provider/provider.dart';

import '../models/movie_model.dart';

import '../widgets/movie_poster_display.dart';
import '../widgets/trailer_player.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getMovieGenres(widget.movie);
  }

  bool showVideo = false;
  String videoId = "";

  void showTrailer() async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    videoId = await movieProvider.getMovieTrailer(widget.movie.id);

    setState(() {
      if (ConnectionUtility.connected) {
        showVideo = true;
      } else {
        Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: "Internet required to play trailer",
          backgroundColor: Colors.red,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          if (showVideo)
            IconButton(
              onPressed: () {
                setState(() {
                  showVideo = false;
                });
              },
              icon: const Icon(Icons.clear),
            ),
        ],
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Watch',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            showVideo
                ? TrailerPlayer(
                    trailerId: videoId,
                  )
                : MoviePosterDisplay(
                    movie: widget.movie,
                    showTrailer: showTrailer,
                  ),
            MovieOverview(movie: widget.movie),
          ],
        ),
      ),
    );
  }
}
