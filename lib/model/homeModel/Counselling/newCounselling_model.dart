// @dart=2.9
class NewCounselingModel {
  int status;
  String msg;
  List<NewCounselingData> data;

  NewCounselingModel({this.status, this.msg, this.data});

  NewCounselingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<NewCounselingData>();
      json['data'].forEach((v) {
        data.add(new NewCounselingData.fromJson(v));
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

class NewCounselingData {
  String buyCounselingId;
  String counselingId;
  String name;
  String title;
  String price;
  String startDate;
  String hour;
  String minute;
  String startTiming;
  String duration;
  String link;
  String subject;
  String description;
  String date;
  String time;
  String profile;

  NewCounselingData(
      {this.buyCounselingId,
        this.counselingId,
        this.name,
        this.title,
        this.price,
        this.startDate,
        this.hour,
        this.minute,
        this.startTiming,
        this.duration,
        this.link,
        this.subject,
        this.description,
        this.date,
        this.time,
        this.profile});

  NewCounselingData.fromJson(Map<String, dynamic> json) {
    buyCounselingId = json['BuyCounselingId'];
    counselingId = json['CounselingId'];
    name = json['Name'];
    title = json['Title'];
    price = json['Price'];
    startDate = json['StartDate'];
    hour = json['Hour'];
    minute = json['Minute'];
    startTiming = json['StartTiming'];
    duration = json['Duration'];
    link = json['Link'];
    subject = json['Subject'];
    description = json['Description'];
    date = json['Date'];
    time = json['Time'];
    profile = json['Profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BuyCounselingId'] = this.buyCounselingId;
    data['CounselingId'] = this.counselingId;
    data['Name'] = this.name;
    data['Title'] = this.title;
    data['Price'] = this.price;
    data['StartDate'] = this.startDate;
    data['Hour'] = this.hour;
    data['Minute'] = this.minute;
    data['StartTiming'] = this.startTiming;
    data['Duration'] = this.duration;
    data['Link'] = this.link;
    data['Subject'] = this.subject;
    data['Description'] = this.description;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Profile'] = this.profile;
    return data;
  }
}
