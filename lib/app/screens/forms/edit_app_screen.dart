import 'package:flutter/material.dart';
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
  late ThancoderApp app;
  @override
  void initState() {
    app = widget.app;
    super.initState();
    init();
  }

  void init() {
    titleController.text = app.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit: ${widget.app.title}')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 15,
          children: [
            TTextField(
              label: Text('Title'),
              controller: titleController,
              maxLines: 1,
              isSelectedAll: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSave,
        child: Icon(Icons.save_as_rounded),
      ),
    );
  }

  void _onSave(){
    app.title = titleController.text;

    Navigator.pop(context);

    // update
    widget.onUpdated(app);
  }
}
