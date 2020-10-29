import 'package:flutter/material.dart';
import 'package:mpwt/generated/i18n.dart';
import 'package:plugins/plugins.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/constants.dart' as constants;

class BluetoothList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).title_select_printer),
      ),
      body: ListDevices(),
    );
  }
}

class ListDevices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListState();
}

class _ListState extends State<ListDevices> {
  final List<BluetoothDevice> btDeviceList = [];
  String address;
  SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      _preferences = pref;
      setState(() {
        address = _preferences.get(constants.address) ?? 'Not configured';
      });
    });
    getDeviceList();
  }

  @override
  Widget build(BuildContext context) {
    if (address == null) address = I18n.of(context).text_printer_not_config;

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Printer address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            address,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Text(
                  I18n.of(context).select_device,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final device = btDeviceList[index];
                return ListTile(
                  title: Text(device.name),
                  subtitle: Text(device.address),
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Center(child: CircularProgressIndicator());
                        });
                    Plugins.connect(device.address).then((onValue) {
                      saveBtAddress(device.address);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(onValue)));
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey,
                );
              },
              itemCount: btDeviceList.length),
        ),
      ],
    );
  }

  void getDeviceList() async {
    Plugins.scanBtDevices().listen((data) {
      print(data.toString());
      final json = jsonDecode(data as String);
      setState(() {
        btDeviceList.add(BluetoothDevice.fromJson(json));
      });
    }).onError((error) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  void saveBtAddress(String address) async {
    if (_preferences != null) {
      await _preferences.setString(constants.address, address);
      setState(() {
        this.address = address;
      });
    }
  }
}

class BluetoothDevice {
  String name;
  String address;

  BluetoothDevice(this.name, this.address);

  BluetoothDevice.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? 'No Name',
        address = json['address'];
}
