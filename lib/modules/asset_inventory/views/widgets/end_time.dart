import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/widgets/date_time_picker_custom.dart';

class AssetInventoryEndTime extends StatelessWidget {
  const AssetInventoryEndTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryController = Get.find<AssetInventoryController>();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DateTimePickerCustom(
        buttonText: assetInventoryController.currentInventory.endTime != null
            ? assetInventoryController.currentInventory.endTime.toString()
            : "Ngày kết thúc",
        onDateTimeChanged: (dateTime) {
          assetInventoryController.currentInventory.endTime = dateTime;
        },
      ),
    );
  }
}
