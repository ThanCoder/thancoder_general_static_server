import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets_dev.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/core/index.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/services/release_app_services.dart';

class AppContentScreen extends StatefulWidget {
  final App app;
  const AppContentScreen({super.key, required this.app});

  @override
  State<AppContentScreen> createState() => _AppContentScreenState();
}

class _AppContentScreenState extends State<AppContentScreen> {
  @override
  Widget build(BuildContext context) {
    final db = ReleaseAppServices.getLocalDB(widget.app.id);
    return Scaffold(
      appBar: AppBar(title: Text(widget.app.title)),
      body: FutureBuilder(
        future: db.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: TLoader.random());
          }
          if (snapshot.hasData) {
            final list = snapshot.data ?? [];
            if (list.isEmpty) {
              return Center(child: Text('List is Empty!'));
            }
            return CustomScrollView(slivers: [_getList(list)]);
          }
          return Center(child: Text('Not List'));
        },
      ),
    );
  }

  Widget _getList(List<ReleaseApp> list) {
    return SliverList.separated(
      itemCount: list.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final item = list[index];
        return Row(
          spacing: 5,
          children: [
            SizedBox(
              width: 130,
              height: 150,
              child: TImage(source: item.coverSource),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text('T: ${item.title}'),
                Text('Size: ${item.size}'),
                Text('Version: ${item.version}'),
                Text('Type: ${item.type.name}'),
                Text('DirectLink: ${item.isDirectLink ? 'Yes' : 'No'}'),
                Text('Date: ${item.date.toParseTime()}'),
                Text('Desc: ${item.desc}'),
              ],
            ),
          ],
        );
      },
    );
  }
}
