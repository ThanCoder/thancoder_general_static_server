import 'package:flutter/material.dart';
import 'package:thancoder_general_static_server/app/screens/home/home_screen.dart';
import 'package:thancoder_general_static_server/more_libs/setting_v2.1.0/setting.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Setting.getAppConfigNotifier,
      builder: (context, config, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: config.isDarkTheme ? ThemeData.dark() : null,
          // themeMode: ThemeMode.dark,
          home: HomeScreen(),
        );
      },
    );
  }
}
