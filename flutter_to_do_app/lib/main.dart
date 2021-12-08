import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/db/db_helper.dart';
import 'package:flutter_to_do_app/services/theme_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'ui/home_page.dart';
import 'ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: Homepage(),
    );
  }
}
