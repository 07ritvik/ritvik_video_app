class VideoDataModel {
  int? id;
  String? title;
  String? videoURL;
  String? coverPicture;

  VideoDataModel({
    this.id,
    this.title,
    this.videoURL,
    this.coverPicture,
  });

  VideoDataModel.fromJSON(Map<String,dynamic> json)
  {
    id=json['id'];
    title=json['title'];
    videoURL=json['videoUrl'];
    coverPicture=json['coverPicture'];
  }

}
