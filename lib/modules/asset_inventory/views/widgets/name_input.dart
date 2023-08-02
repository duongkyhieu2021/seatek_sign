import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class AssetInventoryNameInput extends StatelessWidget {
  const AssetInventoryNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryController = Get.find<AssetInventoryController>();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InputWidget(
        labelText: "Tên sản phẩm kiểm kê",
        hintText: "Tên sản phẩm kiểm kê",
        onSaved: (value) {},
        onChange: (value) {
          assetInventoryController.currentInventory.name = value;
        },
        validator: (value) => null,
        initialValue: assetInventoryController.currentInventory.name!.isNotEmpty
            ? assetInventoryController.currentInventory.name
            : "",
      ),
    );
  }
}
