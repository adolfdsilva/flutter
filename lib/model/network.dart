import 'dart:convert';

class NetworkError {
  int responseCode;
  String errorMsg;

  NetworkError(this.responseCode, this.errorMsg);

  NetworkError.fromJson(this.responseCode, String jsonBody) {
    if (jsonBody.isNotEmpty) {
      final jsonMap = jsonDecode(jsonBody);
      errorMsg = jsonMap['Message'];
    } else {
      errorMsg = '';
    }
  }
}
