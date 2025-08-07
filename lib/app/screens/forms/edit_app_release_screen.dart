import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class EditAppReleaseScreen extends StatefulWidget {
  AppRelease release;
  void Function(AppRelease updatedRelease) onUpdated;
  EditAppReleaseScreen({
    super.key,
    required this.release,
    required this.onUpdated,
  });

  @override
  State<EditAppReleaseScreen> createState() => _EditAppReleaseScreenState();
}

class _EditAppReleaseScreenState extends State<EditAppReleaseScreen> {
  late AppRelease release;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final coverUrlController = TextEditingController();
  final downloadUrlController = TextEditingController();
  final sizeController = TextEditingController();
  final versionController = TextEditingController();

  @override
  void initState() {
    release = widget.release;
    super.initState();
    titleController.text = release.title;
    descController.text = release.desc;
    coverUrlController.text = release.coverUrl;
    downloadUrlController.text = release.downloadUrl;
    sizeController.text = release.size;
    versionController.text = release.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit: ${widget.release.title}')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // cover
              Row(
                spacing: 8,
                children: [
                  Column(
                    children: [
                      TCoverChooser(
                        coverPath: release.getCoverPath,
                        onChanged: () {
                          coverUrlController.text = release.getServerCoverUrl;
                        },
                      ),
                      Text('Local Cover'),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: TImageUrl(url: coverUrlController.text),
                      ),
                      Text('Online Cover'),
                    ],
                  ),
                ],
              ),

              // form
              TTextField(
                label: Text('Title'),
                controller: titleController,
                maxLines: 1,
                isSelectedAll: true,
              ),
              TTextField(
                label: Text('Cover Url'),
                controller: coverUrlController,
                maxLines: 1,
                isSelectedAll: true,
              ),

              Divider(),
              TTextField(
                label: Text('Download Url'),
                controller: downloadUrlController,
                maxLines: 1,
                isSelectedAll: true,
              ),
              Row(
                spacing: 5,
                children: [
                  Text('isDirectLink'),
                  Switch.adaptive(value: release.isDirectLink, onChanged: (value) {
                    setState(() {
                      release.isDirectLink = value;
                    });
                  },),
                ],
              ),
              Divider(),

              TTextField(
                label: Text('Size'),
                controller: sizeController,
                maxLines: 1,
              ),
              TTextField(
                label: Text('Version'),
                controller: versionController,
                maxLines: 1,
              ),
              AppReleaseTypesChooser(
                title: Text('Platform Types:'),
                value: release.type,
                onChanged: (value) {
                  setState(() {
                    release.type = value;
                  });
                },
              ),
              Divider(),
              
              TTextField(
                label: Text('Desc'),
                controller: descController,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSaved,
        child: Icon(Icons.save_as_rounded),
      ),
    );
  }

  void _onSaved() {
    release.title = titleController.text;
    release.desc = descController.text;
    release.coverUrl = coverUrlController.text;
    release.downloadUrl = downloadUrlController.text;
    release.size = sizeController.text;
    release.version = versionController.text;

    Navigator.pop(context);
    widget.onUpdated(release);
  }
}
