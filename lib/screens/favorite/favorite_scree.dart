import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/components/widgets/show_video/show_video.dart';
import '/bloc/favorite_bloc.dart';
import '/models/video.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final bloc = BlocProvider.getBloc<FavoriteBloc>();
  late final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.white10,
      ),
      body: StreamBuilder<Map<String, Video>>(
        initialData: const {},
        stream: bloc.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data!.values.map(
              (video) {
                return InkWell(
                  onTap: () {
                    controller = YoutubePlayerController(
                      initialVideoId: video.id,
                      flags: const YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                      ),
                    );
                    ShowVideo().view(
                      context: context,
                      youtubePlayerController: controller,
                    );
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(video);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, left: 15),
                          width: 110,
                          child: Image.network(
                            video.thumb,
                            height: 110,
                            width: 100,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          video.title,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
