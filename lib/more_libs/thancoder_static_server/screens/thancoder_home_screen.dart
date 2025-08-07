import 'package:flutter/material.dart';
import 'package:t_widgets/widgets/index.dart';

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

  void _goContentScreen(ThancoderApp app) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppReleaseScreen(app: app)),
    );
  }
}
