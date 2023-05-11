// @dart=2.9
class CourseCounselingModel {
  int status;
  String msg;
  List<CourseCounselingData> data;

  CourseCounselingModel({this.status, this.msg, this.data});

  CourseCounselingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<CourseCounselingData>();
      json['data'].forEach((v) {
        data.add(new CourseCounselingData.fromJson(v));
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

class CourseCounselingData {
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
  String doctorName;

  CourseCounselingData(
      {this.counselingId,
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
        this.profile,
        this.doctorName});

  CourseCounselingData.fromJson(Map<String, dynamic> json) {
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
    doctorName = json['DoctorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['DoctorName'] = this.doctorName;
    return data;
  }
}
