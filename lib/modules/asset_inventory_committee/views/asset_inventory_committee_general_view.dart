import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_committee/controller/asset_inventory_committee_controller.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventory_committee/views/widgets/employee_dropdown.dart';
import 'package:sea_hr/modules/asset_inventory_committee/views/widgets/position_dropdown.dart';


class AssetInventoryCommitteeGeneralView extends StatelessWidget {
  const AssetInventoryCommitteeGeneralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryCommitteeController =
        Get.find<AssetInventoryCommitteeController>();
    final assetInventoryController = Get.find<AssetInventoryController>();
    assetInventoryCommitteeController
        .assetInventoryCommitteeRecord.assetInventoryId = [
      assetInventoryController.currentInventory.id,
      assetInventoryController.currentInventory.name
    ];
    return Obx(() {
      return assetInventoryCommitteeController.status.value == 1
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: InventoryCommitteeEmployeeDropdown(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: InventoryCommitteePositionDropdown(),
                  ),
                ],
              ),
            );
    });
  }
}
