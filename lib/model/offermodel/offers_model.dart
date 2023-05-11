// @dart=2.9
class OffersModel {
  int status;
  String msg;
  List<OffersData> data;

  OffersModel({this.status, this.msg, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<OffersData>();
      json['data'].forEach((v) {
        data.add(new OffersData.fromJson(v));
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

class OffersData {
  String courseId;
  String title;
  String couponCode;
  String discount;
  String validTill;
  String date;
  String time;

  OffersData(
      {this.courseId,
        this.title,
        this.couponCode,
        this.discount,
        this.validTill,
        this.date,
        this.time});

  OffersData.fromJson(Map<String, dynamic> json) {
    courseId = json['CourseId'];
    title = json['Title'];
    couponCode = json['CouponCode'];
    discount = json['Discount'];
    validTill = json['ValidTill'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CourseId'] = this.courseId;
    data['Title'] = this.title;
    data['CouponCode'] = this.couponCode;
    data['Discount'] = this.discount;
    data['ValidTill'] = this.validTill;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
