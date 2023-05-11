// @dart=2.9
class AllCounselingModel {
  int status;
  String msg;
  List<AllCounselingData> data;

  AllCounselingModel({this.status, this.msg, this.data});

  AllCounselingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<AllCounselingData>();
      json['data'].forEach((v) {
        data.add(new AllCounselingData.fromJson(v));
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

class AllCounselingData {
  String counselingId;
  String name;
  String title;
  String price;
  String offerPrice;
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
  String doctorName;

  AllCounselingData(
      {this.counselingId,
        this.name,
        this.title,
        this.price,
        this.offerPrice,
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
        this.doctorName});

  AllCounselingData.fromJson(Map<String, dynamic> json) {
    counselingId = json['CounselingId'];
    name = json['Name'];
    title = json['Title'];
    price = json['Price'];
    offerPrice = json['OfferPrice'];
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
    doctorName = json['DoctorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CounselingId'] = this.counselingId;
    data['Name'] = this.name;
    data['Title'] = this.title;
    data['Price'] = this.price;
    data['OfferPrice'] = this.offerPrice;
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
    data['DoctorName'] = this.doctorName;
    return data;
  }
}
