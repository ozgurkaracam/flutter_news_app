import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    required this.title,
    required this.selected,
    required this.callback,
    super.key,
  });
  final String title;
  final VoidCallback callback;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Text(
        title,
        style: TextStyle(
          fontSize: selected ? 35 : 20,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
