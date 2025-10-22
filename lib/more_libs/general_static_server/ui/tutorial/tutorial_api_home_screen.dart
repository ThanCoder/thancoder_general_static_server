import 'package:flutter/material.dart';
import 'package:t_widgets/widgets/t_loader.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/core/models/tutorial.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/general_server.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/services/tutorial_services.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/ui/compoments/tutorial_list_item.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/ui/tutorial/tutorial_detail_screen.dart';

class TutorialApiHomeScreen extends StatefulWidget {
  const TutorialApiHomeScreen({super.key});

  @override
  State<TutorialApiHomeScreen> createState() => _TutorialApiHomeScreenState();
}

class _TutorialApiHomeScreenState extends State<TutorialApiHomeScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  List<Tutorial> list = [];
  bool isLoading = false;

  void init() async {
    try {
      setState(() {
        isLoading = true;
      });
      list = await TutorialServices.getApiDB.getAll();
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial API'),
        actions: [IconButton(onPressed: init, icon: Icon(Icons.refresh_sharp))],
      ),
      body: _getViews(),
    );
  }

  Widget _getViews() {
    return CustomScrollView(
      slivers: [
        SliverList.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: list.length,
          itemBuilder: (context, index) => TutorialListItem(
            item: list[index],
            onClicked: (item) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TutorialDetailScreen(
                    rootPath: GeneralServer.instance.getApiServerUrl(),
                    tutorial: item,
                  ),
                ),
              );
            },
          ),
        ),
        SliverFillRemaining(child: isLoading ? TLoader.random() : null),
      ],
    );
  }
}
