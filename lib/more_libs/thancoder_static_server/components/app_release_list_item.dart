import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class AppReleaseListItem extends StatelessWidget {
  AppRelease release;
  void Function(AppRelease release)? onRightClicked;
  void Function(AppRelease release)? onDownloadClicked;
  void Function(AppRelease release)? onEditClicked;
  AppReleaseListItem({
    super.key,
    required this.release,
    this.onRightClicked,
    this.onDownloadClicked,
    this.onEditClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTap: () {
        if (onRightClicked == null) return;
        onRightClicked!(release);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TImage(source: release.getCoverPath, size: 120),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      release.title,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Version: ${release.version}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Type: ${release.type.name}'),
                    Text('Direct Link: ${release.isDirectLink}'),
                    Text(
                      'Size: ${release.size}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Date: ${release.date.toParseTime()}'),
                    _getButtonWidget(),
                    _getDescWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDescWidget() {
    if (release.desc.isEmpty) {
      return SizedBox.shrink();
    }
    if (ThancoderServer.instance.getExpandableTextWidget != null) {
      return ThancoderServer.instance.getExpandableTextWidget!(release.desc);
    }
    return Container(
      color: Colors.white.withValues(alpha: 0.1),
      child: Text(release.desc, style: TextStyle(fontStyle: FontStyle.italic)),
    );
  }

  Widget _getButtonWidget() {
    return Wrap(
      children: [
        onDownloadClicked == null
            ? SizedBox.shrink()
            : IconButton(
                onPressed: () => onDownloadClicked!(release),
                icon: Icon(Icons.download),
              ),
        onEditClicked == null
            ? SizedBox.shrink()
            : IconButton(
                onPressed: () => onEditClicked!(release),
                icon: Icon(Icons.edit),
              ),
      ],
    );
  }
}
