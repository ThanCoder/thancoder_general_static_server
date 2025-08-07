import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class AppReleaseListItem extends StatelessWidget {
  AppRelease release;
  void Function(AppRelease release) onClicked;
  void Function(AppRelease release)? onRightClicked;
  AppReleaseListItem({
    super.key,
    required this.release,
    required this.onClicked,
    this.onRightClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(release),
      onSecondaryTap: () {
        if (onRightClicked == null) return;
        onRightClicked!(release);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 8,
              children: [
                TImage(source: release.getCoverPath,size: 130,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(release.title),
                      Text('Version: ${release.version}'),
                      Text('Type: ${release.type.name}'),
                      Text('Direct Link: ${release.isDirectLink}'),
                      Text('Size: ${release.size}'),
                      Text('Date: ${release.date.toParseTime()}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
