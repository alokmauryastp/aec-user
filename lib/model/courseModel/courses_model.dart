// @dart=2.9
class CoursesModel {
  int status;
  String msg;
  List<CoursesData> data;

  CoursesModel({this.status, this.msg, this.data});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<CoursesData>();
      json['data'].forEach((v) {
        data.add(new CoursesData.fromJson(v));
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

class CoursesData {
  String courseId;
  String name;
  String title;
  String duration;
  String durationType;
  String price;
  List<String> feature;
  String description;
  String image;

  CoursesData(
      {this.courseId,
        this.name,
        this.title,
        this.duration,
        this.durationType,
        this.price,
        this.feature,
        this.description,
        this.image});

  CoursesData.fromJson(Map<String, dynamic> json) {
    courseId = json['CourseId'];
    name = json['Name'];
    title = json['Title'];
    duration = json['Duration'];
    durationType = json['DurationType'];
    price = json['Price'];
    feature = json['Feature'].cast<String>();
    description = json['Description'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CourseId'] = this.courseId;
    data['Name'] = this.name;
    data['Title'] = this.title;
    data['Duration'] = this.duration;
    data['DurationType'] = this.durationType;
    data['Price'] = this.price;
    data['Feature'] = this.feature;
    data['Description'] = this.description;
    data['Image'] = this.image;
    return data;
  }
}
