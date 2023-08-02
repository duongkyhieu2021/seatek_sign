import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventoried_department/controller/asset_inventory_employee_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/repository/record.dart';
import 'package:sea_hr/widgets/search_choices_widget.dart';

class AssetInventoryEmployeeJobDropdown extends StatefulWidget {
  const AssetInventoryEmployeeJobDropdown({Key? key}) : super(key: key);

  @override
  _AssetInventoryEmployeeJobDropdownState createState() =>
      _AssetInventoryEmployeeJobDropdownState();
}

class _AssetInventoryEmployeeJobDropdownState
    extends State<AssetInventoryEmployeeJobDropdown> {
  final assetInventoryEmployeeController =
      Get.find<AssetInventoryEmployeeController>();

  String? _selectedValueJob;
  @override
  Widget build(BuildContext context) {
    AssetInventoryEmployeeRecord inventoryEmployeeRecord =
        assetInventoryEmployeeController.assetInventoryEmployeeRecord;
    return Obx(() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
        child: SearchChoicesWidget(
            items: assetInventoryEmployeeController.listJobId.map((element) {
              return DropdownMenuItem<Object>(
                value: element.jobId![1].toString(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    element.jobId![1].toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
            selectedValue: _selectedValueJob,
            readOnly: true,
            title: inventoryEmployeeRecord.jobId!.isEmpty
                ? "Chức vụ"
                : inventoryEmployeeRecord.jobId?[1],
            onChanged: (value) {
              setState(() {
                _selectedValueJob = value;
              });
            })));
  }
}
