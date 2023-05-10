import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import 'menu_enum.dart';

class MenuButton extends StatelessWidget {
  final Menu menu;
  final ValueChanged<Menu> onPressed;
  final Menu? selectedMenu;

  const MenuButton({
    required this.menu,
    required this.onPressed,
    this.selectedMenu,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = menu == selectedMenu;

    return LayoutBuilder(
      builder: (_, constraints) => Visibility(
        replacement: Container(
          padding: const EdgeInsets.all(5),
          decoration: isSelected
              ? const BoxDecoration(
                  color: Color(0xFFFFF5E2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )
              : null,
          margin: const EdgeInsets.all(10),
          child: Tooltip(
            message: menu.label,
            child: IconButton(
              onPressed: () => onPressed(menu),
              icon: Image.asset(
                'assets/images/icons/${isSelected ? menu.assetIconSelected : menu.assetIcon}',
              ),
            ),
          ),
        ),
        visible: constraints.maxWidth != 90,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onPressed(menu),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: isSelected
                  ? const BoxDecoration(
                      color: Color(0xFFFFF5E2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  : null,
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/icons/${isSelected ? menu.assetIconSelected : menu.assetIcon}',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      menu.label,
                      style: isSelected
                          ? context.textStyles.textBold
                          : context.textStyles.textRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
