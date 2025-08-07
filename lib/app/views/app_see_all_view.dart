import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class AppSeeAllView extends StatelessWidget {
  List<ThancoderApp> list;
  void Function(String title, List<ThancoderApp> list) onSeeAllClicked;
  void Function(ThancoderApp app) onClicked;
  void Function(ThancoderApp app)? onRightClicked;
  AppSeeAllView({
    super.key,
    required this.list,
    required this.onSeeAllClicked,
    required this.onClicked,
    this.onRightClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TSeeAllView<ThancoderApp>(
        title: 'App',
        list: list,
        showCount: 4,
        onSeeAllClicked: onSeeAllClicked,
        gridItemBuilder: (context, item) => AppGridItem(
          isLocal: true,
          app: item,
          onClicked: onClicked,
          onRightClicked: onRightClicked,
        ),
      ),
    );
  }
}
