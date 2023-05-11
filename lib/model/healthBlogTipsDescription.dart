
import 'dart:convert';

List<HealthBlogAndTipsDescription> healthBlogAndTipsDescriptionFromJson(String str) => List<HealthBlogAndTipsDescription>.from(json.decode(str).map((x) => HealthBlogAndTipsDescription.fromJson(x)));

String healthBlogAndTipsDescriptionToJson(List<HealthBlogAndTipsDescription> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HealthBlogAndTipsDescription {
    HealthBlogAndTipsDescription({
       required this.status,
      required  this.msg,
       required this.data,
    });

    int status;
    String msg;
    DiscrptionData data;

    factory HealthBlogAndTipsDescription.fromJson(Map<String, dynamic> json) => HealthBlogAndTipsDescription(
        status: json["status"],
        msg: json["msg"],
        data: DiscrptionData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
    };
}

class DiscrptionData {
    DiscrptionData({
      required  this.blogId,
      required  this.title,
      required  this.author,
      required  this.image,
      required  this.shortDescription,
      required  this.description,
      required  this.date,
      required  this.time,
      required  this.timeAgo,
      required  this.replyCount,
    });

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

    factory DiscrptionData.fromJson(Map<String, dynamic> json) => DiscrptionData(
        blogId: json["BlogId"],
        title: json["Title"],
        author: json["Author"],
        image: json["Image"],
        shortDescription: json["Short_Description"],
        description: json["Description"],
        date: json["Date"],
        time: json["Time"],
        timeAgo: json["TimeAgo"],
        replyCount: json["ReplyCount"],
    );

    Map<String, dynamic> toJson() => {
        "BlogId": blogId,
        "Title": title,
        "Author": author,
        "Image": image,
        "Short_Description": shortDescription,
        "Description": description,
        "Date": date,
        "Time": time,
        "TimeAgo": timeAgo,
        "ReplyCount": replyCount,
    };
}
