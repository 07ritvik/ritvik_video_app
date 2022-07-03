import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_app/model/json_data.dart';
import 'package:video_app/model/video_list.dart';
import 'package:video_app/screens/VideoScreen.dart';
import 'package:video_app/widgets/video_card.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late bool mute = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          var items = data.data as List<VideoDataModel>;
          return InViewNotifierList(
              isInViewPortCondition:
                  (deltaTop, deltaBottom, viewPortDimension) {
                return deltaTop > (0.012 * viewPortDimension) &&
                    deltaBottom < (0.65 * viewPortDimension);
              },
              itemCount: items.length,
              builder: (context, index) {
                return InViewNotifierWidget(
                  id: index.toString(),
                  builder: (context, inView, _) {
                    final videoUrl = items[index].videoURL ?? '';
                    final imageUrl = items[index].coverPicture ?? '';
                    return GestureDetector(
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              width: double.maxFinite,
                              child: VideoTile(
                                videoUrl: videoUrl,
                                playVideo: inView,
                                imageUrl: imageUrl,
                                to_mute: mute,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    items[index].title.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: IconButton(
                                    icon: mute
                                        ? Icon(Icons.volume_off_sharp)
                                        : Icon(Icons.volume_up_sharp),
                                    onPressed: () {
                                      setState(() {
                                        mute = !mute;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              name: items[index].title.toString(),
                              mediaURL: items[index].videoURL.toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
