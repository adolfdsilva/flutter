import 'package:mpwt/model/login.dart';
import 'package:mpwt/model/verify.dart';
import 'base_view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mpwt/utils/constants.dart';
import 'dart:async';
import 'package:mpwt/model/network.dart';
import 'package:mpwt/model/payment.dart';
import 'package:mpwt/model/list.dart';

class HomeViewModel extends BaseViewModel {
  String _ticketNo;
  String get ticketNo => _ticketNo;
  set setTicketNo(String ticketNo) {
    _ticketNo = ticketNo;
    notifyListeners();
  }

  int _service = 0;
  int get service => _service;
  set setService(int service) {
    _service = service;
    notifyListeners();
  }

  String _mobile;
  set setMobileNo(String mobileNo) {
    _mobile = mobileNo;
  }

  LoginResponse _loginResponse;
  VerifyRequest _verifyRequest;
  VerifyResponse verifyResponse;
  ListResponse listResponse;
  bool isVerifyComplete = false;

  HomeViewModel(this._loginResponse);

  Future<NetworkError> verify() async {
    if (state == ViewState.Busy) {
      return NetworkError(99, 'Network Request already In Progress');
    }

    if (!isValid(_service, _ticketNo)) {
      return NetworkError(invalidTicketNoCode, '');
    }

    try {
      setState(ViewState.Busy);
      _verifyRequest = VerifyRequest(_loginResponse.tid,
          service: _service, ticketNo: _ticketNo);
      http.Response response = await http.post(
        '$url/verify',
//        'http://www.mocky.io/v2/5d0afd782f00004a00e3ed70', //success
//        'http://www.mocky.io/v2/5d0c7da03500006400b89860', //error
        body: json.encode(_verifyRequest.toJson()),
        headers: {'Content-type': 'application/json'},
      ).timeout(
        Duration(seconds: timeout),
      );

      print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        verifyResponse = VerifyResponse.fromJson(json);
        isVerifyComplete = true;
        notifyListeners();
        return null;
      } else {
        return NetworkError.fromJson(response.statusCode, response.body);
      }
    } on TimeoutException catch (_) {
      return NetworkError(timeoutCode, timeoutMsg);
    } finally {
      setState(ViewState.Idle);
    }
  }

  Future<NetworkError> makePayment() async {
    try {
      setState(ViewState.Busy);
      final _paymentRequest = PaymentRequest(
          loginResponse: _loginResponse,
          service: _service,
          currency: verifyResponse.currency,
          amount: verifyResponse.amount,
          feesshare: verifyResponse.feesShare,
          total: verifyResponse.total,
          customer: verifyResponse.customerName,
          mobile: _mobile,
          item: verifyResponse.responseMsg,
          sessionid: verifyResponse.sessionId);
      http.Response response = await http.post(
        '$url/pay',
//        'http://www.mocky.io/v2/5d0c97ec3500005b00b8995a', //success
//        'http://www.mocky.io/v2/5d0c7da03500006400b89860', //error
        body: json.encode(_paymentRequest.toJson()),
        headers: {'Content-type': 'application/json'},
      ).timeout(
        Duration(seconds: timeout),
      );

      if (response.statusCode == 200) {
        print(response.body);
        final paymentResponse =
            PaymentResponse.fromJson(jsonDecode(response.body));
        listResponse = ListResponse.fromVerifyAndPayment(
            _verifyRequest, verifyResponse, _paymentRequest, paymentResponse);
        listResponse.agentNo = _loginResponse.mob;
        listResponse.tid = _loginResponse.tid;
        return null;
      } else {
        return NetworkError.fromJson(response.statusCode, response.body);
      }
    } on TimeoutException catch (_) {
      return NetworkError(timeoutCode, timeoutMsg);
    } on Exception catch (e) {
      return NetworkError(-1, 'General Error ${e.toString()}');
    } finally {
      setState(ViewState.Idle);
    }
  }

  bool isValid(int service, String ticketNo) {
    return !(service == 0 ||
        ticketNo == null ||
        (service == DRIVER_LIC || service == VEHICLE_REG) &&
            ticketNo.length != 13);
  }

  void reset() {
    verifyResponse = null;
    listResponse = null;
    _service = 0;
    _ticketNo = null;
    _mobile = null;
    isVerifyComplete = false;
    notifyListeners();
  }
}
