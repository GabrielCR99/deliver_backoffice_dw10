import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/helpers/history_back_listener.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import 'menu_button.dart';
import 'menu_enum.dart';

final class MenuBar extends StatefulWidget {
  const MenuBar({super.key});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

final class _MenuBarState extends State<MenuBar>
    with HistoryBackListener<MenuBar> {
  Menu? selectedMenu;
  var collapsed = false;

  @override
  void onHistoryBack(Object _) =>
      setState(() => selectedMenu = Menu.findByPath(Modular.to.path));

  @override
  void initState() {
    super.initState();
    selectedMenu = Menu.findByPath(Modular.to.path);
  }

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
              itemBuilder: (_, index) {
                final menu = Menu.values[index];

                return MenuButton(
                  menu: menu,
                  onPressed: _onPressedMenu,
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

  void _onPressedMenu(Menu value) {
    setState(() => selectedMenu = value);
    Modular.to.navigate(value.route);
  }
}
