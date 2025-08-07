import 'package:flutter/material.dart';
import 'package:t_widgets/choosers/t_cover_chooser.dart';
import 'package:t_widgets/widgets/index.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/types/thancoder_app.dart';

class EditAppScreen extends StatefulWidget {
  ThancoderApp app;
  void Function(ThancoderApp app) onUpdated;
  EditAppScreen({super.key, required this.app, required this.onUpdated});

  @override
  State<EditAppScreen> createState() => _EditAppScreenState();
}

class _EditAppScreenState extends State<EditAppScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final coverUrlController = TextEditingController();
  final githubUrlController = TextEditingController();
  late ThancoderApp app;
  @override
  void initState() {
    app = widget.app;
    super.initState();
    init();
  }

  void init() {
    titleController.text = app.title;
    descController.text = app.desc;
    coverUrlController.text = app.coverUrl;
    githubUrlController.text = app.githubUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit: ${widget.app.title}')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              // cover
              Row(
                spacing: 8,
                children: [
                  Column(
                    children: [
                      TCoverChooser(coverPath: app.getCoverPath),
                      Text('Local Image'),
                    ],
                  ),
                  Column(
                    children: [
                      TImageUrl(url: app.coverUrl, size: 150),
                      Text('Online Image'),
                    ],
                  ),
                ],
              ),

              TTextField(
                label: Text('Title'),
                controller: titleController,
                maxLines: 1,
                isSelectedAll: true,
              ),
              TTextField(
                label: Text('Github Url'),
                controller: githubUrlController,
                maxLines: 1,
                isSelectedAll: true,
                onChanged: (value) {
                  app.githubUrl = value;
                  setState(() {});
                },
              ),
              TTextField(
                label: Text('Cover Url'),
                controller: coverUrlController,
                maxLines: 1,
                isSelectedAll: true,
                onChanged: (value) {
                  app.coverUrl = value;
                  setState(() {});
                },
              ),
              
              TTextField(
                label: Text('Desc'),
                controller: descController,
                maxLines: null,
                isSelectedAll: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSave,
        child: Icon(Icons.save_as_rounded),
      ),
    );
  }

  void _onSave() {
    app.title = titleController.text;
    app.desc = descController.text;
    app.coverUrl = coverUrlController.text;
    app.githubUrl = githubUrlController.text;

    Navigator.pop(context);

    // update
    widget.onUpdated(app);
  }
}
