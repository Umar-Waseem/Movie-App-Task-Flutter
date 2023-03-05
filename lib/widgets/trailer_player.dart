import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app_task/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/connection.dart';

class TrailerPlayer extends StatefulWidget {
  const TrailerPlayer({super.key, required this.trailerId});

  final String trailerId;

  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  // VideoPlayerController.network(videoBaseUrl);

  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    if (movieProvider.genreChips.isNotEmpty) {
      movieProvider.genreChips.clear();
    }
    initializeTrailer();
  }

  YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: '',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  void initializeTrailer() async {

      String videoId = widget.trailerId;
      String videoBaseUrl = "https://www.youtube.com/watch?v=$videoId";

      if (videoId.isEmpty) {
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
    
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool showVideo = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
