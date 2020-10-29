import 'base_class.dart';

class VerifyRequest extends BaseModel {
  String tid = '';
  int service = 0;
  String ticketNo = '';

  VerifyRequest(String tid, {this.service, this.ticketNo});

  Map<String, dynamic> toJson() => {
        'service': service,
        'ticketno': ticketNo,
        'deviceId': deviceId,
        'timestamp': timeStamp,
        'tid': tid
      };
}

class VerifyResponse {
// response_code : 200
// response_msg : Vehicle Registration:: Ticket available
// reference_number : 2425449261034
// reference_inspection : 9180521652011
// customer_name : LYHOUR
// amount : 267000.0
// amount_registration : 225000
// amount_inspection : 42000
// currency : KHR
// session_id : 2RA5Hu6Hxiqsto3aUP3Sz00sioTv9ttM6C6XdiXh
// attr_1_name : null
// attr_1_value : null
// attr_2_name : null
// attr_2_value : null
// subInvoice : true
// total_main : 226000.0
// total_sub : 43000.0
// fees_total_main : 1000.0
// fees_share_main : 400.0
// fees_total_sub : 1000.0
//  ignore: slash_for_doc_comments
// fees_share_sub : 400.0
// fees_total : 2000.0
// fees_share : 800.0
// total : 269000.0

  int responseCode = -1;
  String responseMsg = '';
  String referenceNumber;
  String referenceInspection;
  String customerName = '';
  double amount = 0;
  String amountRegistration;
  String amountInspection;
  String currency = '';
  String sessionId;
  Object attrName1;
  Object attrValue1;
  Object attrName2;
  Object attrValue2;
  bool subInvoice;
  double totalMain;
  double totalSub;
  double feesTotalMain;
  double feesShareMain;
  double feesTotalSub;
  double feesShareSub;
  double feesTotal = 0;
  double feesShare;
  double total = 0;

  VerifyResponse();

  VerifyResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['response_code'],
        responseMsg = json['response_msg'],
        referenceNumber = json['reference_number'],
        referenceInspection = json['reference_inspection'],
        customerName = json['customer_name'],
        amount = json['amount'],
        amountRegistration = json['amount_registration'],
        amountInspection = json['amount_inspection'],
        currency = json['currency'],
        sessionId = json['session_id'],
        attrName1 = json['attr_1_name'],
        attrValue1 = json['attr_1_value'],
        attrName2 = json['attr_2_name'],
        attrValue2 = json['attr_2_value'],
        subInvoice = json['subInvoice'],
        totalMain = json['total_main'],
        totalSub = json['total_sub'],
        feesTotalMain = json['fees_total_main'],
        feesShareMain = json['fees_share_main'],
        feesTotalSub = json['fees_total_sub'],
        feesShareSub = json['fees_share_sub'],
        feesTotal = json['fees_total'],
        feesShare = json['fees_share'],
        total = json['total'];
}
