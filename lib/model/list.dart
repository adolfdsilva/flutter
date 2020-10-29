import 'base_class.dart';
import 'verify.dart';
import 'payment.dart';
import 'package:intl/intl.dart';
import 'package:mpwt/utils/constants.dart';

var currencyFormatter = NumberFormat('###,###,###,###.##', 'en');

class ListRequest extends BaseModel {
  String from;
  String to;
  String tid;

  ListRequest({this.from, this.to, this.tid});
  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'tid': tid,
        'deviceId': deviceId,
        'timestamp': timeStamp
      };
}

class ListResponse {
  int service;
  String ticketNo;
  String rrn;
  String date;
  String customer;
  String mobile;
  String currency;
  String amount;
  String total;
  String feesTotal;
  String feesAgent;
  String rc;
  String reversed;
  String addInfo;
  List<ListResponse> subInvoice;
  String tid;
  bool isDuplicate = false;
  String agentNo = '';
  String bal = '';

  ListResponse();

  ListResponse.fromVerifyAndPayment(
      VerifyRequest verifyRequest,
      VerifyResponse verifyResponse,
      PaymentRequest paymentRequest,
      PaymentResponse paymentResponse) {
    service = verifyRequest.service;
    ticketNo = verifyRequest.ticketNo;
    rrn = paymentResponse != null ? paymentResponse.rrn : "";
    date = DateFormat('dd MM yyyy HH:mm:ss', 'en').format(DateTime.now());
    customer = verifyResponse.customerName;
    mobile = paymentRequest.mobile;
    currency = verifyResponse.currency;
    amount = currencyFormatter.format(verifyResponse.amount);
    total = currencyFormatter.format(verifyResponse.total);
    feesTotal = currencyFormatter.format(verifyResponse.feesTotal);
    feesAgent = currencyFormatter
        .format(verifyResponse.feesTotal - verifyResponse.feesShare);
    rc = paymentResponse != null ? "Success" : "Failed";
    addInfo = verifyResponse.responseMsg;
    if (verifyResponse.subInvoice) {
      final subInvoice = ListResponse();
      subInvoice.ticketNo = verifyResponse.referenceInspection;
      subInvoice.service = TECH_INSP;

      //set sub invoice amounts
      subInvoice.amount = verifyResponse.amountInspection;
      subInvoice.total = currencyFormatter.format(verifyResponse.totalSub);
      subInvoice.feesTotal =
          currencyFormatter.format(verifyResponse.feesTotalMain);
      subInvoice.feesAgent = currencyFormatter
          .format(verifyResponse.totalSub - verifyResponse.feesShareSub);
      this.subInvoice = [subInvoice];

      //override amount idk why check android
      amount = currencyFormatter.format(verifyResponse.amountRegistration);
      total = currencyFormatter.format(verifyResponse.totalMain);
      feesTotal = currencyFormatter.format(verifyResponse.feesTotalMain);
      feesAgent = currencyFormatter
          .format(verifyResponse.feesTotalMain - verifyResponse.feesShareMain);
    }
    tid = verifyRequest.tid;
    bal = formatDoubleAmount(paymentResponse.bal);
  }

  ListResponse.fromJson(Map<String, dynamic> json)
      : service = json['service'],
        ticketNo = json['ticketno'],
        rrn = json['rrn'],
        date = json['date'],
        customer = json['customer'],
        mobile = json['mobile'],
        currency = json['currency'],
        amount = json['amount'],
        total = json['total'],
        feesTotal = json['fees_total'],
        feesAgent = json['fees_agent'],
        rc = json['rc'],
        reversed = json['reversed'],
        addInfo = json['item'],
        subInvoice = json['subinvoice'] != null
            ? (json['subinvoice'] as List)
                .map((i) => ListResponse.fromJson(i))
                .toList()
            : [];
}
