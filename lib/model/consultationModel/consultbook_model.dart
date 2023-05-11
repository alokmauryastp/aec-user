// @dart=2.9
class ConsultBookModel {
  int status;
  String msg;
  ConsultBookData data;

  ConsultBookModel({this.status, this.msg, this.data});

  ConsultBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new ConsultBookData.fromJson(json['data']) : null;
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

class ConsultBookData {
  int counsultId;

  ConsultBookData({this.counsultId});

  ConsultBookData.fromJson(Map<String, dynamic> json) {
    counsultId = json['CounsultId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CounsultId'] = this.counsultId;
    return data;
  }
}
