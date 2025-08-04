// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'thancoder_app_types.dart';

class ThancoderApp {
  String id;
  String title;
  String desc;
  String coverUrl;
  ThancoderAppTypes type;
  DateTime date;
  ThancoderApp({
    required this.id,
    required this.title,
    required this.desc,
    required this.coverUrl,
    required this.type,
    required this.date,
  });
  factory ThancoderApp.create({
    required ThancoderAppTypes type,
    String title = 'Untitled',
    String desc = '',
    String coverUrl = '',
  }) {
    return ThancoderApp(
      id: Uuid().v4(),
      title: title,
      desc: desc,
      coverUrl: '',
      type: type,
      date: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'type': type.name,
      'coverUrl': coverUrl,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory ThancoderApp.fromMap(Map<String, dynamic> map) {
    String type = map['type'] ?? '';
    return ThancoderApp(
      id: map['id'] as String,
      title: map['title'] as String,
      desc: map['desc'] as String,
      type: ThancoderAppTypes.getTypeFromName(type),
      coverUrl: map['coverUrl'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ThancoderApp.fromJson(String source) =>
      ThancoderApp.fromMap(json.decode(source) as Map<String, dynamic>);
}
