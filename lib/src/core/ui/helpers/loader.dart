import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var _isOpen = false;

  void showLoader() {
    if (!_isOpen) {
      _isOpen = true;

      showDialog<void>(
        context: context,
        builder: (_) => LoadingAnimationWidget.threeArchedCircle(
          color: Colors.white,
          size: 60,
        ),
        barrierDismissible: false,
      );
    }
  }

  void hideLoader() {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (_isOpen) {
      _isOpen = false;

      if (navigator.canPop()) {
        navigator.pop<void>();
      }
    }
  }

  @override
  void dispose() {
    if (_isOpen) {
      _isOpen = false;
    }
    super.dispose();
  }
}
