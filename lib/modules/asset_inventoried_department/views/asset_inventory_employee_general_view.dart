import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventoried_department/views/widgets/department_dropdown.dart';
import 'package:sea_hr/modules/asset_inventoried_department/views/widgets/employee_dropdown.dart';
import 'package:sea_hr/modules/asset_inventoried_department/views/widgets/job_dropdown_view.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/controller/asset_inventory_employee_controller.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/company_input.dart';

class AssetInventoryEmployeeGeneralView extends StatelessWidget {
  const AssetInventoryEmployeeGeneralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryEmployeeController =
        Get.find<AssetInventoryEmployeeController>();
    final assetInventoryController = Get.find<AssetInventoryController>();
    assetInventoryEmployeeController
        .assetInventoryEmployeeRecord.assetInventoryId = [
      assetInventoryController.currentInventory.id,
      assetInventoryController.currentInventory.name
    ];

    return Obx(() => assetInventoryEmployeeController.status.value == 1
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, bottom: 4.0, left: 8.0, right: 8.0),
                  child: AssetInventoryCompanyInput(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0, left: 8.0, right: 8.0),
                  child: AssetInventoryEmployeeDepartmentDropdown(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0, left: 8.0, right: 8.0),
                  child: AssetInventoryEmployeeEmployeeDropdown(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0, left: 8.0, right: 8.0),
                  child: AssetInventoryEmployeeJobDropdown(),
                ),
              ],
            ),
          ));
  }
}
