// @dart=2.9
class BuyCourseModel {
  int status;
  String msg;
  BuyCourseData data;

  BuyCourseModel({this.status, this.msg, this.data});

  BuyCourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new BuyCourseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class BuyCourseData {
  String buyId;

  BuyCourseData({this.buyId});

  BuyCourseData.fromJson(Map<String, dynamic> json) {
    buyId = json['BuyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BuyId'] = this.buyId;
    return data;
  }
}
