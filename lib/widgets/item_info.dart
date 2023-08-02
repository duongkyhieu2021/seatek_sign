import 'package:flutter/material.dart';

class ItemInfo extends StatelessWidget {
  final IconData icon;
  final String name;
  final int? maxLine;
  final double? size;
  final double? textSize;
  final Color? iconColor;

  const ItemInfo({
    Key? key,
    required this.icon,
    required this.name,
    this.maxLine,
    this.size,
    this.textSize,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: size ?? 16.0,
          color: iconColor ?? Colors.black,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              name,
              maxLines: maxLine ?? 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: textSize ?? 12.0, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
