import 'dart:io';

enum AppReleaseTypes {
  android,
  linux,
  window,
  web;

  static AppReleaseTypes getTypeFromName(String name) {
    if (name == android.name) {
      return android;
    }
    if (name == linux.name) {
      return linux;
    }
    if (name == web.name) {
      return web;
    }
    if (name == window.name) {
      return window;
    }

    return AppReleaseTypes.android;
  }

  static AppReleaseTypes get getTypeFromCurrent {
    if (Platform.isAndroid) {
      return android;
    }
    if (Platform.isLinux) {
      return linux;
    }

    if (Platform.isWindows) {
      return window;
    }

    return AppReleaseTypes.android;
  }
}
