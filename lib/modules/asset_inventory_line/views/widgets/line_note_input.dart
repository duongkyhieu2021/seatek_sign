import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class AssetLineNoteInput extends StatelessWidget {
  const AssetLineNoteInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryLineController =
        Get.find<AssetInventoryLineController>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InputWidget(
        labelText: "Ghi chú",
        hintText: "Ghi chú",
        onSaved: (value) => {},
        onChange: (value) {
          assetInventoryLineController.currentInventoryLine.note = value;
        },
        validator: (value) => null,
        initialValue:
            assetInventoryLineController.currentInventoryLine.note ?? "",
      ),
    );
  }
}
