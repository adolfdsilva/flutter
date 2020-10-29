import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "Scanning Device&#8230;"
  String get scanning => "Scanning Device&#8230;";
  /// "Select the connected device"
  String get select_device => "Select the connected device";
  /// "No matching devices"
  String get none_paired => "No matching devices";
  /// "No device found"
  String get none_found => "No device found";
  /// "Match equipment"
  String get title_paired_devices => "Match equipment";
  /// "Other useful equipment"
  String get title_other_devices => "Other useful equipment";
  /// "Scanning device"
  String get button_scan => "Scanning device";
  /// "Input Error!"
  String get msg_state => "Input Error!";
  /// "Please connect a Bluetooth printer"
  String get not_connected => "Please connect a Bluetooth printer";
  /// "Bluetooth does not start, quit the program"
  String get bt_not_enabled_leaving => "Bluetooth does not start, quit the program";
  /// "Connecting…"
  String get title_connecting => "Connecting…";
  /// "Connected to ${name}"
  String title_connected_to_printer(String name) => "Connected to ${name}";
  /// "Cannot connect"
  String get title_not_connected => "Cannot connect";
  /// "It is connected to a Bluetooth printer"
  String get Connecting => "It is connected to a Bluetooth printer";
  /// "en"
  String get strLang => "en";
  /// "Input errors, please check!"
  String get msg_error => "Input errors, please check!";
  /// "Terminal Id"
  String get text_agent_id => "Terminal Id";
  /// "Printer Address"
  String get text_printer_address => "Printer Address";
  /// "Missing AgentId or Password"
  String get toast_missing_credentials => "Missing AgentId or Password";
  /// "Reference No"
  String get text_ticket_no => "Reference No";
  /// "Service Type"
  String get text_service_type => "Service Type";
  /// "Mobile"
  String get text_customer_mobile => "Mobile";
  /// "Please Enter Ticket No"
  String get toast_ticket_no_empty => "Please Enter Ticket No";
  /// "Customer Name"
  String get text_customer_name => "Customer Name";
  /// "Currency"
  String get text_currency => "Currency";
  /// "Amount"
  String get text_amount => "Amount";
  /// "Fees"
  String get text_fees => "Fees";
  /// "Total"
  String get text_total_amount => "Total";
  /// "Enter Transaction PIN"
  String get text_input_pin => "Enter Transaction PIN";
  /// "OK"
  String get text_ok => "OK";
  /// "Please enter PIN"
  String get text_pin_empty => "Please enter PIN";
  /// "Incorrect PIN"
  String get text_incorrect_pin => "Incorrect PIN";
  /// "Transaction Successful"
  String get toast_tran_success => "Transaction Successful";
  /// "Please enter mobile no"
  String get toast_mobile_empty => "Please enter mobile no";
  /// "Bluetooth is not available"
  String get tost_bt_not_available => "Bluetooth is not available";
  /// "Device connection was lost"
  String get toast_conn_lost => "Device connection was lost";
  /// "Unable to connect device"
  String get toast_unable_to_conn => "Unable to connect device";
  /// "Test Print Successful"
  String get sample_print => "Test Print Successful";
  /// "Agent No"
  String get text_agent_no => "Agent No";
  /// "Tran Id"
  String get text_tran_id => "Tran Id";
  /// "Print Receipt"
  String get title_print_receipt => "Print Receipt";
  /// "Please select service type"
  String get toast_service_empty => "Please select service type";
  /// "No Transactions"
  String get text_no_transactions => "No Transactions";
  /// "QRCode Read Timeout"
  String get toast_read_timeout => "QRCode Read Timeout";
  /// "Printer Not Configured"
  String get text_printer_not_config => "Printer Not Configured";
  /// "Bluetooth Printer"
  String get text_bt_printer => "Bluetooth Printer";
  /// "Use Bluetooth Printer instead of default."
  String get text_use_bt_printer => "Use Bluetooth Printer instead of default.";
  /// "Something went wrong..Please try again later!!"
  String get toast_try_again => "Something went wrong..Please try again later!!";
  /// "Error"
  String get general_error => "Error";
  /// "Network Error"
  String get toast_network_error => "Network Error";
  /// "Settings"
  String get menu_settings => "Settings";
  /// "menu_reset"
  String get menu_reset => "menu_reset";
  /// "Need Storage Permission"
  String get title_storage_premission => "Need Storage Permission";
  /// "Please provide storage permission to store receipt."
  String get text_permission_desc => "Please provide storage permission to store receipt.";
  /// "Grant"
  String get button_grant => "Grant";
  /// "Cancel"
  String get button_cancel => "Cancel";
  /// "Password"
  String get hint_password => "Password";
  /// "Login"
  String get button_login => "Login";
  /// "Re-print"
  String get re_print => "Re-print";
  /// "Print"
  String get text_print => "Print";
  /// "Bill Pay (Agent Copy)"
  String get text_agent_copy => "Bill Pay (Agent Copy)";
  /// "Transaction Summary"
  String get title_tran_summary => "Transaction Summary";
  /// "Select Printer"
  String get title_select_printer => "Select Printer";
  /// "Transaction Status"
  String get text_tran_status => "Transaction Status";
  /// "Please check for correct \ninformation and amount before\nyou leave. Thank you."
  String get text_terms_conn => "Please check for correct \ninformation and amount before\nyou leave. Thank you.";
  /// "Clear"
  String get menu_clear => "Clear";
  /// "Clear Transactions"
  String get text_clear_transactions => "Clear Transactions";
  /// "Are you sure you want to clear all transactions?"
  String get text_clear_trasactions_msg => "Are you sure you want to clear all transactions?";
  /// "Yes"
  String get button_yes => "Yes";
  /// "No"
  String get button_no => "No";
  /// "Agent Copy"
  String get text_print_agent_copy => "Agent Copy";
  /// "Agent Balance"
  String get text_agent_balance => "Agent Balance";
  /// "Bill Pay (Customer Copy)"
  String get text_customer_copy => "Bill Pay (Customer Copy)";
  /// "Transaction declined"
  String get toast_tran_declined => "Transaction declined";
  /// "Duplicate Copy"
  String get text_duplicate => "Duplicate Copy";
  /// "Agent Fee"
  String get text_agent_fee => "Agent Fee";
  /// "Fee"
  String get text_fee => "Fee";
  /// "Date Range"
  String get menu_date => "Date Range";
  /// "Date range cannot be greater than ${days} days"
  String toast_date_range(String days) => "Date range cannot be greater than ${days} days";
  /// "Agent Information"
  String get agent_info => "Agent Information";
  /// "Confirm Logout?"
  String get text_logout => "Confirm Logout?";
  /// "Yes"
  String get text_yes => "Yes";
  /// "No"
  String get text_no => "No";
  /// "Information"
  String get text_add_info => "Information";
  /// "Settings"
  String get title_activity_settings => "Settings";
  /// "LyHour Store not installed"
  String get toast_store_not_installed => "LyHour Store not installed";
  /// "Select device for reading QR Code"
  String get text_select_device_text => "Select device for reading QR Code";
  /// "Processing"
  String get text_processing => "Processing";
  /// "Additional Reference No"
  String get text_add_ref_no_print => "Additional Reference No";
  /// "Additional\nReference No"
  String get text_add_ref_no => "Additional\nReference No";
  /// "Additional Service Type"
  String get text_add_service_type => "Additional Service Type";
  /// "Scan QRCode"
  String get text_scan_qrcode => "Scan QRCode";
  /// "Scan Cancelled"
  String get text_scan_cancelled => "Scan Cancelled";
  /// "Invalid QRCode"
  String get text_invalid_qrcode => "Invalid QRCode";
  /// "Invalid Ticket No"
  String get text_invalid_ticket_no => "Invalid Ticket No";
  /// "Version ${version}"
  String text_version(String version) => "Version ${version}";
  /// "Update"
  String get text_update => "Update";
  /// "DID"
  String get text_device_id => "DID";
  /// "QR Reader"
  String get pref_qr_reader => "QR Reader";
  /// "Public"
  String get text_public => "Public";
  /// "Local"
  String get text_local => "Local";
  /// "Overflow"
  String get text_overflow => "Overflow";
  /// "Printing"
  String get toast_printing => "Printing";
  /// "Date"
  String get text_date_time => "Date";
  /// "Alert"
  String get msg_alert => "Alert";
  /// "Driver License"
  String get driver_license => "Driver License";
  /// "Vehicle Registration"
  String get vehicle_registration => "Vehicle Registration";
  /// "Technical Inspection"
  String get techinal_inspection => "Technical Inspection";
  /// "Transport License"
  String get transport_license => "Transport License";
  /// "Camera"
  String get camera => "Camera";
  /// "Barcode Reader"
  String get barcode_reader => "Barcode Reader";
  /// "Both"
  String get both => "Both";
  /// "Submit"
  String get button_submit => "Submit";
  /// "Connection Timeout"
  String get text_timeout => "Connection Timeout";
  /// "Permission Denied"
  String get msg_permission_denied => "Permission Denied";
  /// "Scan Cancelled By User"
  String get scan_cancelled => "Scan Cancelled By User";
  /// ["Select Service", "Driver License", "Vehicle Registration", "Technical Inspection", "Transport License"]
  List<String> get service_types => ["Select Service", "Driver License", "Vehicle Registration", "Technical Inspection", "Transport License"];
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_km_KH extends I18n {
  const _I18n_km_KH();

  /// "កំពុង​ស្វែងរកឧបករណ៍​&#8230;"
  @override
  String get scanning => "កំពុង​ស្វែងរកឧបករណ៍​&#8230;";
  /// "ជ្រើស​ឧបករណ៍​ដែល​បាន​ភ្ជាប់"
  @override
  String get select_device => "ជ្រើស​ឧបករណ៍​ដែល​បាន​ភ្ជាប់";
  /// "គ្មាន​ឧបករណ៍ត្រឹមត្រូវ"
  @override
  String get none_paired => "គ្មាន​ឧបករណ៍ត្រឹមត្រូវ";
  /// "ស្វែងរក​ឧបករណ៍​មិនបានសម្រេច"
  @override
  String get none_found => "ស្វែងរក​ឧបករណ៍​មិនបានសម្រេច";
  /// "ឧបករណ៍​​ធ្លាប់​ភ្ជាប់"
  @override
  String get title_paired_devices => "ឧបករណ៍​​ធ្លាប់​ភ្ជាប់";
  /// "ឧបករណ៍ផ្សេង​"
  @override
  String get title_other_devices => "ឧបករណ៍ផ្សេង​";
  /// "ស្វែងរក​ឧបករណ៍"
  @override
  String get button_scan => "ស្វែងរក​ឧបករណ៍";
  /// "ព័ត៌មាន​បញ្ចូល​មិន​ត្រឹមត្រូវ"
  @override
  String get msg_state => "ព័ត៌មាន​បញ្ចូល​មិន​ត្រឹមត្រូវ";
  /// "សូម​ភ្ជាប់​ម៉ាស៊ីន​បោះពុម្ព Bluetooth"
  @override
  String get not_connected => "សូម​ភ្ជាប់​ម៉ាស៊ីន​បោះពុម្ព Bluetooth";
  /// "Bluetooth មិន​ដំណើរការ, បិទ​កម្មវិធី"
  @override
  String get bt_not_enabled_leaving => "Bluetooth មិន​ដំណើរការ, បិទ​កម្មវិធី";
  /// "កំពុងភ្ជាប់…"
  @override
  String get title_connecting => "កំពុងភ្ជាប់…";
  /// "ឧបករណ៍ ${name} បាន​ភ្ជាប់"
  @override
  String title_connected_to_printer(String name) => "ឧបករណ៍ ${name} បាន​ភ្ជាប់";
  /// "មិន​បាន​ភ្ជាប់"
  @override
  String get title_not_connected => "មិន​បាន​ភ្ជាប់";
  /// "​ម៉ាស៊ីន​បោះពុម្ព Bluetooth បាន​ភ្ជាប់"
  @override
  String get Connecting => "​ម៉ាស៊ីន​បោះពុម្ព Bluetooth បាន​ភ្ជាប់";
  /// "kh"
  @override
  String get strLang => "kh";
  /// "ព័ត៌មាន​បញ្ចូល​មិន​ត្រឹមត្រូវ, សូមពិនិត្យឡើងវិញ!"
  @override
  String get msg_error => "ព័ត៌មាន​បញ្ចូល​មិន​ត្រឹមត្រូវ, សូមពិនិត្យឡើងវិញ!";
  /// "លេខសម្គាល់​ភ្នាក់ងារ"
  @override
  String get text_agent_id => "លេខសម្គាល់​ភ្នាក់ងារ";
  /// "លេខ​ម៉ាស៊ីន​បោះពុម្ព​"
  @override
  String get text_printer_address => "លេខ​ម៉ាស៊ីន​បោះពុម្ព​";
  /// "លេខសម្គាល់​ភ្នាក់ងារ ឬ លេខសម្ងាត់ពុំ​ត្រឹមត្រូវ"
  @override
  String get toast_missing_credentials => "លេខសម្គាល់​ភ្នាក់ងារ ឬ លេខសម្ងាត់ពុំ​ត្រឹមត្រូវ";
  /// "លេខវិក្កយបត្រ"
  @override
  String get text_ticket_no => "លេខវិក្កយបត្រ";
  /// "ប្រភេទសេវាកម្ម"
  @override
  String get text_service_type => "ប្រភេទសេវាកម្ម";
  /// "ទូរស័ព្ទដៃ"
  @override
  String get text_customer_mobile => "ទូរស័ព្ទដៃ";
  /// "សូម​បញ្ចូល​លេខ​សំបុត្រ"
  @override
  String get toast_ticket_no_empty => "សូម​បញ្ចូល​លេខ​សំបុត្រ";
  /// "ឈ្មោះ​អតិថិជន"
  @override
  String get text_customer_name => "ឈ្មោះ​អតិថិជន";
  /// "រូបិយប័ណ្ណ"
  @override
  String get text_currency => "រូបិយប័ណ្ណ";
  /// "ចំនួន​ទឹកប្រាក់"
  @override
  String get text_amount => "ចំនួន​ទឹកប្រាក់";
  /// "កម្រៃ"
  @override
  String get text_fees => "កម្រៃ";
  /// "ចំនួន​ទឹកប្រាក់​សរុប"
  @override
  String get text_total_amount => "ចំនួន​ទឹកប្រាក់​សរុប";
  /// "សូមបញ្ចូលលេខសម្ងាត់ប្រតិបត្តិការ"
  @override
  String get text_input_pin => "សូមបញ្ចូលលេខសម្ងាត់ប្រតិបត្តិការ";
  /// "យល់ព្រម"
  @override
  String get text_ok => "យល់ព្រម";
  /// "សូម​បញ្ចូល​​លេខ​សម្ងាត់"
  @override
  String get text_pin_empty => "សូម​បញ្ចូល​​លេខ​សម្ងាត់";
  /// "​លេខ​សម្ងាត់​មិន​ត្រឹមត្រូវ"
  @override
  String get text_incorrect_pin => "​លេខ​សម្ងាត់​មិន​ត្រឹមត្រូវ";
  /// "ប្រតិបត្តិការជោគជ័យ"
  @override
  String get toast_tran_success => "ប្រតិបត្តិការជោគជ័យ";
  /// "សូម​បញ្ចូល​លេខ​ទូរស័ព្ទ​"
  @override
  String get toast_mobile_empty => "សូម​បញ្ចូល​លេខ​ទូរស័ព្ទ​";
  /// "Bluetooth មិន​ទាន់ប្រើ​បាន"
  @override
  String get tost_bt_not_available => "Bluetooth មិន​ទាន់ប្រើ​បាន";
  /// "ការ​ភ្ជាប់​ទៅ​​ឧបករណ៍​បានកាត់ផ្ដាច់"
  @override
  String get toast_conn_lost => "ការ​ភ្ជាប់​ទៅ​​ឧបករណ៍​បានកាត់ផ្ដាច់";
  /// "ពុំ​អាច​ភ្ជាប់​ជាមួយ​ឧបករណ៍​បាន"
  @override
  String get toast_unable_to_conn => "ពុំ​អាច​ភ្ជាប់​ជាមួយ​ឧបករណ៍​បាន";
  /// "បោះពុម្ព​សាកល្បង​បាន​សម្រេច"
  @override
  String get sample_print => "បោះពុម្ព​សាកល្បង​បាន​សម្រេច";
  /// "លេខទូរស័ព្ទភ្នាក់ងារ"
  @override
  String get text_agent_no => "លេខទូរស័ព្ទភ្នាក់ងារ";
  /// "លេខ​ប្រតិបត្តិការ"
  @override
  String get text_tran_id => "លេខ​ប្រតិបត្តិការ";
  /// "បោះពុម្ព​បង្កាន់ដៃ"
  @override
  String get title_print_receipt => "បោះពុម្ព​បង្កាន់ដៃ";
  /// "សូមជ្រើសរើសប្រភេទសេវាកម្ម"
  @override
  String get toast_service_empty => "សូមជ្រើសរើសប្រភេទសេវាកម្ម";
  /// "គ្មានប្រតិបត្តិការទេ"
  @override
  String get text_no_transactions => "គ្មានប្រតិបត្តិការទេ";
  /// "QRCode អានពេលវេលា"
  @override
  String get toast_read_timeout => "QRCode អានពេលវេលា";
  /// "ម៉ាស៊ីន​បោះពុម្ពមិនទាន់បានជ្រើសរើស"
  @override
  String get text_printer_not_config => "ម៉ាស៊ីន​បោះពុម្ពមិនទាន់បានជ្រើសរើស";
  /// "ម៉ាស៊ីន​បោះពុម្ព Bluetooth"
  @override
  String get text_bt_printer => "ម៉ាស៊ីន​បោះពុម្ព Bluetooth";
  /// "បោះពុម្ពជាមួយម៉ាស៊ីន​បោះពុម្ព Bluetooth"
  @override
  String get text_use_bt_printer => "បោះពុម្ពជាមួយម៉ាស៊ីន​បោះពុម្ព Bluetooth";
  /// "ដំណើរ​ការ​មាន​បញ្ហា..សូម​ព្យាយាម​ម្ដង​ទៀត!!"
  @override
  String get toast_try_again => "ដំណើរ​ការ​មាន​បញ្ហា..សូម​ព្យាយាម​ម្ដង​ទៀត!!";
  /// "កំហុស"
  @override
  String get general_error => "កំហុស";
  /// "សេវាទូរស័ព្ទឬអ៊ិនធឺណែតមានបញ្ហ សូមធ្វើប្រតិបត្តិការម្តងទៀត"
  @override
  String get toast_network_error => "សេវាទូរស័ព្ទឬអ៊ិនធឺណែតមានបញ្ហ សូមធ្វើប្រតិបត្តិការម្តងទៀត";
  /// "ការ​កំណត់"
  @override
  String get menu_settings => "ការ​កំណត់";
  /// "កំណត់​ឡើងវិញ"
  @override
  String get menu_reset => "កំណត់​ឡើងវិញ";
  /// "ត្រូវការ​សិទ្ធិ​ប្រើប្រាស់​កន្លែង​រក្សាទុកទិន្នន័យ"
  @override
  String get title_storage_premission => "ត្រូវការ​សិទ្ធិ​ប្រើប្រាស់​កន្លែង​រក្សាទុកទិន្នន័យ";
  /// "សូម​ផ្តល់​សិទ្ធិ​ប្រើប្រាស់​កន្លែង​រក្សាទុក​ទិន្នន័យ​បង្កាន់ដៃ"
  @override
  String get text_permission_desc => "សូម​ផ្តល់​សិទ្ធិ​ប្រើប្រាស់​កន្លែង​រក្សាទុក​ទិន្នន័យ​បង្កាន់ដៃ";
  /// "ផ្តល់​សិទ្ធិ​"
  @override
  String get button_grant => "ផ្តល់​សិទ្ធិ​";
  /// "បោះបង់"
  @override
  String get button_cancel => "បោះបង់";
  /// "លេខសម្ងាត់"
  @override
  String get hint_password => "លេខសម្ងាត់";
  /// "ចូលប្រើ"
  @override
  String get button_login => "ចូលប្រើ";
  /// "បោះពុម្ព​ម្ដងទៀត"
  @override
  String get re_print => "បោះពុម្ព​ម្ដងទៀត";
  /// "បោះពុម្ព"
  @override
  String get text_print => "បោះពុម្ព";
  /// "បង់វិក្កយបត្រ (សម្រាប់​ភ្នាក់ងារ)"
  @override
  String get text_agent_copy => "បង់វិក្កយបត្រ (សម្រាប់​ភ្នាក់ងារ)";
  /// "​ប្រតិបត្តិការ​សង្ខេប"
  @override
  String get title_tran_summary => "​ប្រតិបត្តិការ​សង្ខេប";
  /// "ជ្រើសរើស​​ម៉ាស៊ីន​បោះពុម្ព"
  @override
  String get title_select_printer => "ជ្រើសរើស​​ម៉ាស៊ីន​បោះពុម្ព";
  /// "ស្ថានភាព​ប្រតិបត្តិការ"
  @override
  String get text_tran_status => "ស្ថានភាព​ប្រតិបត្តិការ";
  /// "សូមពិនិត្យព័ត៌មាននិងទឹកប្រាក់ឲ្យ\nត្រឹមត្រូវមុនពេលចាកចេញ។\nសូមអរគុណ"
  @override
  String get text_terms_conn => "សូមពិនិត្យព័ត៌មាននិងទឹកប្រាក់ឲ្យ\nត្រឹមត្រូវមុនពេលចាកចេញ។\nសូមអរគុណ";
  /// "លុប"
  @override
  String get menu_clear => "លុប";
  /// "លុប​ប្រតិបត្តិការ"
  @override
  String get text_clear_transactions => "លុប​ប្រតិបត្តិការ";
  /// "តើ​លោកអ្នក​ពិត​ជា​ចង់​លុបប្រតិបត្តិការ​ទាំងអស់​?​"
  @override
  String get text_clear_trasactions_msg => "តើ​លោកអ្នក​ពិត​ជា​ចង់​លុបប្រតិបត្តិការ​ទាំងអស់​?​";
  /// "យល់ព្រម"
  @override
  String get button_yes => "យល់ព្រម";
  /// "ទេ"
  @override
  String get button_no => "ទេ";
  /// "សម្រាប់ភ្នាក់ងារ"
  @override
  String get text_print_agent_copy => "សម្រាប់ភ្នាក់ងារ";
  /// "សមតុល្យគណនីភ្នាក់ងារ"
  @override
  String get text_agent_balance => "សមតុល្យគណនីភ្នាក់ងារ";
  /// "បង់វិក្កយបត្រ (សម្រាប់អតិថិជន)"
  @override
  String get text_customer_copy => "បង់វិក្កយបត្រ (សម្រាប់អតិថិជន)";
  /// "ប្រតិបត្តិការបានបដិសេធ"
  @override
  String get toast_tran_declined => "ប្រតិបត្តិការបានបដិសេធ";
  /// "បោះពុម្ពឡើងវិញ"
  @override
  String get text_duplicate => "បោះពុម្ពឡើងវិញ";
  /// "កម្រៃភ្នាក់ងារ"
  @override
  String get text_agent_fee => "កម្រៃភ្នាក់ងារ";
  /// "កម្រៃ"
  @override
  String get text_fee => "កម្រៃ";
  /// "ជ្រើសរើសកាលបរិច្ឆេទ"
  @override
  String get menu_date => "ជ្រើសរើសកាលបរិច្ឆេទ";
  /// "សូមជ្រើសរើសថ្ងៃរបាយការណ៍មិនឲ្យលើសពី ${days} ថ្ងៃ"
  @override
  String toast_date_range(String days) => "សូមជ្រើសរើសថ្ងៃរបាយការណ៍មិនឲ្យលើសពី ${days} ថ្ងៃ";
  /// "ព័ត៌មានភ្នាក់ងារ"
  @override
  String get agent_info => "ព័ត៌មានភ្នាក់ងារ";
  /// "តើអ្នកចង់ចាកចេញពីកម្មវិធី?"
  @override
  String get text_logout => "តើអ្នកចង់ចាកចេញពីកម្មវិធី?";
  /// "បាទ"
  @override
  String get text_yes => "បាទ";
  /// "ទេ"
  @override
  String get text_no => "ទេ";
  /// "ព័ត៌មានបន្ថែម"
  @override
  String get text_add_info => "ព័ត៌មានបន្ថែម";
  /// "ការ​កំណត់"
  @override
  String get title_activity_settings => "ការ​កំណត់";
  /// "មិនមានកម្មវិធី LHPP Store ក្នុងឧបករណ៏"
  @override
  String get toast_store_not_installed => "មិនមានកម្មវិធី LHPP Store ក្នុងឧបករណ៏";
  /// "ជ្រើសរើសឧបករណ៍ស្កេនកូដ QR"
  @override
  String get text_select_device_text => "ជ្រើសរើសឧបករណ៍ស្កេនកូដ QR";
  /// "កំពុងដំណើរការ"
  @override
  String get text_processing => "កំពុងដំណើរការ";
  /// "លេខវិក្កយបត្របន្ថែម"
  @override
  String get text_add_ref_no_print => "លេខវិក្កយបត្របន្ថែម";
  /// "លេខវិក្កយបត្របន្ថែម"
  @override
  String get text_add_ref_no => "លេខវិក្កយបត្របន្ថែម";
  /// "សេវាកម្មបន្ធែម"
  @override
  String get text_add_service_type => "សេវាកម្មបន្ធែម";
  /// "កាលបរិច្ឆេទប្រតិបត្តិការ"
  @override
  String get text_date_time => "កាលបរិច្ឆេទប្រតិបត្តិការ";
  /// "សារជូនដំណឹង"
  @override
  String get msg_alert => "សារជូនដំណឹង";
  /// "ផ្តល់​ប័ណ្ណ​បើកបរ​យានយន្ត"
  @override
  String get driver_license => "ផ្តល់​ប័ណ្ណ​បើកបរ​យានយន្ត";
  /// "ចុះបញ្ជី​យានជំនិះ​"
  @override
  String get vehicle_registration => "ចុះបញ្ជី​យានជំនិះ​";
  /// "ត្រួតពិនិត្យ​លក្ខណៈ​បច្ចេកទេស​យានជំនិះ"
  @override
  String get techinal_inspection => "ត្រួតពិនិត្យ​លក្ខណៈ​បច្ចេកទេស​យានជំនិះ";
  /// "ផ្តល់​អាជ្ញាប័ណ្ណ​ដឹកជញ្ជូន"
  @override
  String get transport_license => "ផ្តល់​អាជ្ញាប័ណ្ណ​ដឹកជញ្ជូន";
  /// "Camera"
  @override
  String get camera => "Camera";
  /// "ឧបករណ៍ស្កេនកូដ"
  @override
  String get barcode_reader => "ឧបករណ៍ស្កេនកូដ";
  /// "Camera និង ឧបករណ៍ស្កេនកូដ"
  @override
  String get both => "Camera និង ឧបករណ៍ស្កេនកូដ";
  /// "បញ្ជូន"
  @override
  String get button_submit => "បញ្ជូន";
  /// "អានពេលវេលា"
  @override
  String get text_timeout => "អានពេលវេលា";
  /// "មិនមានសិទ្ធិអនុញ្ញាត"
  @override
  String get msg_permission_denied => "មិនមានសិទ្ធិអនុញ្ញាត";
  /// "ការស្កែនបានលុបចោល"
  @override
  String get scan_cancelled => "ការស្កែនបានលុបចោល";

  @override
  /// ["Select Service", "Driver License", "Vehicle Registration", "Technical Inspection", "Transport License"]
  List<String> get service_types => ["ប្រភេទសេវាកម្ម", "ផ្តល់​ប័ណ្ណ​បើកបរ​យានយន្ត", "ចុះបញ្ជី​យានជំនិះ​", "ត្រួតពិនិត្យ​លក្ខណៈ​បច្ចេកទេស​យានជំនិះ", "ផ្តល់​អាជ្ញាប័ណ្ណ​ដឹកជញ្ជូន"];

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", "US"),
      Locale("km", "KH")
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale.languageCode : "";
    if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("km_KH" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_km_KH());
    }
    else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("km" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_km_KH());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}