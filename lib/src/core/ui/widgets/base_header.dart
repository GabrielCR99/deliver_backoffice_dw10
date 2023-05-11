import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final ValueChanged<String>? onSearch;
  final String buttonLabel;
  final VoidCallback onButtonTap;
  final bool showAddButton;
  final Widget? filterWidget;

  const BaseHeader({
    required this.title,
    required this.onSearch,
    required this.buttonLabel,
    required this.onButtonTap,
    this.showAddButton = true,
    this.filterWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Wrap(
        children: [
          Visibility(
            replacement: filterWidget ?? const SizedBox.shrink(),
            visible: filterWidget == null,
            child: SizedBox(
              width: constraints.maxWidth * 0.15,
              child: TextFormField(
                decoration: InputDecoration(
                  label: Text(
                    'Buscar',
                    style: context.textStyles.textRegular
                        .copyWith(fontSize: 12, color: Colors.grey),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon:
                      Icon(Icons.search, size: constraints.maxWidth * 0.02),
                ),
                onChanged: onSearch,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: constraints.maxWidth * 0.65,
            child: Text(
              title,
              style: context.textStyles.titleText.copyWith(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Visibility(
            visible: showAddButton,
            child: SizedBox(
              width: constraints.maxWidth * 0.15,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: onButtonTap,
                icon: Icon(Icons.add, size: constraints.maxWidth * 0.02),
                label: Text(buttonLabel),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
