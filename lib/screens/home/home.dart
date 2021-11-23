import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '/bloc/videos_bloc.dart';
import '/delegates/data_search.dart';
import 'widgets/videos_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/image/youtubr.png"),
        actions: [
          const Align(
            child: Text("0"),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
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
        stream: BlocProvider.getBloc<VideoBloc>().outVideos,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return VideoTile(
                  video: snapshot.data[index],
                );
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
