import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class AssetInventoryCompanyInput extends StatelessWidget {
  const AssetInventoryCompanyInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
      child: InputWidget(
        labelText: "Tên công ty",
        hintText: "Tên công ty",
        onSaved: (value) => {},
        onChange: (value) {},
        validator: (value) => null,
        initialValue: homeController.companyUser.value.id.toString().isNotEmpty
            ? homeController.companyUser.value.name
            : "",
        isDisabled: true,
      ),
    );
  }
}
