import 'package:flutter/material.dart';
import 'package:t_widgets/functions/index.dart';
import 'package:thancoder_general_static_server/app/route_helper.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/types/thancoder_app.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/types/thancoder_app_types.dart';

class LocalPage extends StatefulWidget {
  const LocalPage({super.key});

  @override
  State<LocalPage> createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatorMenu,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreatorMenu() {
    showTModalBottomSheet(
      context,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.add),
            title: Text('New App'),
            onTap: () {
              Navigator.pop(context);
              _createNewApp();
            },
          ),
        ],
      ),
    );
  }

  // new app
  void _createNewApp() {
    showTReanmeDialog(
      context,
      text: 'Untitled',
      barrierDismissible: false,
      title: Text('New App'),
      submitText: 'New',
      onSubmit: (text) {
        final app = ThancoderApp.create(
          type: ThancoderAppTypes.android,
          title: text,
        );
        goEditAppScreen(context, app, onUpdated: (updatedApp) {});
      },
    );
  }
}
