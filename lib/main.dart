import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('pt_BR', null).then((_) => runApp(AppScreen()));
}
