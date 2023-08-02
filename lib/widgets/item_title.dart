import 'package:flutter/widgets.dart';
import 'package:sea_hr/theme.dart';

class ItemTitle extends StatelessWidget {
  final String title;
  const ItemTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: ThemeApp.textStyle(
          fontWeight: FontWeight.bold,
          color: const Color(0xff448bc0),
          fontSize: 14.0),
    );
  }
}
