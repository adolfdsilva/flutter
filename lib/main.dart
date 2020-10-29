import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mpwt/model/network.dart';
import 'package:mpwt/utils/constants.dart' as prefix0;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'colors.dart';
import 'package:mpwt/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mpwt/model/login.dart';
import 'dart:convert';
import 'mainmenu.dart';
import 'package:flutter/services.dart';
import 'generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:package_info/package_info.dart';

final localeSubject = BehaviorSubject<String>();
String lang;

void main() => runApp(Mpwt());

class Mpwt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder<String>(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            return StreamBuilder<String>(
                initialData: snapshot.data,
                stream: localeSubject,
                builder: (context, locale) {
                  I18n.locale = Locale(locale.data);
                  return MaterialApp(
                      locale: Locale(locale.data),
                      localizationsDelegates: [
                        I18n.delegate,
                        GlobalMaterialLocalizations.delegate
                      ],
                      supportedLocales: I18n.delegate.supportedLocales,
                      localeResolutionCallback: I18n.delegate
                          .resolution(fallback: Locale('en', 'US')),
                      theme: ThemeData(
                        primaryColor: colorPrimary,
                        primaryColorDark: colorPrimaryDark,
                        accentColor: colorAccent,
                        inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                        ),
                      ),
                      home: Scaffold(
                        resizeToAvoidBottomInset: false,
                        backgroundColor: colorPrimary,
                        body: LoginPage(),
                      ));
                });
          }
        });
  }

  Future<String> init() async {
    //get app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    prefix0.appName = '${packageInfo.appName} ${packageInfo.version}';
    //get device id
    String udid = await FlutterUdid.udid;
    final hash = md5.convert(utf8.encode(udid)).toString();
    device_id = hash.substring(0, 16);

    //get lang preference
    final preference = await SharedPreferences.getInstance();
    lang = preference.getString(locale);
    if (lang == null) {
      return LOCAL_EN;
    } else
      return lang;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum ip { local, public }

class _LoginPageState extends State<LoginPage> {
  String _username;
  String _password;
  ip _ipSelection = ip.local;
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<ip>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onSelected: (ip result) {
                  setState(() {
                    _ipSelection = result;
                  });
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      value: ip.local,
                      child: Row(
                        children: <Widget>[
                          _ipSelection == ip.local
                              ? Icon(Icons.check)
                              : Container(),
                          Container(
                            width: 8.0,
                          ),
                          Text(I18n.of(context).text_local),
                        ],
                      )),
                  PopupMenuItem(
                      value: ip.public,
                      child: Row(
                        children: <Widget>[
                          _ipSelection == ip.public
                              ? Icon(Icons.check)
                              : Container(),
                          Container(
                            width: 8.0,
                          ),
                          Text(I18n.of(context).text_public),
                        ],
                      ))
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 40),
          child: Image(
            image: AssetImage('images/logo_no_bg_no_stroke.png'),
            width: 200,
            height: 120,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: TextField(
            cursorColor: colorAccent,
            onChanged: (text) {
              _username = text;
            },
            style: TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              labelText: I18n.of(context).text_agent_id,
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
            autocorrect: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: TextField(
            controller: _passwordController,
            cursorColor: colorAccent,
            onChanged: (text) {
              _password = text;
            },
            style: TextStyle(color: Colors.white, fontSize: 18),
            obscureText: true,
            decoration: InputDecoration(
              labelText: I18n.of(context).hint_password,
              icon: Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
            ),
            autocorrect: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: FloatingActionButton(
            onPressed: () {
              if (_username == null ||
                  _username.isEmpty ||
                  _password == null ||
                  _password.isEmpty) {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(I18n.of(context).toast_missing_credentials)));
              } else
                login(context);
            },
            child: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        RoundButton(),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  prefix0.appName,
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  height: 4,
                ),
                SelectableText(
                  prefix0.device_id,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Container(
                  height: 4,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void login(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));

    var loginRequest = LoginRequest(username: _username, password: _password);

    device_id = '9d7cc09a88fe79c0';
    loginRequest.deviceId = device_id;
    print("deviceID: ${loginRequest.deviceId}");

    print(loginRequest.toJson());

    try {
      http.Response response = await http.post(
//        '$url/login',
        'http://www.mocky.io/v2/5db66f272f00005e007fe812',
        body: json.encode(loginRequest.toJson()),
        headers: {'Content-type': 'application/json'},
      ).timeout(
        Duration(seconds: timeout),
      );

      Navigator.pop(context);
      if (response.statusCode == 200) {
        //        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Success')));
        print(response.body);
        final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
        agent_no = loginResponse.mob;

        _passwordController.text = "";
        _password = "";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainMenu(),
                settings:
                    RouteSettings(name: 'mainmenu', arguments: loginResponse)));
      } else {
        final networkError =
            NetworkError.fromJson(response.statusCode, response.body);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(networkError.errorMsg)));
      }
    } on TimeoutException catch (_) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(I18n.of(context).toast_network_error)));
      Navigator.pop(context);
    } on Exception catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong. Please try again later!!')));
      Navigator.pop(context);
      print(e);
    }
  }

//  Future<http.Response> _onTimeout() {
//    return Future.error(http.Response('Timeout', 400));
//  }

}

class RoundButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RoundButton();
  }
}

class _RoundButton extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: langButtonSize,
            height: langButtonSize,
//            margin: EdgeInsets.all(5),
            child: IconButton(
              icon: Image.asset(
                'images/ic_en.png',
              ),
              onPressed: () {
                setState(() {
                  lang = LOCAL_EN;
                  print("language $lang");
                  savePref(lang);
                });
              },
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: lang == LOCAL_EN || lang == null ? Colors.white : Colors.transparent,
                    width: 2))),
        Container(
            width: langButtonSize,
            height: langButtonSize,
//            margin: EdgeInsets.all(5),
            child: IconButton(
              icon: Image.asset(
                'images/ic_kh.png',
              ),
              onPressed: () {
                setState(() {
                  lang = LOCAL_KM;
                  print("language $lang");
                  savePref(lang);
                });
              },
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: lang == LOCAL_KM ? Colors.white : Colors.transparent,
                    width: 2))),
      ],
    );
  }

  void savePref(String lang) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(locale, lang);
    localeSubject.add(lang);
    localeSubject.stream.distinct();
  }
}
