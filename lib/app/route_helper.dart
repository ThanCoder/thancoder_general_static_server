import 'package:flutter/material.dart';
import 'package:thancoder_general_static_server/app/screens/forms/edit_app_screen.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

void goEditAppScreen(
  BuildContext context,
  ThancoderApp app, {
  required void Function(ThancoderApp updatedApp) onUpdated,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditAppScreen(app: app, onUpdated: onUpdated),
    ),
  );
}
