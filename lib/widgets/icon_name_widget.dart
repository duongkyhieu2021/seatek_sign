import 'package:flutter/material.dart';
import 'package:sea_hr/widgets/item_info.dart';

class IconNameWidget extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final String name;
  final double? size;
  final double? textSize;

  const IconNameWidget(
      {super.key,
      required this.iconData,
      required this.name,
      this.iconColor,
      this.size,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ItemInfo(
                icon: iconData,
                name: name,
                size: size,
                textSize: textSize,
                iconColor: iconColor ?? Colors.black),
          ],
        ),
      ),
    );
  }
}
