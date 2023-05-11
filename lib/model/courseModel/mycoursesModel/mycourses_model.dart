// @dart=2.9
class MyCoursesModel {
  int status;
  String msg;
  List<MyCoursesData> data;

  MyCoursesModel({this.status, this.msg, this.data});

  MyCoursesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<MyCoursesData>();
      json['data'].forEach((v) {
        data.add(new MyCoursesData.fromJson(v));
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

class MyCoursesData {
  String courseId;
  String buyId;
  String name;
  String title;
  String duration;
  String durationType;
  String price;
  List<String> feature;
  String description;
  String image;
  String validTill;
  String buyDate;

  MyCoursesData(
      {this.courseId,
        this.buyId,
        this.name,
        this.title,
        this.duration,
        this.durationType,
        this.price,
        this.feature,
        this.description,
        this.image,
        this.validTill,
        this.buyDate});

  MyCoursesData.fromJson(Map<String, dynamic> json) {
    courseId = json['CourseId'];
    buyId = json['BuyId'];
    name = json['Name'];
    title = json['Title'];
    duration = json['Duration'];
    durationType = json['DurationType'];
    price = json['Price'];
    feature = json['Feature'].cast<String>();
    description = json['Description'];
    image = json['Image'];
    validTill = json['ValidTill'];
    buyDate = json['BuyDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CourseId'] = this.courseId;
    data['BuyId'] = this.buyId;
    data['Name'] = this.name;
    data['Title'] = this.title;
    data['Duration'] = this.duration;
    data['DurationType'] = this.durationType;
    data['Price'] = this.price;
    data['Feature'] = this.feature;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['ValidTill'] = this.validTill;
    data['BuyDate'] = this.buyDate;
    return data;
  }
}
