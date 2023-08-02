import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_committee/controller/asset_inventory_committee_controller.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/widgets/dropdown_button2_widget.dart';

class InventoryCommitteeEmployeeDropdown extends StatefulWidget {
  const InventoryCommitteeEmployeeDropdown({Key? key}) : super(key: key);

  @override
  _InventoryCommitteeEmployeeDropdownState createState() =>
      _InventoryCommitteeEmployeeDropdownState();
}

class _InventoryCommitteeEmployeeDropdownState
    extends State<InventoryCommitteeEmployeeDropdown> {
  String? _selectedValueEmployee;
  final assetInventoryCommitteeController =
      Get.find<AssetInventoryCommitteeController>();
  final assetInventoryController = Get.find<AssetInventoryController>();
  @override
  Widget build(BuildContext context) {
    return DropdownButton2Widget(
      hintText: assetInventoryCommitteeController
              .assetInventoryCommitteeRecord.employeeIdTemp!.isNotEmpty
          ? assetInventoryCommitteeController
              .assetInventoryCommitteeRecord.employeeIdTemp![1]
          : "Chọn nhân viên",
      items: assetInventoryController.listEmployees
          .map((item) => {
                'id': item.id,
                'name': item.name,
              })
          .toList(),
      value: _selectedValueEmployee,
      onChanged: (value) {
        setState(() {
          _selectedValueEmployee = value;

          final data = assetInventoryController.listEmployees
              .firstWhere((element) => element.id == int.parse(value!));
          assetInventoryCommitteeController.assetInventoryCommitteeRecord
              .employeeIdTemp = [value, data.name];
        });
      },
    );
  }
}
