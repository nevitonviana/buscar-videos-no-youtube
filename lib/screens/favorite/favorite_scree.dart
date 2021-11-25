import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:buscavidedoyoutubecombloc/bloc/favorite_bloc.dart';
import 'package:buscavidedoyoutubecombloc/models/video.dart';
import 'package:buscavidedoyoutubecombloc/screens/show_video/show_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
      backgroundColor: Colors.black12,
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
            children: snapshot.data!.values.map((v) {
              return InkWell(
                onTap: () {
                  controller = YoutubePlayerController(
                    initialVideoId: v.id,
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ShowVideoScreen(controller: controller),
                    ),
                  );
                },
                onLongPress: () {
                  bloc.toggleFavorite(v);
                },
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(
                      child: Text(
                        v.title,
                        style: const TextStyle(
                          color: Colors.white38,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
