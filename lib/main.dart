import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thancoder_general_static_server/app/my_app.dart';
import 'package:thancoder_general_static_server/app/providers/app_provider.dart';
import 'package:thancoder_general_static_server/more_libs/setting_v1.2.0/setting.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

void main() async {
  await Setting.initSetting();

  // server
  final rootPath = await ServerFileServices.createDir(
    '${Directory.current.path}/server',
  );
  await ThancoderServer.instance.init(
    getRootServerDirPath: () => rootPath,
    getRootServerDirUrl: () => '',
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppProvider())],
      child: const MyApp(),
    ),
  );
}
