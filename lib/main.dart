import 'package:expocity/repositories/application_keys.dart';
import 'package:expocity/screens/base/base_screen.dart';
import 'package:expocity/stores/category_store.dart';
import 'package:expocity/stores/city_store.dart';
import 'package:expocity/stores/home_store.dart';
import 'package:expocity/stores/page_store.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'components/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(const MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton<PageStore>(PageStore());
  GetIt.I.registerSingleton<HomeStore>(HomeStore());
  GetIt.I.registerSingleton<UserManagerStore>(UserManagerStore());
  GetIt.I.registerSingleton<CategoryStore>(CategoryStore());
  GetIt.I.registerSingleton<CityStore>(CityStore());
}

Future<void> initializeParse() async {
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true, debug: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ExpoCity",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primaryColor: defaultColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: backgoundColor,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: defaultColor,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: defaultColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: defaultColor),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 3,
          color: defaultColor,
        ),
      ),
      home: BaseScreen(),
    );
  }
}
