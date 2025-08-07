// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:than_pkg/than_pkg.dart';
import 'package:uuid/uuid.dart';

import '../thancoder_server.dart';

class ThancoderApp {
  String id;
  String title;
  String desc;
  String coverUrl;
  String githubUrl;
  String packageName;
  DateTime date;
  ThancoderApp({
    required this.id,
    required this.title,
    required this.desc,
    required this.coverUrl,
    required this.githubUrl,
    required this.packageName,
    required this.date,
  });
  factory ThancoderApp.create({
    String title = 'Untitled',
    String desc = '',
    String coverUrl = '',
    String githubUrl = '',
    String packageName= '',
  }) {
    final id = Uuid().v4();
    return ThancoderApp(
      id: id,
      title: title,
      desc: desc,
      coverUrl: ServerFileServices.getServerFilesUrl('$id.png'),
      githubUrl: githubUrl,
      packageName: packageName,
      date: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'coverUrl': coverUrl,
      'githubUrl': githubUrl,
      "packageName": packageName,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory ThancoderApp.fromMap(Map<String, dynamic> map) {
    return ThancoderApp(
      id: map['id'] as String,
      title: map['title'] as String,
      desc: map['desc'] as String,
      coverUrl: map['coverUrl'] as String,
      packageName: MapServices.getString(map, ['packageName']),
      githubUrl: MapServices.getString(map, ['githubUrl']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ThancoderApp.fromJson(String source) =>
      ThancoderApp.fromMap(json.decode(source) as Map<String, dynamic>);

  String get getCoverPath {
    return ServerFileServices.getFilesPath('$id.png');
  }

  String get getServerCoverUrl {
    return ServerFileServices.getServerFilesUrl('$id.png');
  }

  Future<void> deleteAll() async {
    await AppRelease.deleteAll(id);
  }
}
