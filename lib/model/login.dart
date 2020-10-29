import 'base_class.dart';

class LoginRequest extends BaseModel {
  String username;
  String password;

  LoginRequest({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'user': username,
        'pwd': password,
        'deviceId': deviceId,
        'timestamp': timeStamp
      };
}

class LoginResponse {
  String tid;
  String mid;
  String loc;
  String mob;
  String pin;
  double bal;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : tid = json['tid'],
        mid = json['mid'],
        loc = json['loc'],
        mob = json['mob'],
        pin = json['pin'],
        bal = json['bal'];
}
