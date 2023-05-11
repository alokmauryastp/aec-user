// @dart=2.9
class CheckCouponModel {
  int status;
  String msg;
  CheckCouponData data;

  CheckCouponModel({this.status, this.msg, this.data});

  CheckCouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new CheckCouponData.fromJson(json['data']) : null;
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

class CheckCouponData {
  String couponId;
  String discount;
  String couponCode;

  CheckCouponData({this.couponId, this.discount, this.couponCode});

  CheckCouponData.fromJson(Map<String, dynamic> json) {
    couponId = json['CouponId'];
    discount = json['Discount'];
    couponCode = json['CouponCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CouponId'] = this.couponId;
    data['Discount'] = this.discount;
    data['CouponCode'] = this.couponCode;
    return data;
  }
}
