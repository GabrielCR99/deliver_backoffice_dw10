import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/helpers/size_extensions.dart';
import 'menu_button.dart';
import 'menu_enum.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({super.key});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  Menu? selectedMenu;
  var collapsed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: collapsed ? 90 : context.percentWidth(0.2),
      height: double.infinity,
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          Align(
            alignment: collapsed ? Alignment.center : Alignment.centerRight,
            child: IconButton(
              onPressed: () => setState(() => collapsed = !collapsed),
              icon: Icon(
                collapsed
                    ? Icons.keyboard_double_arrow_right
                    : Icons.keyboard_double_arrow_left,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final menu = Menu.values[index];

                return MenuButton(
                  menu: menu,
                  onPressed: (value) {
                    setState(() => selectedMenu = value);
                    Modular.to.navigate(value.route);
                  },
                  selectedMenu: selectedMenu,
                );
              },
              itemCount: Menu.values.length,
            ),
          ),
        ],
      ),
    );
  }
}
