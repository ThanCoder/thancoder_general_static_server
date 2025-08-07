import 'package:flutter/material.dart';
import 'package:t_widgets/widgets/index.dart';

import 'thancoder_server.dart';

class ThancoderAppNotifierButton extends StatefulWidget {
  const ThancoderAppNotifierButton({super.key});

  @override
  State<ThancoderAppNotifierButton> createState() =>
      _ThancoderAppNotifierButtonState();
}

class _ThancoderAppNotifierButtonState
    extends State<ThancoderAppNotifierButton> {
  bool isNewUpdate = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  void init() async {
    try {
      final release = await ThancoderAppServices.getNewVersion();

      if (!mounted) return;
      isNewUpdate = release == null ? false : true;
      isLoading = false;

      setState(() {});
    } catch (e) {
      ThancoderServer.showDebugLog(
        e.toString(),
        tag: 'ThancoderAppNotifierButton:init',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return TLoader(size: 20);
    }
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThancoderHomeScreen()),
        );
      },
      icon: _getBadge(),
    );
  }

  Widget _getBadge() {
    if (isNewUpdate) {
      return Badge.count(
        count: 1,
        child: Icon(color: Colors.amber, Icons.notifications_active),
      );
    }
    return Icon(Icons.notifications_active);
  }
}
