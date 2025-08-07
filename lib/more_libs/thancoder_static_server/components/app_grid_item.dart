import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

import '../types/thancoder_app.dart';

class AppGridItem extends StatelessWidget {
  ThancoderApp app;
  void Function(ThancoderApp app) onClicked;
  void Function(ThancoderApp app)? onRightClicked;
  bool isLocal;
  AppGridItem({
    super.key,
    required this.app,
    required this.onClicked,
    this.onRightClicked,
    this.isLocal = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(app),
      onSecondaryTap: () {
        if (onRightClicked == null) return;
        onRightClicked!(app);
      },
      onLongPress: () {
        if (onRightClicked == null) return;
        onRightClicked!(app);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          children: [
            Positioned.fill(
              child: TImage(source: isLocal ? app.getCoverPath : app.coverUrl),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Text(
                app.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
