import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '/bloc/favorite_bloc.dart';
import '/bloc/videos_bloc.dart';
import '/components/widgets/delegates/data_search.dart';
import '/models/video.dart';
import '/screens/favorite/favorite_scree.dart';
import 'widgets/videos_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideoBloc>();
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Image.asset(
          "assets/image/youtube.gif",
          height: 75,
          width: 50,
        ),
        actions: [
          Align(
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data!.length}");
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.star)),
          IconButton(
              onPressed: () async {
                final result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null) {
                  BlocProvider.getBloc<VideoBloc>().isSearch.add(result);
                }
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: bloc.outVideos,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(
                    video: snapshot.data[index],
                  );
                } else if (index > 1) {
                  bloc.isSearch.add("+=");
                  return Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  return Align(
                    alignment: Alignment.center,
                    heightFactor: MediaQuery.of(context).size.height * 0.01,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          "Aguardando sua pesquisa",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
