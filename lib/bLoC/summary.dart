import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mpwt/utils/constants.dart';
import 'dart:async';
import 'package:mpwt/model/list.dart';
import 'package:mpwt/viewmodel/base_view_model.dart';

class Summary extends BaseViewModel {
  var txnList = List<ListResponse>();
  var error;

  Future<List<ListResponse>> getTxns(
      String tid, String fromDate, String toDate) async {
    print('Getting Txns');
    setState(ViewState.Busy);
    txnList.clear();
    try {
      http.Response response = await http.post(
//       '$url/list',
        'http://www.mocky.io/v2/5db9183e30000075005ee08a',
        body: json.encode(ListRequest(from: fromDate, to: toDate, tid: tid)),
        headers: {'Content-type': 'application/json'},
      ).timeout(
        Duration(seconds: timeout),
      );

      if (response.statusCode == 200) {
        print(utf8.decode(response.bodyBytes));
        Iterable jsonDecode = json.decode(utf8.decode(response.bodyBytes));
        txnList = jsonDecode.map((map) => ListResponse.fromJson(map)).toList();
      }
    } on TimeoutException catch (_) {
      print('Timeout Exception');
      error = timeoutMsg;
    } on Exception catch (e) {
      error = e.toString();
      print(e);
    }
    setState(ViewState.Idle);
    return txnList;
  }
}
