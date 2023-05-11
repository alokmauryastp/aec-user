// @dart=2.9
class HealthScoreResultModel {
  int status;
  String msg;
  HealthScoreResultData data;

  HealthScoreResultModel({this.status, this.msg, this.data});

  HealthScoreResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new HealthScoreResultData.fromJson(json['data']) : null;
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

class HealthScoreResultData {
  double presentage;
  String name;
  int resultId;
  String link;

  HealthScoreResultData({this.presentage, this.name, this.resultId, this.link});

  HealthScoreResultData.fromJson(Map<String, dynamic> json) {
    presentage = json['Presentage'].toDouble();
    name = json['Name'];
    resultId = json['ResultId'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Presentage'] = this.presentage;
    data['Name'] = this.name;
    data['ResultId'] = this.resultId;
    data['link'] = this.link;
    return data;
  }
}
