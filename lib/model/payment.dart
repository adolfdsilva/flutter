import 'package:mpwt/model/login.dart';

import 'base_class.dart';

class PaymentRequest extends BaseModel {
  int service;
  String mid;
  String loc;
  String currency;
  double amount;
  double feesshare;
  double total;
  String customer;
  String mobile = '';
  String item;
  String sessionid;
  String tid;

  PaymentRequest(
      {LoginResponse loginResponse,
      this.service,
      this.currency,
      this.amount,
      this.feesshare,
      this.total,
      this.customer,
      this.mobile,
      this.item,
      this.sessionid}) {
    this.mid = loginResponse.mid;
    this.loc = loginResponse.loc;
    this.tid = loginResponse.tid;
  }

  Map<String, dynamic> toJson() => {
        'service': service,
        'mid': mid,
        'loc': loc,
        'currency': currency,
        'amount': amount,
        'feesshare': feesshare,
        'total': total,
        'customer': customer,
        'mobile': mobile,
        'item': item,
        'sessionid': sessionid,
        'tid': tid,
        'deviceId': deviceId,
        'timestamp': timeStamp,
      };
}

class PaymentResponse {
  String currency;
  double bal;
  String rrn;
  String ticketno;

  PaymentResponse();

  PaymentResponse.fromJson(Map<String, dynamic> json)
      : currency = json['currency'],
        bal = json['bal'],
        rrn = json['rrn'],
        ticketno = json['ticketno'];
}
