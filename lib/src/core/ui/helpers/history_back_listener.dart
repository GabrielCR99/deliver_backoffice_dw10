import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

base mixin HistoryBackListener<T extends StatefulWidget> on State<T> {
  final _location = const BrowserPlatformLocation();
  var _isListenerAdded = false;

  @override
  void initState() {
    super.initState();
    if (!_isListenerAdded) {
      _location.addPopStateListener((event) async {
        _isListenerAdded = true;
        onHistoryBack();
        await Future<void>.delayed(const Duration(milliseconds: 250), () {
          if (mounted) {
            onHistoryBack();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    if (_isListenerAdded) {
      _location.removePopStateListener((_) => onHistoryBack());
      _isListenerAdded = false;
    }
    super.dispose();
  }

  void onHistoryBack();
}
