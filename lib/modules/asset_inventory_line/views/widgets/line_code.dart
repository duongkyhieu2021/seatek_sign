import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class AssetLineCode extends StatelessWidget {
  const AssetLineCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryLineController =
        Get.find<AssetInventoryLineController>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InputWidget(
        labelText: "Tham chiếu",
        hintText: "Tham chiếu",
        onSaved: (value) => {},
        validator: (value) => null,
        initialValue:
            assetInventoryLineController.currentInventoryLine.assetCode ?? "",
        isDisabled: true,
      ),
    );
  }
}
