import 'thancoder_app_types.dart';

class ThancoderAppRelease {
  String id;
  String appId;
  String title;
  String desc;
  String coverUrl;
  String downloadUrl;
  bool isDirectLink;
  String size;
  ThancoderAppTypes type;
  DateTime date;
  ThancoderAppRelease({
    required this.id,
    required this.appId,
    required this.title,
    required this.desc,
    required this.coverUrl,
    required this.downloadUrl,
    required this.isDirectLink,
    required this.size,
    required this.type,
    required this.date,
  });
}
