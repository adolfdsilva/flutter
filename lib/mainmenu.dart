import 'package:flutter/material.dart';
import 'package:mpwt/generated/i18n.dart';
import 'package:mpwt/printscreen.dart';
import 'package:mpwt/txn_list.dart';
import 'package:mpwt/viewmodel/base_view_model.dart';
import 'package:mpwt/viewmodel/home_view_model.dart';
import 'colors.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'model/login.dart';
import 'package:intl/intl.dart';
import 'package:mpwt/utils/constants.dart';
import 'dart:async';
import 'bt_list.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:tuple/tuple.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final currencyFormatter = NumberFormat('###,###,###,###.##', 'en');

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final FocusNode _ticketNoText = FocusNode();
  final FocusNode _mobileText = FocusNode();
  final _ticketNoController = TextEditingController();
  final _mobileNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginResponse loginResponse = ModalRoute.of(context).settings.arguments;
    return ViewModelProvider<HomeViewModel>.withConsumer(
        onModelReady: (_) {
          checkIfPrinterConfigured().then((address) {
            if (address == null) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(I18n.of(context).text_printer_not_config),
                      content: Text(
                          'Please configure printer before doing Transactions'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(I18n.of(context).text_ok),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BluetoothList(),
                                ));
                          },
                        )
                      ],
                    );
                  });
            }
          });
        },
        viewModel: HomeViewModel(loginResponse),
        builder: (context, model, child) {
          print('Rebuilding Scaffold');
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            floatingActionButton: Builder(
              builder: (context) {
                if (model.isVerifyComplete)
                  //payment
                  return FloatingActionButton(
                      heroTag: 'fab_payment',
                      child: Icon(Icons.payment),
                      onPressed: () {
                        if (_mobileNoController.text.isEmpty) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(I18n.of(context).toast_mobile_empty)));
                        } else {
                          showTranPinAlert(context, loginResponse.pin, model);
                        }
                      });
                else
                  //verify
                  return FloatingActionButton(
                      heroTag: 'fab_verify',
                      child: Icon(Icons.check),
                      onPressed: () {
                        model.verify().then((error) {
                          if (error != null) {
                            var errMsg = '';
                            if (error.responseCode == invalidTicketNoCode) {
                              errMsg = I18n.of(context).text_invalid_ticket_no;
                            } else if (error.responseCode == timeoutCode) {
                              errMsg = I18n.of(context).toast_network_error;
                            } else {
                              errMsg = error.errorMsg;
                            }
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(errMsg),
                            ));
                          } else {
                            _ticketNoController.text = model.ticketNo;
                          }
                        });
                      });
              },
            ),
            body: KeyboardActions(
                config: _buildConfig(context),
                child: Column(
                  children: <Widget>[
                    AppBar(
                      title: Text(
                        'KHR ' + currencyFormatter.format(loginResponse.bal),
                        style: TextStyle(fontSize: 15),
                      ),
                      backgroundColor: colorPrimary,
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              _ticketNoController.text = '';
                              model.reset();
                            }),
                        IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BluetoothList(),
                                  ));
                            }),
                        IconButton(
                            icon: Icon(Icons.view_list),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransactionList(),
                                      settings: RouteSettings(
                                          name: 'transactions',
                                          arguments: loginResponse)));
                            })
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          DropdownButton<String>(
                              isExpanded: true,
                              value:
                                  I18n.of(context).service_types[model.service],
                              items: I18n.of(context)
                                  .service_types
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                model.setService = I18n.of(context)
                                    .service_types
                                    .indexOf(newValue);
                              }),
                          TicketNoTextField(_ticketNoController, _ticketNoText),
                          Container(
                            height: 20,
                          ),
                          TicketInformation(),
                          model.isVerifyComplete
                              ? TextFieldMobile(
                                  _mobileNoController, _mobileText)
                              : Container()
                        ],
                      ),
                    )
                  ],
                )),
          );
        });
  }

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _ticketNoText,
          closeWidget: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Done'),
          ),
        ),
        KeyboardAction(
          focusNode: _mobileText,
          closeWidget: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Done'),
          ),
        ),
      ],
    );
  }

  void showTranPinAlert(BuildContext context, String pin, HomeViewModel model) {
    final _tranPinController = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(I18n.of(context).text_input_pin),
            content: TextField(
              controller: _tranPinController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.black87, fontSize: 18),
              obscureText: true,
              autofocus: true,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
              ),
              autocorrect: false,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(I18n.of(context).button_submit),
                onPressed: () {
                  Navigator.pop(context);
                  if (_tranPinController.text == pin) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) =>
                            Center(child: CircularProgressIndicator()));
                    model.setMobileNo = _mobileNoController.text;
                    model.makePayment().then((networkError) {
                      if (networkError != null) {
                        Navigator.pop(context);
                        var errMsg = '';
                        if (networkError.responseCode == timeoutCode) {
                          errMsg = I18n.of(context).toast_network_error;
                        } else {
                          errMsg = networkError.errorMsg;
                        }
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(errMsg),
                        ));
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrintScreen(),
                                settings: RouteSettings(
                                    name: 'printscreen',
                                    arguments: model.listResponse)));
                        _ticketNoController.text = '';
                        model.reset();
                      }
                    });
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(I18n.of(context).text_incorrect_pin)));
                  }
                },
              )
            ],
          );
        });
  }

  Future<String> checkIfPrinterConfigured() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.get(address);
  }
}

class TextFieldMobile extends ProviderWidget<HomeViewModel> {
  final TextEditingController _mobileNoController;
  final FocusNode _mobileText;

  TextFieldMobile(
    this._mobileNoController,
    this._mobileText,
  );

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return TextField(
      controller: _mobileNoController,
      keyboardType: TextInputType.phone,
      focusNode: _mobileText,
      style: TextStyle(color: Colors.black87, fontSize: 18),
      decoration: InputDecoration(
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: colorAccent)),
        labelStyle: TextStyle(
            color: Colors.black38, fontWeight: FontWeight.w300, fontSize: 18),
        labelText: I18n.of(context).text_customer_mobile,
      ),
      textInputAction: TextInputAction.done,
    );
  }
}

class TicketNoTextField extends ProviderWidget<HomeViewModel> {
  final TextEditingController _ticketNoController;
  final FocusNode _ticketNoText;

  TicketNoTextField(this._ticketNoController, this._ticketNoText);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return TextField(
      controller: _ticketNoController,
      focusNode: _ticketNoText,
      enabled: !model.isVerifyComplete,
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      onChanged: (text) {
        if (text.length > 3) {
          model.setService = setService(text);
        }
        model.setTicketNo = text;
      },
      style: TextStyle(color: Colors.black87, fontSize: 18),
      decoration: InputDecoration(
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: colorAccent)),
        labelStyle: TextStyle(
            color: Colors.black38, fontWeight: FontWeight.w300, fontSize: 18),
        labelText: I18n.of(context).text_ticket_no,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.camera_alt,
            color: Colors.black38,
          ),
          onPressed: () {
            scanQRCode(context).then((barcode) {
              if (barcode.item1 != 0) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(barcode.item2),
                ));
              } else {
                _ticketNoController.text = barcode.item2;
                model.setService = setService(barcode.item2);
                model.setTicketNo = barcode.item2;
                model.verify();
              }
            });
          },
        ),
      ),
      autocorrect: false,
    );
  }
}

class TicketInformation extends ProviderWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    if (model.verifyResponse == null) if (model.state == ViewState.Idle)
      return Container();
    else
      return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: Iterable.generate(5)
                .map((i) => Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: next(100, 180).toDouble(),
                            height: 20,
                            color: Colors.white,
                          ),
                          Container(
                            width: next(50, 120).toDouble(),
                            height: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ))
                .toList(),
          ));
    else
      return GridView.count(
        primary: false,
        shrinkWrap: true,
        childAspectRatio: 5,
        crossAxisCount: 2,
        children: <Widget>[
          Text(I18n.of(context).text_customer_name),
          Text(
            model.verifyResponse.customerName,
            textAlign: TextAlign.end,
          ),
          Text(I18n.of(context).text_add_info),
          Text(
            model.verifyResponse.responseMsg,
            textAlign: TextAlign.end,
          ),
          Text(I18n.of(context).text_currency),
          Text(
            model.verifyResponse.currency,
            textAlign: TextAlign.end,
          ),
          Text(I18n.of(context).text_amount),
          Text(
            model.verifyResponse.amount == 0
                ? ''
                : currencyFormatter.format(model.verifyResponse.amount),
            textAlign: TextAlign.end,
          ),
          Text(I18n.of(context).text_fees),
          Text(
            model.verifyResponse.feesTotal == 0
                ? ''
                : currencyFormatter.format(model.verifyResponse.feesTotal),
            textAlign: TextAlign.end,
          ),
          Text(I18n.of(context).text_total_amount),
          Text(
            model.verifyResponse.total == 0
                ? ''
                : currencyFormatter.format(model.verifyResponse.total),
            textAlign: TextAlign.end,
          ),
        ],
      );
  }
}

Future<Tuple2<int, String>> scanQRCode(BuildContext context) async {
  try {
    String barcode = await BarcodeScanner.scan();
    print('barcode: $barcode');
    return Tuple2(0, barcode);
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      print('The user did not grant the camera permission!');
      return Tuple2(1, I18n.of(context).msg_permission_denied);
    } else {
      print('Unknown error: $e');
      return Tuple2(2, 'Unknown error: $e');
    }
  } on FormatException {
    print(
        'null (User returned using the "back"-button before scanning anything. Result)');
    return Tuple2(3, I18n.of(context).scan_cancelled);
  } catch (e) {
    print('Unknown error: $e');
    return Tuple2(2, 'Unknown error: $e');
  }
}

int setService(String refNo) {
  if (refNo.isEmpty) {
    return 0;
  }

  var firstChar = refNo[0];
  switch (firstChar) {
    case '8':
      return TRANSPORT_LIC;
    case '9':
      return TECH_INSP;
  }

  var thirdChar = refNo[2];
  switch (thirdChar) {
    case '1':
    case '2':
    case '4':
    case '5':
    case '6':
      return VEHICLE_REG;
    case '3':
    case '7':
      return DRIVER_LIC;
  }
  return 0;
}
