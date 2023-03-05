import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_task/utils/connection.dart';
import 'package:movie_app_task/utils/utility_extensions.dart';
import 'package:movie_app_task/utils/widget_extensions.dart';

import '../models/movie_model.dart';
import '../themes/colors.dart';

class MoviePosterDisplay extends StatelessWidget {
  const MoviePosterDisplay(
      {Key? key, required this.movie, required this.showTrailer})
      : super(key: key);

  final MovieModel movie;
  final Function showTrailer;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (ConnectionUtility.connected)
          if (movie.poster_path!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: baseImageUrl + movie.poster_path!,
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
                "In Theaters ${movie.release_date?.toMonthDayYear}",
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
                      extra: movie,
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
    );
  }
}
