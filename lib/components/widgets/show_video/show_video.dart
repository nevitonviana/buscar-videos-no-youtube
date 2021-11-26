import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowVideo {
  view({
    required BuildContext context,
    required YoutubePlayerController youtubePlayerController,
  }) {
    showDialog(
      context: context,
      builder: (context) => YoutubePlayer(
        controller: youtubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.purple,
      ),
    );
  }
}
