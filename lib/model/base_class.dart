import 'package:intl/intl.dart';
import 'package:mpwt/utils/constants.dart';

abstract class BaseModel {

  String deviceId;
  String timeStamp = DateFormat('dd MM yyyy HH:mm:ss', 'en').format(DateTime.now());

  BaseModel() {
    this.deviceId = device_id;
  }
}