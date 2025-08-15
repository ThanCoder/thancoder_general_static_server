import 'package:flutter/material.dart';
import 'package:thancoder_general_static_server/app/screens/home/pages/local_page.dart';
import 'package:thancoder_general_static_server/more_libs/setting_v2.1.0/others/app_setting_screen.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [LocalPage(), ThancoderHomeScreen(), AppSettingScreen()],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.cloud_download)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
