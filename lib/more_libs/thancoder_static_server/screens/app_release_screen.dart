import 'package:flutter/material.dart';
import 'package:t_widgets/widgets/index.dart';
import 'package:than_pkg/than_pkg.dart';

import '../thancoder_server.dart';

class AppReleaseScreen extends StatefulWidget {
  ThancoderApp app;
  AppReleaseScreen({super.key, required this.app});

  @override
  State<AppReleaseScreen> createState() => _AppReleaseScreenState();
}

class _AppReleaseScreenState extends State<AppReleaseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Future<void> init() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.app.title}: Release List')),
      body: FutureBuilder(
        future: AppReleaseServices.getOnlineList(widget.app.id),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: TLoaderRandom());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text(asyncSnapshot.error.toString()));
          }
          final list = asyncSnapshot.data ?? [];

          return CustomScrollView(
            slivers: [
              // header
              SliverToBoxAdapter(child: _getCoverHeader()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _getDescWidget(),
                ),
              ),
              SliverToBoxAdapter(child: Divider()),

              SliverList.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => AppReleaseListItem(
                  release: list[index],
                  onDownloadClicked: _onDownload,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getCoverHeader() {
    return FutureBuilder(
      future: AppReleaseServices.getOnlineCoverList(widget.app.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final list = snapshot.data ?? [];
          if (list.isNotEmpty) {
            return CoverView(list: list);
          }
        }
        // not found
        return TImageFile(path: widget.app.getCoverPath, size: 150);
      },
    );
  }

  Widget _getDescWidget() {
    if (widget.app.desc.isEmpty) {
      return SizedBox.shrink();
    }
    if (ThancoderServer.instance.getExpandableTextWidget != null) {
      return ThancoderServer.instance.getExpandableTextWidget!(widget.app.desc);
    }
    return Text(widget.app.desc);
  }

  void _onDownload(AppRelease release) {
    try {
      if (release.downloadUrl.isEmpty) return;
      ThanPkg.platform.launch(release.downloadUrl);
    } catch (e) {
      ThancoderServer.showDebugLog(
        e.toString(),
        tag: 'AppReleaseScreen:_onDownload',
      );
    }
  }
}
