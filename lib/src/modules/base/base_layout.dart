import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import 'menu/menu_bar.dart' as menu;

final class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final shortestSide = context.shortestSide;

    return Scaffold(
      body: SizedBox(
        height: context.height,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: Colors.black,
              constraints: BoxConstraints(
                minWidth: screenWidth,
                minHeight: shortestSide * 0.15,
                maxHeight: shortestSide * 0.15,
              ),
              child: Container(
                width: shortestSide * 0.13,
                margin: const EdgeInsets.only(left: 60),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Positioned.fill(
              top: shortestSide * 0.13,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const menu.MenuBar(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: Colors.grey[50],
                        child: body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
