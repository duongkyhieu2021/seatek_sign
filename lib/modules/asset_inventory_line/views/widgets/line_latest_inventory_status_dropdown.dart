import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/dropdown_button2_widget.dart';

class AssetLineLatestInventoryStatusDropdown extends StatefulWidget {
  const AssetLineLatestInventoryStatusDropdown({Key? key}) : super(key: key);

  @override
  _AssetLineLatestInventoryStatusDropdownState createState() =>
      _AssetLineLatestInventoryStatusDropdownState();
}

class _AssetLineLatestInventoryStatusDropdownState
    extends State<AssetLineLatestInventoryStatusDropdown> {
  final assetInventoryLineController = Get.find<AssetInventoryLineController>();
  String? _selectedValueStatus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: DropdownButton2Widget(
        hintText: assetInventoryLineController
                    .currentInventoryLine.latestInventoryStatus ==
                null
            ? "Latest Inventory Status"
            : assetInventoryLineController.latestInventoryStatusLine(
                assetInventoryLineController
                    .currentInventoryLine.latestInventoryStatus!),
        items: assetInventoryLineController.listLatestInventoryStatusLine
            .toList()
            .map((asset) => {
                  'id': asset.id,
                  'name': asset.name,
                })
            .toList(),
        value: _selectedValueStatus,
        onChanged: (value) {
          setState(() {
            _selectedValueStatus = value;
            assetInventoryLineController
                .currentInventoryLine.latestInventoryStatus = value;
          });
        },
      ),
    );
  }
}
