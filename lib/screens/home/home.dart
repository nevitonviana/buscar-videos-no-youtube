import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(child: Image.asset("assets/image/youtubr.png")),
        actions: [
          Align(
            child: Text("0"),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.star)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
    );
  }
}
