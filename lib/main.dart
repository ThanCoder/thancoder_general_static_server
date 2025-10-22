import 'dart:io';

import 'package:flutter/material.dart';

import 'package:t_client/t_client.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:thancoder_general_static_server/app/my_app.dart';
import 'package:thancoder_general_static_server/more_libs/desktop_exe_1.0.1/desktop_exe.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/constants.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/general_server.dart';
import 'package:thancoder_general_static_server/more_libs/setting_v2.1.0/others/index.dart';
import 'package:thancoder_general_static_server/more_libs/setting_v2.1.0/setting.dart';
import 'package:thancoder_general_static_server/more_libs/terminal_app/terminal_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Setting.instance.initSetting(
    appName: 'thancoder_general_static_server',
    onShowMessage: (context, message) => showTSnackBar(context, message),
  );
  final client = TClient();

  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/thancoder_logo_3.png',
    getDarkMode: () => Setting.getAppConfig.isDarkTheme,
    getCachePath: () => PathUtil.getCachePath(),
    onDownloadImage: (url, savePath) async {
      // await Dio().download(url, savePath);
      await client.download(url, savePath: savePath);
    },
  );

  // server
  final rootDir = Directory('${Directory.current.path}/server');
  if (!rootDir.existsSync()) {
    await rootDir.create();
  }

  await GeneralServer.instance.init(
    getApiServerUrl: () => apiServerUrl,
    getLocalServerPath: () => localServerPath,
    getContentFromUrl: (url) async {
      final res = await client.get(url);
      return res.data.toString();
    },
  );

  // await ThancoderServer.instance.init(
  //   // showMessage: (context, message) {
  //   //   showTSnackBar(context, message);
  //   // },
  //   getContentFromUrl: (url) async {
  //     // final res = await Dio().get(url);
  //     final res = await client.get(url);
  //     return res.data.toString();
  //   },
  //   getExpandableTextWidget: (text) => ExpandableText(
  //     text,
  //     expandText: 'More',
  //     maxLines: 4,
  //     collapseOnTextTap: true,
  //   ),
  //   currentPlatform: PlatformApp.create(
  //     packageName: 'novel_v3',
  //     version: '2.0.0',
  //   ),
  //   getRootServerDirPath: () => rootDir.path,
  //   getRootServerDirUrl: () =>
  //       'https://raw.githubusercontent.com/ThanCoder/thancoder_general_static_server/refs/heads/main/server',
  // );

  // terminal
  await TerminalApp.instance.init(
    getBashCommand: () =>
        "git add . && git commit -m 'update' && git push -u origin main",
    getExecPath: () =>
        Directory(Setting.getAppConfig.serverRootPath).parent.path,
  );

  await DesktopExe.instance.export(
    name: 'thancoder_general_static_server',
    assetsIconPath: 'assets/thancoder_logo_1.png',
  );

  if (TPlatform.isDesktop) {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(602, 568), // စတင်ဖွင့်တဲ့အချိန် window size

      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      center: false,
      title: "General Static Server",
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}
