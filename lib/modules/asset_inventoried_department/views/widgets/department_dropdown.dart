import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventoried_department/repository/record.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/controller/asset_inventory_employee_controller.dart';
import 'package:sea_hr/modules/hr_department/repository/department.dart';
import 'package:sea_hr/widgets/search_choices_widget.dart';

class AssetInventoryEmployeeDepartmentDropdown extends StatefulWidget {
  const AssetInventoryEmployeeDepartmentDropdown({Key? key}) : super(key: key);

  @override
  _AssetInventoryEmployeeDepartmentDropdownState createState() =>
      _AssetInventoryEmployeeDepartmentDropdownState();
}

class _AssetInventoryEmployeeDepartmentDropdownState
    extends State<AssetInventoryEmployeeDepartmentDropdown> {
  final assetInventoryController = Get.find<AssetInventoryController>();
  final assetInventoryEmployeeController =
      Get.find<AssetInventoryEmployeeController>();

  Department? _selectedValueDepartment;

  void handleOnChange(value) {
    setState(() async {
      log("value $value");

      _selectedValueDepartment = value;
      AssetInventoryEmployeeRecord inventoryEmployee =
          assetInventoryEmployeeController.assetInventoryEmployeeRecord;
      List<dynamic>? departments = inventoryEmployee.department!.isEmpty
          ? []
          : inventoryEmployee.department;
      departments = assetInventoryController.listDepartment
          .where((element) => element.id == value.id)
          .map((element) => [element.id, element.name])
          .toList();

      inventoryEmployee.department = departments[0];
      inventoryEmployee.employeeIdTemp = [];
      assetInventoryEmployeeController.listJobId.value = [];
      inventoryEmployee.jobId = [];
      await assetInventoryEmployeeController.fetchRecordsEmployeesTemp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 12.0),
      child: SearchChoicesWidget(
          items: assetInventoryController.listDepartment.map((element) {
            return DropdownMenuItem<Object>(
              value: element,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  element.name.toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF09101D)),
                ),
              ),
            );
          }).toList(),
          selectedValue: _selectedValueDepartment,
          title: assetInventoryEmployeeController
                  .assetInventoryEmployeeRecord.department!.isEmpty
              ? "Chọn bộ phận"
              : assetInventoryEmployeeController
                  .assetInventoryEmployeeRecord.department?[1],
          onChanged: handleOnChange),
    );
  }
}
