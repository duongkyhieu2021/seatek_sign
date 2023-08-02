import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_committee/controller/asset_inventory_committee_controller.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/widgets/dropdown_button2_widget.dart';

class InventoryCommitteePositionDropdown extends StatefulWidget {
  const InventoryCommitteePositionDropdown({Key? key}) : super(key: key);

  @override
  _InventoryCommitteePositionDropdownState createState() =>
      _InventoryCommitteePositionDropdownState();
}

class _InventoryCommitteePositionDropdownState
    extends State<InventoryCommitteePositionDropdown> {
  final assetInventoryCommitteeController =
      Get.find<AssetInventoryCommitteeController>();
  final assetInventoryController = Get.find<AssetInventoryController>();
  String? _selectedValuePosition;
  @override
  Widget build(BuildContext context) {
    return DropdownButton2Widget(
      hintText: assetInventoryCommitteeController
              .assetInventoryCommitteeRecord.position!.isNotEmpty
          ? assetInventoryCommitteeController
              .assetInventoryCommitteeRecord.position![1]
          : "Chọn vị trí",
      items: assetInventoryController.listPosition
          .map((item) => {
                'id': item.id,
                'name': item.name,
              })
          .toList(),
      value: _selectedValuePosition,
      onChanged: (value) {
        setState(() {
          _selectedValuePosition = value;
          final data = assetInventoryController.listPosition
              .firstWhere((element) => element.id == int.parse(value!));
          assetInventoryCommitteeController
              .assetInventoryCommitteeRecord.position = [value, data.name];
        });
      },
    );
  }
}
