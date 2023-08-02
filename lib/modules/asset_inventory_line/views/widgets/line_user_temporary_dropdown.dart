import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/search_choices_widget.dart';

class AssetLineUserTemporaryDropdown extends StatefulWidget {
  const AssetLineUserTemporaryDropdown({Key? key}) : super(key: key);

  @override
  _AssetLineUserTemporaryDropdownState createState() =>
      _AssetLineUserTemporaryDropdownState();
}

class _AssetLineUserTemporaryDropdownState
    extends State<AssetLineUserTemporaryDropdown> {
  final assetInventoryLineController = Get.find<AssetInventoryLineController>();
  String? _selectedValueUserTemp;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: SearchChoicesWidget(
            items: assetInventoryLineController.listEmployees.map((element) {
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
            title: assetInventoryLineController
                    .currentInventoryLine.assetUserTemporary!.isEmpty
                ? "Chọn người sử dụng"
                : assetInventoryLineController
                    .currentInventoryLine.assetUserTemporary?[1],
            onChanged: (value) {
              List<dynamic>? employees = assetInventoryLineController
                      .currentInventoryLine.assetUserTemporary!.isEmpty
                  ? []
                  : assetInventoryLineController
                      .currentInventoryLine.assetUserTemporary;

              employees = assetInventoryLineController.listEmployees
                  .where((element) => element.id == value.id)
                  .map((element) => [element.id, element.name])
                  .toList();

              assetInventoryLineController
                  .currentInventoryLine.assetUserTemporary = employees[0];

              setState(() {
                _selectedValueUserTemp = value;
              });
            }));
  }
}
