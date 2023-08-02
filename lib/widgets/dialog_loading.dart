import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/theme.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: LoadingAnimationWidget.prograssiveDots(
        color: ThemeApp.light().primaryColor,
        size: 60,
      ),
    );
  }
}
