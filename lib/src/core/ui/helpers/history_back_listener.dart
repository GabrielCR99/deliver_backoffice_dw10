import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

mixin HistoryBackListener<T extends StatefulWidget> on State<T> {
  final _location = const BrowserPlatformLocation();

  @override
  void initState() {
    super.initState();
    _location.addPopStateListener((event) async {
      onHistoryBack(event);
      await Future<void>.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          onHistoryBack(event);
        }
      });
    });
  }

  @override
  void dispose() {
    _location.removePopStateListener(onHistoryBack);
    super.dispose();
  }

  void onHistoryBack(Object _) {
    return;
  }
}
