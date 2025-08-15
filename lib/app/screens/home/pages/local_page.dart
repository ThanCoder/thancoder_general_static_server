import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/functions/index.dart';
import 'package:t_widgets/widgets/t_loader_random.dart';
import 'package:thancoder_general_static_server/app/providers/app_provider.dart';
import 'package:thancoder_general_static_server/app/route_helper.dart';
import 'package:thancoder_general_static_server/more_libs/terminal_app/terminal_button.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class LocalPage extends StatefulWidget {
  const LocalPage({super.key});

  @override
  State<LocalPage> createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Future<void> init() async {
    await context.read<AppProvider>().initList();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isAppLoading = appProvider.isLoading;
    final appList = appProvider.getList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Page'),
        actions: [TerminalButton(), ThancoderAppNotifierButton()],
      ),
      body: isAppLoading
          ? Center(child: TLoaderRandom())
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AppSeeAllView(
                    isLocal: true,
                    list: appList,
                    onSeeAllClicked: (title, list) {},
                    onClicked: _goEditAppContentScreen,
                    onRightClicked: _showItemContextMenu,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatorMenu,

        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreatorMenu() {
    showTMenuBottomSheet(
      context,
      children: [
        ListTile(
          leading: Icon(Icons.add),
          title: Text('New App'),
          onTap: () {
            Navigator.pop(context);
            _goEditScreen();
          },
        ),
      ],
    );
  }

  void _goEditScreen() async {
    final app = ThancoderApp.create();
    goEditAppScreen(
      context,
      app,
      onUpdated: (updatedApp) {
        context.read<AppProvider>().add(app);
      },
    );
  }

  void _goEditAppContentScreen(ThancoderApp app) {
    goEditAppContentScreen(context, app);
  }

  void _showItemContextMenu(ThancoderApp app) {
    showTMenuBottomSheet(
      context,
      children: [
        Text(app.title),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit_document),
          title: Text('Edit'),
          onTap: () {
            Navigator.pop(context);
            _goItemEditAppScreen(app);
          },
        ),
        ListTile(
          iconColor: Colors.red,
          leading: Icon(Icons.delete_forever_rounded),
          title: Text('Delete'),
          onTap: () {
            Navigator.pop(context);
            _deleteConfirm(app);
          },
        ),
      ],
    );
  }

  // item
  void _goItemEditAppScreen(ThancoderApp app) {
    goEditAppScreen(
      context,
      app,
      onUpdated: (updatedApp) {
        context.read<AppProvider>().update(app);
      },
    );
  }

  void _deleteConfirm(ThancoderApp app) {
    showTConfirmDialog(
      context,
      contentText: 'ဖျက်ချင်တာ သေချာပြီလား?',
      submitText: 'Delete Forever',
      onSubmit: () {
        context.read<AppProvider>().delete(app);
      },
    );
  }
}
