import 'package:flutter/material.dart';
import 'package:t_widgets/widgets/index.dart';
import 'package:than_pkg/than_pkg.dart';

import '../thancoder_server.dart';

class ThancoderHomeScreen extends StatefulWidget {
  const ThancoderHomeScreen({super.key});

  @override
  State<ThancoderHomeScreen> createState() => _ThancoderHomeScreenState();
}

class _ThancoderHomeScreenState extends State<ThancoderHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Future<void> init() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ThanCoder Static Server')),
      body: CustomScrollView(
        slivers: [
          // current platform
          SliverToBoxAdapter(child: _getCurrentPlatform()),
          // list
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: ThancoderAppServices.getOnlineList(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: TLoaderRandom());
                }
                if (asyncSnapshot.hasError) {
                  return Center(child: Text(asyncSnapshot.error.toString()));
                }
                final list = asyncSnapshot.data ?? [];
                return AppSeeAllView(
                  list: list,
                  onSeeAllClicked: (title, list) {},
                  onClicked: _goContentScreen,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCurrentPlatform() {
    final current = ThancoderServer.instance.currentPlatform;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ယခု Version'),
            Text('PackageName: ${current.packageName}'),
            Text('Version: ${current.version}'),
            Text('Platform: ${current.type.name.toCaptalize()}'),
            Divider(),
            _getNewVersion(),
          ],
        ),
      ),
    );
  }

  Widget _getNewVersion() {
    return FutureBuilder(
      future: ThancoderAppServices.getNewVersion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              Text('Version စစ်ဆေးနေပါတယ်....'),
              LinearProgressIndicator(),
            ],
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              Text('Version အသစ်'),
              Text('Version: ${data?.version}'),
              Text('Platform: ${data?.type.name.toCaptalize()}'),
              Text('Size: ${data?.size}'),
              IconButton.filled(
                onPressed: () {
                  try {
                    ThanPkg.platform.launch(data!.downloadUrl);
                  } catch (e) {
                    ThancoderServer.showDebugLog(
                      e.toString(),
                      tag: 'ThancoderHomeScreen:_getNewVersion',
                    );
                  }
                },
                icon: Icon(Icons.download),
              ),
            ],
          );
        }
        return Text('Version အသစ်မရှိသေးပါ');
      },
    );
  }

  void _goContentScreen(ThancoderApp app) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppReleaseScreen(app: app)),
    );
  }
}
