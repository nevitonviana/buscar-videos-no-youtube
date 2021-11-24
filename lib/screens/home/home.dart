import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '/bloc/videos_bloc.dart';
import '/delegates/data_search.dart';
import 'widgets/videos_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideoBloc>();
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
                    heightFactor: MediaQuery.of(context).size.height * 0.03,
                    child: const Text(
                      "aguardendo um pesquesa",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
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
