// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../thancoder_server.dart';

class PlatformApp {
  String packageName;
  String version;
  AppReleaseTypes type;
  PlatformApp({required this.packageName, required this.version, required this.type});

  factory PlatformApp.create({required String packageName, String version = '1.0.0'}) {
    return PlatformApp(
      packageName: packageName,
      version: version,
      type: AppReleaseTypes.getTypeFromCurrent,
    );
  }
}
