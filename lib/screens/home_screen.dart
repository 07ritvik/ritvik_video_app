import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_app/widgets/video_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            leading: Icon(
              Icons.play_circle_filled_sharp,
              color: Colors.red,
              size: 50.0,
            ),
            title: Text('Video App'),
          ),
        ],
        body: VideoList(),
      ),
    );
  }
}
