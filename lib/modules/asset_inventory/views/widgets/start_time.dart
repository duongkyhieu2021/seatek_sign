import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/widgets/date_time_picker_custom.dart';

class AssetInventoryStartTime extends StatelessWidget {
  const AssetInventoryStartTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryController = Get.find<AssetInventoryController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: DateTimePickerCustom(
        buttonText: assetInventoryController.currentInventory.startTime != null
            ? assetInventoryController.currentInventory.startTime.toString()
            : "Ngày bắt đầu",
        onDateTimeChanged: (dateTime) {
          assetInventoryController.currentInventory.startTime = dateTime;
        },
      ),
    );
  }
}
