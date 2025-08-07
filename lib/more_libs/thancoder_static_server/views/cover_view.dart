import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class CoverView extends StatefulWidget {
  List<String> list;
  CoverView({super.key, required this.list});

  @override
  State<CoverView> createState() => _CoverViewState();
}

class _CoverViewState extends State<CoverView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.list.length, (index) {
          final url = widget.list[index];
          return GestureDetector(
            onTap: () => _onViewed(url),
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: TImage(source: url, size: 150),
            ),
          );
        }),
      ),
    );
  }

  void _onViewed(String url) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog.adaptive(
        contentPadding: EdgeInsets.all(0),
        content: InteractiveViewer(
          child: TImage(source: url)),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(Icons.close),
        //   ),
        // ],
      ),
    );
  }
}
