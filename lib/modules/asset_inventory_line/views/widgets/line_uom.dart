import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class AssetLineUom extends StatelessWidget {
  const AssetLineUom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       final assetInventoryLineController =
        Get.find<AssetInventoryLineController>();
    assetInventoryLineController.currentInventoryLine.assetUom =
        assetInventoryLineController.currentInventoryLine.assetUom;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InputWidget(
        labelText: "Đơn vị tính",
        onSaved: (value) => {},
        validator: (value) => null,
        initialValue: assetInventoryLineController
                .currentInventoryLine.assetUom!.isEmpty
            ? ""
            : assetInventoryLineController
                .currentInventoryLine.assetUom?[1],
        isDisabled: true,
      ),
    );
  }
}
