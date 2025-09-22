import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:thancoder_general_static_server/app/route_helper.dart';
import 'package:thancoder_general_static_server/app/ui/app_content/app_content_screen.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/services/app_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return TScaffold(
      appBar: AppBar(title: Text('General Server')),
      body: _getAppList(),
    );
  }

  Widget _getAppList() {
    return FutureBuilder(
      future: AppServices.getLocalDB.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: TLoader.random());
        }
        if (snapshot.hasData) {
          final list = snapshot.data ?? [];
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return GestureDetector(
                onTap: () {
                  goRoute(
                    context,
                    builder: (context) => AppContentScreen(app: item),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 200,
                      child: TImage(source: item.coverSource),
                    ),
                    Text(item.title),
                  ],
                ),
              );
            },
          );
        }
        return Center(child: Text('Not List'));
      },
    );
  }
}
