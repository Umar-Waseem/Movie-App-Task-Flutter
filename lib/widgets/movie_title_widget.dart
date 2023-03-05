import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_task/utils/connection.dart';
import 'package:movie_app_task/utils/widget_extensions.dart';

import '../models/movie_model.dart';

class MovieTitleWidget extends StatelessWidget {
  const MovieTitleWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          '/movieDetail',
          extra: movie,
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: screenHeight * 0.22,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: ConnectionUtility.connected
              ? movie.backdrop_path!.isNotEmpty
                  ? Colors.transparent
                  : Colors.grey
              : Colors.grey,
          image: ConnectionUtility.connected
              ? movie.backdrop_path!.isNotEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(baseImageUrl + movie.backdrop_path!),
                    )
                  : null
              : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (movie.backdrop_path!.isNotEmpty && ConnectionUtility.connected)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.8,
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
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: 300,
                child: Text(
                  movie.original_title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ).paddingOnly(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
