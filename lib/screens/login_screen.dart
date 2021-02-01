import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:toast/toast.dart';
import 'package:tvmaze_app/screens/tv_shows_screen.dart';
import 'package:tvmaze_app/util/colors_util.dart';
import 'package:tvmaze_app/util/local_storage_util.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _textEditingControllerPin = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = true;
  bool _hasPin = false;

  @override
  void initState() {
    _checkBiometrics();
    localStoragePlus.containsKey("PIN").then((hasPin) {
      setState(() {
        _hasPin = hasPin;
      });
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsUtil.green,
      child: SingleChildScrollView(
        child: ContainerPlus(
          color: ColorsUtil.green,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                width: 300,
                height: 300,
                child: Image.asset('assets/images/tvm_logo.png'),
              ),
              SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  TextFieldPlus(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 60,
                    controller: _textEditingControllerPin,
                    backgroundColor: ColorsUtil.white,
                    maxLines: 1,
                    textColor: Colors.green,
                    obscureText: true,
                    textInputType: TextInputType.number,
                    placeholder: TextPlus(
                      'PIN',
                      color: ColorsUtil.green,
                    ),
                    suffixWidget: _canCheckBiometrics
                        ? InkWell(
                            onTap: () {
                              _authenticate();
                            },
                            child: Icon(
                              Icons.fingerprint,
                              color: ColorsUtil.green,
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Log in',
                    style: TextStyle(color: ColorsUtil.green, fontSize: 30),
                  )
                ],
              ),
              ContainerPlus(
                radius: RadiusPlus.all(8),
                padding: EdgeInsets.all(8),
                color: ColorsUtil.white,
                child: Column(
                  children: [
                    Text(
                      _hasPin ? 'Log in' : 'Create PIN',
                      style: TextStyle(color: ColorsUtil.green, fontSize: 30),
                    )
                  ],
                ),
                onTap: () async {

                  String pin = _textEditingControllerPin.text;

                  if (pin.isEmpty) {
                    Toast.show("Please type in your PIN", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  } else {
                    if (_hasPin) {
                      String savedPin = await localStoragePlus.read("PIN");
                      if (savedPin == pin) {
                        loggedIn();
                      }
                    } else {
                      localStoragePlus.write("PIN", pin);
                      loggedIn();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    _canCheckBiometrics = canCheckBiometrics;

    if (_canCheckBiometrics) {
      _authenticate();
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    if (authenticated) {
      localStorageUtil.storePin("generatedPin");
      loggedIn();
    }
  }

  void loggedIn() {
    navigatorPlus.show(TvShowsScreen());
  }
}
