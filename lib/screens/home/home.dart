import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:buscavidedoyoutubecombloc/bloc/videos_bloc.dart';
import 'package:flutter/material.dart';

import '/delegates/data_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        builder: (context, snapshot) => ,
      ),
    );
  }
}
