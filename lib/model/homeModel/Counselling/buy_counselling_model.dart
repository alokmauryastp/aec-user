// @dart=2.9
class BuyCounselingModel {
  int status;
  String msg;
  BuyCounselingData data;

  BuyCounselingModel({this.status, this.msg, this.data});

  BuyCounselingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new BuyCounselingData.fromJson(json['data']) : null;
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

class BuyCounselingData {
  int buyCounselingId;

  BuyCounselingData({this.buyCounselingId});

  BuyCounselingData.fromJson(Map<String, dynamic> json) {
    buyCounselingId = json['buy_counseling_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy_counseling_id'] = this.buyCounselingId;
    return data;
  }
}
