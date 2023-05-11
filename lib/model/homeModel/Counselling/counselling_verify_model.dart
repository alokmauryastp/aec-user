// @dart=2.9
class CounselingVerifyModel {
  int status;
  String msg;
  CounselingVerifyData data;

  CounselingVerifyModel({this.status, this.msg, this.data});

  CounselingVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new CounselingVerifyData.fromJson(json['data']) : null;
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

class CounselingVerifyData {
  String buyCounselingId;
  String razorpayPaymentId;

  CounselingVerifyData({this.buyCounselingId, this.razorpayPaymentId});

  CounselingVerifyData.fromJson(Map<String, dynamic> json) {
    buyCounselingId = json['buy_counseling_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy_counseling_id'] = this.buyCounselingId;
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    return data;
  }
}
