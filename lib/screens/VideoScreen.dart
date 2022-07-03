import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String name, mediaURL;
  VideoScreen({required this.name, required this.mediaURL});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.mediaURL)
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Color.fromRGBO(50, 69, 88, 0),
        elevation: 50.0,
      ),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : Container(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
