
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:tvmaze_app/screens/login_screen.dart';
import 'package:tvmaze_app/util/colors_util.dart';
import 'package:tvmaze_app/util/global_scaffold_util.dart';

const directoryForSupportedLocales = '/directory/for/supported/locales';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: ColorsUtil.green,
    ));

    this._customInit();

    Intl.defaultLocale = 'pt_BR';

    super.initState();
  }

  _customInit() async {
    navigatorPlus.addKey(this._navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterAppPlus(
      debugShowCheckedModeBanner: false,
      title: 'Tv Maze App',
      navigatorKey: this._navigatorKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        canvasColor: Colors.transparent,
      ),
      builder: (context, child) {
        return Scaffold(
          key: GlobalScaffoldUtil.instance.scaffoldKey,
          body: child,
        );
      },
      home: Observer(
        builder: (_) {
          return LoginScreen();
        },
      ),
    );
  }
}
