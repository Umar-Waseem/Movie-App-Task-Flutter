import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/themes/colors.dart';
import 'package:movie_app_task/utils/widget_extensions.dart';

import '../models/movie_model.dart';

import '../utils/utility_extensions.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CachedNetworkImage(
                  imageUrl: baseImageUrl + widget.movie.poster_path!,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Chip(
                      label: Text("Action"),
                      backgroundColor: Colors.red,
                    ),
                    Chip(
                      label: Text("Thriller"),
                      backgroundColor: Colors.blue,
                    ),
                    Chip(
                      label: Text("Science"),
                      backgroundColor: Colors.green,
                    ),
                    Chip(
                      label: Text("Fiction"),
                      backgroundColor: Colors.yellow,
                    ),
                  ],
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
