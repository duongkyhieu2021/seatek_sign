import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/dropdown_button2_widget.dart';

class AssetLineStatusDropdown extends StatefulWidget {
  const AssetLineStatusDropdown({Key? key}) : super(key: key);

  @override
  _AssetLineStatusDropdownState createState() =>
      _AssetLineStatusDropdownState();
}

class _AssetLineStatusDropdownState extends State<AssetLineStatusDropdown> {
  final assetInventoryLineController = Get.find<AssetInventoryLineController>();
  String? _selectedValueStatus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: DropdownButton2Widget(
        hintText:
            assetInventoryLineController.currentInventoryLine.status == null
                ? "Chọn trạng thái"
                : assetInventoryLineController.statusLine(
                    assetInventoryLineController.currentInventoryLine.status!),
        items: assetInventoryLineController.listStatusLine
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
            assetInventoryLineController.currentInventoryLine.status = value;
          });
        },
      ),
    );
  }
}
