import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class AssetLineGiaiTrinhInput extends StatelessWidget {
  const AssetLineGiaiTrinhInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryLineController =
        Get.find<AssetInventoryLineController>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InputWidget(
        labelText: "Giải trình đơn vị",
        hintText: "Giải trình đơn vị",
        onSaved: (value) => {},
        onChange: (value) {
          assetInventoryLineController.currentInventoryLine.giaiTrinh = value;
        },
        validator: (value) => null,
        initialValue:
            assetInventoryLineController.currentInventoryLine.giaiTrinh ?? "",
      ),
    );
  }
}
