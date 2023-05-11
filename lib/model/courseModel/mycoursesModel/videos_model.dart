// @dart=2.9
class VideosModel {
  int status;
  String msg;
  List<VideosData> data;

  VideosModel({this.status, this.msg, this.data});

  VideosModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<VideosData>();
      json['data'].forEach((v) {
        data.add(new VideosData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideosData {
  String videoId;
  String title;
  String video;
  String image;
  String description;
  String duration;
  String date;
  String status;

  VideosData(
      {this.videoId,
        this.title,
        this.video,
        this.image,
        this.description,
        this.duration,
        this.date,
        this.status});

  VideosData.fromJson(Map<String, dynamic> json) {
    videoId = json['VideoId'];
    title = json['Title'];
    video = json['Video'];
    image = json['Image'];
    description = json['Description'];
    duration = json['Duration'];
    date = json['Date'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VideoId'] = this.videoId;
    data['Title'] = this.title;
    data['Video'] = this.video;
    data['Image'] = this.image;
    data['Description'] = this.description;
    data['Duration'] = this.duration;
    data['Date'] = this.date;
    data['Status'] = this.status;
    return data;
  }
}
