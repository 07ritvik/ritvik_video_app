import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  final String videoUrl;
  final String imageUrl;
  final bool playVideo;
  final bool to_mute;

  const VideoTile({
    Key? key,
    required this.videoUrl,
    required this.playVideo,
    required this.imageUrl,
    required this.to_mute,
  }) : super(key: key);
  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl);
    initializeVideoPlayerFuture = controller.initialize();

    if (widget.playVideo) {
      controller.play();
      var vol = widget.to_mute ? 0.0 : 1.0;
      controller.setVolume(vol);
      controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(VideoTile oldWidget) {
    if (oldWidget.playVideo != widget.playVideo) {
      if (widget.playVideo) {
        controller.play();
        var vol = widget.to_mute ? 0.0 : 1.0;
        controller.setVolume(vol);
        controller.setLooping(true);
      } else {
        controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.playVideo
        ? FutureBuilder(
            future: initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return VideoPlayer(controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        : Image(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.fill,
          );
  }
}
