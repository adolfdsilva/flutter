import 'package:intl/intl.dart';
import 'dart:math';

//widget const
final langButtonSize = 65.0;

const timeout = 60;
const address = 'address';

//Service Types
const int DRIVER_LIC = 1;
const int VEHICLE_REG = 2;
const int TECH_INSP = 3;
const int TRANSPORT_LIC = 4;

enum CopyType { Customer, Agent }

const invalidTicketNoCode = 999;
const timeoutCode = 408;
const timeoutMsg = 'Timeout';
const progress = 'Progress';
const LOCAL_EN = 'en';
const LOCAL_KM = 'km';

var device_id = '';
var agent_no = '';
var appName = '';

var locale = 'locale';

final formatCurrency = NumberFormat('###,###,###,###.##', 'en');

String formatAmount(String amount) => 'KHR ' + amount;
String formatDoubleAmount(double amount) =>
    'KHR ' + formatCurrency.format(amount);
final SUCCESS = 'Success';
final FAILED = 'Failed';

final _random = new Random();
int next(int min, int max) => min + _random.nextInt(max - min);
