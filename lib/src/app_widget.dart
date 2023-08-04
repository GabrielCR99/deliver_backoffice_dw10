import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/global/global_context.dart';
import 'core/ui/styles/app_colors.dart';
import 'core/ui/styles/app_styles.dart';
import 'core/ui/styles/text_styles.dart';

part '../src/core/ui/theme/theme_config.dart';

final class AppWidget extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  AppWidget({super.key}) {
    GlobalContext.instance.navigatorKey = _navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    Modular
      ..setInitialRoute('/login/')
      ..setNavigatorKey(_navigatorKey);

    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      title: 'Vakinha Backoffice',
      theme: _theme,
    );
  }
}
