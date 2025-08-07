import 'dart:io';

import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:thancoder_general_static_server/app/my_app.dart';
import 'package:thancoder_general_static_server/app/providers/app_provider.dart';
import 'package:thancoder_general_static_server/app/providers/app_release_provider.dart';
import 'package:thancoder_general_static_server/more_libs/setting_v1.2.0/setting.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Setting.initSetting();

  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/thancoder_logo_3.png',
    getDarkMode: () => Setting.getAppConfig.isDarkTheme,
    onDownloadImage: (url, savePath) async {
      await Dio().download(url, savePath);
    },
  );

  // server
  final rootPath = await ServerFileServices.createDir(
    '${Directory.current.path}/server',
  );
  await ThancoderServer.instance.init(
    // showMessage: (context, message) {
    //   showTSnackBar(context, message);
    // },
    getContentFromUrl: (url) async {
      final res = await Dio().get(url);
      return res.data.toString();
    },
    getExpandableTextWidget: (text) => ExpandableText(
      text,
      expandText: 'More',
      maxLines: 4,
      collapseOnTextTap: true,
    ),
    getRootServerDirPath: () => rootPath,
    getRootServerDirUrl: () =>
        'https://raw.githubusercontent.com/ThanCoder/thancoder_general_static_server/refs/heads/main/server',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => AppReleaseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
