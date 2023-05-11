// @dart=2.9
class BlogModel {
  int status;
  String msg;
  List<BlogData> data;

  BlogModel({this.status, this.msg, this.data});

  BlogModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<BlogData>();
      json['data'].forEach((v) {
        data.add(new BlogData.fromJson(v));
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

class BlogData {
  String blogId;
  String title;
  String author;
  String image;
  String shortDescription;
  String description;
  String date;
  String time;
  String timeAgo;
  int replyCount;

  BlogData(
      {this.blogId,
        this.title,
        this.author,
        this.image,
        this.shortDescription,
        this.description,
        this.date,
        this.time,
        this.timeAgo,
        this.replyCount});

  BlogData.fromJson(Map<String, dynamic> json) {
    blogId = json['BlogId'];
    title = json['Title'];
    author = json['Author'];
    image = json['Image'];
    shortDescription = json['Short_Description'];
    description = json['Description'];
    date = json['Date'];
    time = json['Time'];
    timeAgo = json['TimeAgo'];
    replyCount = json['ReplyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BlogId'] = this.blogId;
    data['Title'] = this.title;
    data['Author'] = this.author;
    data['Image'] = this.image;
    data['Short_Description'] = this.shortDescription;
    data['Description'] = this.description;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['TimeAgo'] = this.timeAgo;
    data['ReplyCount'] = this.replyCount;
    return data;
  }
}
