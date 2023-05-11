// @dart=2.9
class BookingPaymentModel {
  int status;
  String msg;
  BookingPaymentData data;

  BookingPaymentModel({this.status, this.msg, this.data});

  BookingPaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new BookingPaymentData.fromJson(json['data']) : null;
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

class BookingPaymentData {
  String consultId;
  String message;
  String doctor;
  String date;
  String time;

  BookingPaymentData({this.consultId, this.message, this.doctor, this.date, this.time});

  BookingPaymentData.fromJson(Map<String, dynamic> json) {
    consultId = json['ConsultId'];
    message = json['message'];
    doctor = json['Doctor'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ConsultId'] = this.consultId;
    data['message'] = this.message;
    data['Doctor'] = this.doctor;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
