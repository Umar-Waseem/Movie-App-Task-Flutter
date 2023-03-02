import 'package:flutter/material.dart';
import 'package:movie_app_task/utils/widget_extensions.dart';

class MovieTitleWidget extends StatelessWidget {
  const MovieTitleWidget(
      {Key? key,
      required this.movieImage,
      required this.movieTitle,
      this.onPress})
      : super(key: key);

  final String movieImage;
  final String movieTitle;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        height: screenHeight * 0.22,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(movieImage),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image.asset(
            //   movieImage,
            //   fit: BoxFit.contain,
            // ),
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
              child: Text(
                movieTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingOnly(20),
            ),
          ],
        ),
      ),
    );
  }
}
