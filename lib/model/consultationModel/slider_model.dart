// @dart=2.9
class SliderModel {
  int status;
  String msg;
  List<SliderData> data;

  SliderModel({this.status, this.msg, this.data});

  SliderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SliderData>();
      json['data'].forEach((v) {
        data.add(new SliderData.fromJson(v));
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

class SliderData {
  String sliderId;
  String title;
  String description;
  String image;
  String date;
  String time;

  SliderData(
      {this.sliderId,
        this.title,
        this.description,
        this.image,
        this.date,
        this.time});

  SliderData.fromJson(Map<String, dynamic> json) {
    sliderId = json['SliderId'];
    title = json['Title'];
    description = json['Description'];
    image = json['Image'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SliderId'] = this.sliderId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
