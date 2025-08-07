// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';

import '../thancoder_server.dart';

class AppRelease {
  String id;
  String appId;
  String title;
  String desc;
  String coverUrl;
  String downloadUrl;
  bool isDirectLink;
  String size;
  String version;
  AppReleaseTypes type;
  DateTime date;
  AppRelease({
    required this.id,
    required this.appId,
    required this.title,
    required this.desc,
    required this.coverUrl,
    required this.downloadUrl,
    required this.isDirectLink,
    required this.size,
    required this.version,
    required this.type,
    required this.date,
  });

  factory AppRelease.create({
    required String appId,
    required bool isDirectLink,
    required AppReleaseTypes type,
    String title = 'Untitled',
    String desc = '',
    String coverUrl = '',
    String downloadUrl = '',
    String size = '0 MB',
    String version = '1.0.0',
  }) {
    final id = Uuid().v4();
    return AppRelease(
      id: id,
      appId: appId,
      title: title,
      desc: desc,
      coverUrl: coverUrl,
      downloadUrl: downloadUrl,
      isDirectLink: isDirectLink,
      size: size,
      version: version,
      type: type,
      date: DateTime.now(),
    );
  }

  // map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'appId': appId,
      'title': title,
      'desc': desc,
      'coverUrl': coverUrl,
      'downloadUrl': downloadUrl,
      'isDirectLink': isDirectLink,
      'size': size,
      'version': version,
      'type': type.name,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory AppRelease.fromMap(Map<String, dynamic> map) {
    final typeName = map['type'] ?? '';
    return AppRelease(
      id: map['id'] as String,
      appId: map['appId'] as String,
      title: map['title'] as String,
      desc: map['desc'] as String,
      coverUrl: map['coverUrl'] as String,
      downloadUrl: map['downloadUrl'] as String,
      isDirectLink: map['isDirectLink'] as bool,
      size: map['size'] as String,
      version: map['version'] as String,
      type: AppReleaseTypes.getTypeFromName(typeName),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppRelease.fromJson(String source) =>
      AppRelease.fromMap(json.decode(source) as Map<String, dynamic>);

  String get getCoverPath {
    return ServerFileServices.getFilesPath('$id.png');
  }

  String get getServerCoverUrl {
    return ServerFileServices.getServerFilesUrl('$id.png');
  }

  //
  static Future<void> deleteAll(String appId) async {
    try {
      final list = await AppReleaseServices.getList(appId);
      for (var item in list) {
        final file = File(ServerFileServices.getFilesPath('${item.id}.png'));
        if (await file.exists()) {
          await file.delete();
        }
      }
      // delete
      final dbFile = File(AppReleaseServices.getDBPath(appId));
      if(await dbFile.exists()){
        await dbFile.delete();
      }
    } catch (e) {
      ThancoderServer.showDebugLog(e.toString(), tag: 'AppRelease:deleteAll');
    }
  }
}
