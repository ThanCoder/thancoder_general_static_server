import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/functions/index.dart';
import 'package:t_widgets/widgets/index.dart';
import 'package:thancoder_general_static_server/app/providers/app_release_provider.dart';
import 'package:thancoder_general_static_server/app/screens/forms/edit_app_release_screen.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class EditAppContentScreen extends StatefulWidget {
  ThancoderApp app;
  EditAppContentScreen({super.key, required this.app});

  @override
  State<EditAppContentScreen> createState() => _EditAppContentScreenState();
}

class _EditAppContentScreenState extends State<EditAppContentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Future<void> init() async {
    await context.read<AppReleaseProvider>().initList(widget.app.id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppReleaseProvider>();
    final isLoading = provider.isLoading;
    final list = provider.getList;

    return Scaffold(
      appBar: AppBar(title: Text('Edit App Content')),
      body: isLoading
          ? Center(child: TLoaderRandom())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
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

                  // list
                  SliverList.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => AppReleaseListItem(
                      release: list[index],
                      onEditClicked: _goEdit,
                      onRightClicked: _showItemContextMenu,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createMenu,
        child: Icon(Icons.add),
      ),
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

  Widget _getCoverHeader() {
    return FutureBuilder(
      future: AppReleaseServices.getCoverList(widget.app.id),
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

  // menu
  void _createMenu() {
    showTModalBottomSheet(
      context,
      child: Column(
        children: [
          ListTile(
            title: Text('New Release'),
            onTap: () {
              Navigator.pop(context);
              _createNewRelease();
            },
          ),
        ],
      ),
    );
  }

  void _createNewRelease() async {
    final release = AppRelease.create(
      title: widget.app.title,
      appId: widget.app.id,
      coverUrl: widget.app.coverUrl,
      isDirectLink: false,
      type: AppReleaseTypes.android,
    );
    await context.read<AppReleaseProvider>().add(release);

    if (!mounted) return;
    _goEdit(release);
  }

  void _goEdit(AppRelease release) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAppReleaseScreen(
          release: release,
          onUpdated: (release) {
            context.read<AppReleaseProvider>().update(release);
          },
        ),
      ),
    );
  }

  // show item context menu
  void _showItemContextMenu(AppRelease release) {
    showTMenuBottomSheet(
      context,
      children: [
        Text(release.title),
        Divider(),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('ReNew'),
          onTap: () {
            Navigator.pop(context);
            _goRenewAndEdit(release);
          },
        ),
        ListTile(
          iconColor: Colors.red,
          leading: Icon(Icons.delete_forever),
          title: Text('Delete'),
          onTap: () {
            Navigator.pop(context);
            _showDeleteConfirm(release);
          },
        ),
      ],
    );
  }

  // delete confirm
  void _showDeleteConfirm(AppRelease release) {
    showTConfirmDialog(
      context,
      contentText: 'ဖျက်ချင်တာ သေချာပြီလား?',
      submitText: 'Delete Forever',
      onSubmit: () {
        context.read<AppReleaseProvider>().delete(release);
      },
    );
  }

  void _goRenewAndEdit(AppRelease release) async {
    final newRelease = AppRelease.create(
      title: release.title,
      appId: widget.app.id,
      coverUrl: release.coverUrl,
      isDirectLink: release.isDirectLink,
      desc: release.desc,
      type: release.type,
      version: release.version,
    );
    await context.read<AppReleaseProvider>().add(newRelease);

    if (!mounted) return;
    _goEdit(newRelease);
  }
}
