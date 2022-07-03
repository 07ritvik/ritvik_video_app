import 'dart:convert';
import 'package:video_app/model/json_data.dart';
import 'package:flutter/services.dart' as rb;

Future<List<VideoDataModel>> ReadJsonData() async {
  final jsonData = await rb.rootBundle.loadString('assets/dataset.json');
  final videoList = json.decode(jsonData) as List<dynamic>;
  return videoList.map((e) => VideoDataModel.fromJSON(e)).toList();
}
