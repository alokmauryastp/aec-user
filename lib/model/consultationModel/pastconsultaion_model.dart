// @dart=2.9
class PastConsultationModel {
  int status;
  String msg;
  List<PastConsultationData> data;

  PastConsultationModel({this.status, this.msg, this.data});

  PastConsultationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<PastConsultationData>();
      json['data'].forEach((v) {
        data.add(new PastConsultationData.fromJson(v));
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

class PastConsultationData {
  String consultId;
  String patientName;
  String disease;
  String patientAge;
  String gender;
  String address;
  String language;
  String consultMedium;
  String paymentAmount;
  String couponAmount;
  String couponDiscount;
  String couponCode;
  String paymentMode;
  String assignId;
  String waitingTime;
  String date;
  String time;
  String doctor;
  String validTill;
  String doctorId;
  String doctorProfile;
  double rating;
  String prescriptionPdf;
  String assignStatus;
  String videoUrl;
  String videoStatus;

  PastConsultationData(
      {this.consultId,
        this.patientName,
        this.disease,
        this.patientAge,
        this.gender,
        this.address,
        this.language,
        this.consultMedium,
        this.paymentAmount,
        this.couponAmount,
        this.couponDiscount,
        this.couponCode,
        this.paymentMode,
        this.assignId,
        this.waitingTime,
        this.date,
        this.time,
        this.doctor,
        this.validTill,
        this.doctorId,
        this.doctorProfile,
        this.rating,
        this.prescriptionPdf,
        this.assignStatus,
        this.videoUrl,
        this.videoStatus});

  PastConsultationData.fromJson(Map<String, dynamic> json) {
    consultId = json['ConsultId'];
    patientName = json['PatientName'];
    disease = json['Disease'];
    patientAge = json['PatientAge'];
    gender = json['Gender'];
    address = json['Address'];
    language = json['Language'];
    consultMedium = json['ConsultMedium'];
    paymentAmount = json['PaymentAmount'];
    couponAmount = json['CouponAmount'];
    couponDiscount = json['CouponDiscount'];
    couponCode = json['CouponCode'];
    paymentMode = json['PaymentMode'];
    assignId = json['AssignId'];
    waitingTime = json['WaitingTime'];
    date = json['Date'];
    time = json['Time'];
    doctor = json['Doctor'];
    validTill = json['ValidTill'];
    doctorId = json['DoctorId'];
    doctorProfile = json['DoctorProfile'];
    rating = json['Rating'].toDouble();
    prescriptionPdf = json['prescription_pdf'];
    assignStatus = json['AssignStatus'];
    videoUrl = json['VideoUrl'];
    videoStatus = json['VideoStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ConsultId'] = this.consultId;
    data['PatientName'] = this.patientName;
    data['Disease'] = this.disease;
    data['PatientAge'] = this.patientAge;
    data['Gender'] = this.gender;
    data['Address'] = this.address;
    data['Language'] = this.language;
    data['ConsultMedium'] = this.consultMedium;
    data['PaymentAmount'] = this.paymentAmount;
    data['CouponAmount'] = this.couponAmount;
    data['CouponDiscount'] = this.couponDiscount;
    data['CouponCode'] = this.couponCode;
    data['PaymentMode'] = this.paymentMode;
    data['AssignId'] = this.assignId;
    data['WaitingTime'] = this.waitingTime;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Doctor'] = this.doctor;
    data['ValidTill'] = this.validTill;
    data['DoctorId'] = this.doctorId;
    data['DoctorProfile'] = this.doctorProfile;
    data['Rating'] = this.rating;
    data['prescription_pdf'] = this.prescriptionPdf;
    data['AssignStatus'] = this.assignStatus;
    data['VideoUrl'] = this.videoUrl;
    data['VideoStatus'] = this.videoStatus;
    return data;
  }
}
