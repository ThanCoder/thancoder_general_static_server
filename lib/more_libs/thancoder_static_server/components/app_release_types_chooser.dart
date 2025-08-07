import 'package:flutter/material.dart';
import 'package:than_pkg/than_pkg.dart';

import '../thancoder_server.dart';

class AppReleaseTypesChooser extends StatelessWidget {
  Widget? title;
  AppReleaseTypes value;
  void Function(AppReleaseTypes value) onChanged;
  AppReleaseTypesChooser({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Column(
        spacing: 8,
        children: [title!, _getChooser()]);
    }
    return _getChooser();
  }

  Widget _getChooser() {
    return DropdownButton<AppReleaseTypes>(
      value: value,
      padding: EdgeInsets.all(5),
      borderRadius: BorderRadius.circular(4),
      items: AppReleaseTypes.values
          .map(
            (e) => DropdownMenuItem<AppReleaseTypes>(
              value: e,
              child: Text(e.name.toCaptalize()),
            ),
          )
          .toList(),
      onChanged: (value) {
        onChanged(value!);
      },
    );
  }
}
