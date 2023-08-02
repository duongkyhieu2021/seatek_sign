import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/controller/asset_inventory_employee_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/repository/record.dart';
import 'package:sea_hr/widgets/search_choices_widget.dart';

class AssetInventoryEmployeeEmployeeDropdown extends StatefulWidget {
  const AssetInventoryEmployeeEmployeeDropdown({Key? key}) : super(key: key);

  @override
  _AssetInventoryEmployeeEmployeeDropdownState createState() =>
      _AssetInventoryEmployeeEmployeeDropdownState();
}

class _AssetInventoryEmployeeEmployeeDropdownState
    extends State<AssetInventoryEmployeeEmployeeDropdown> {
  final assetInventoryEmployeeController =
      Get.find<AssetInventoryEmployeeController>();

  String? _selectedValueUserTemp;

  // ===========================
  void handleOnChange(value) {
    AssetInventoryEmployeeRecord inventoryEmployeeRecord =
        assetInventoryEmployeeController.assetInventoryEmployeeRecord;
    List<dynamic>? employees = inventoryEmployeeRecord.employeeIdTemp!.isEmpty
        ? []
        : inventoryEmployeeRecord.employeeIdTemp;

    employees = assetInventoryEmployeeController.listEmployeesTemp
        .where((element) => element.id == value.id)
        .map((element) => [element.id, element.name, element.employeeId])
        .toList();

    inventoryEmployeeRecord.employeeIdTemp = employees[0];
    inventoryEmployeeRecord.employeeId = employees[0][2];

    final listHrEmployeeMultiCompany =
        Get.find<HomeController>().hrEmployeeMultiCompany;
    final result = listHrEmployeeMultiCompany.firstWhere(
        (element) => element.id == inventoryEmployeeRecord.employeeId![0]);
    inventoryEmployeeRecord.jobId = result.jobId;
    assetInventoryEmployeeController.listJobId.add(inventoryEmployeeRecord);

    setState(() {
      _selectedValueUserTemp = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SearchChoicesWidget(
            items: assetInventoryEmployeeController.listEmployeesTemp
                .map((element) {
              return DropdownMenuItem<Object>(
                value: element,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    element.name.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
            selectedValue: _selectedValueUserTemp,
            title: assetInventoryEmployeeController
                    .assetInventoryEmployeeRecord.employeeIdTemp!.isEmpty
                ? "Chọn nhân viên"
                : assetInventoryEmployeeController
                    .assetInventoryEmployeeRecord.employeeIdTemp?[1],
            onChanged: handleOnChange)));
  }
}
