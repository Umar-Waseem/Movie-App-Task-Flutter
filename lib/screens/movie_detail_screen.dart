import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_task/providers/movie_provider.dart';
import 'package:movie_app_task/themes/colors.dart';
import 'package:movie_app_task/utils/widget_extensions.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/movie_model.dart';

import '../utils/utility_extensions.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late String videoId;
  String videoBaseUrl = "";
  YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: '',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );
  // VideoPlayerController.network(videoBaseUrl);

  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    if (movieProvider.genreChips.isNotEmpty) {
      movieProvider.genreChips.clear();
    }
    movieProvider.getMovieGenres(widget.movie);
  }

  void showTrailer() async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    videoId = await movieProvider.getMovieTrailer(widget.movie.id);
    videoBaseUrl = 'https://www.youtube.com/watch?v=$videoId';

    if (videoBaseUrl.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Trailer Not Available',
        backgroundColor: Colors.red,
      );
      return;
    }

    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    setState(() {
      showVideo = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool showVideo = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                ? Stack(
                    children: [
                      YoutubePlayer(
                        controller: controller,
                        aspectRatio: 0.6,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showVideo = false;
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  )
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      if (widget.movie.poster_path!.isNotEmpty)
                        CachedNetworkImage(
                          imageUrl: baseImageUrl + widget.movie.poster_path!,
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            print(error);
                            return const SizedBox.shrink();
                          },
                        ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: screenHeight * 0.6,
                          width: screenWidth,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "In Theaters ${widget.movie.release_date?.toMonthDayYear}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            20.ph,
                            SizedBox(
                              width: 260,
                              child: CupertinoButton(
                                onPressed: () {
                                  context.pushNamed(
                                    '/ticketsBooking',
                                    extra: widget.movie,
                                  );
                                },
                                color: kLightBlue,
                                pressedOpacity: 0.8,
                                borderRadius: BorderRadius.circular(10),
                                child: const Text("Get Tickets"),
                              ),
                            ),
                            20.ph,
                            Container(
                              width: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: kLightBlue),
                              ),
                              child: CupertinoButton(
                                onPressed: () {
                                  showTrailer();
                                },
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.play_arrow),
                                    5.pw,
                                    const Text("Watch Trailer"),
                                  ],
                                ),
                              ),
                            ),
                            40.ph,
                          ],
                        ),
                      ),
                    ],
                  ),
            Column(
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
                  widget.movie.overview ?? "",
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ).paddingAll(20),
          ],
        ),
      ),
    );
  }
}
