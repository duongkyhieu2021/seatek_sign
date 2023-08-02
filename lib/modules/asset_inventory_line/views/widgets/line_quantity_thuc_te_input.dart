
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/input_widget.dart';

class AssetQuantityThucTeInput extends StatelessWidget {
  const AssetQuantityThucTeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryLineController =
        Get.find<AssetInventoryLineController>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InputWidget(
        labelText: "Số lượng thực tế",
        onSaved: (value) => {},
        onChange: (value) {
          if (value.isEmpty) return;
          double? parsedValue = double.tryParse(value);
          if (parsedValue == null) {
            Fluttertoast.showToast(
              msg: 'Vui lòng nhập số',
              backgroundColor: Colors.red,
            );
          } else {
            assetInventoryLineController.currentInventoryLine.quantityThucTe =
                parsedValue;
          }
        },
        validator: (value) => null,
        initialValue: assetInventoryLineController
                    .currentInventoryLine.quantityThucTe ==
                0.0
            ? "0.0"
            : assetInventoryLineController.currentInventoryLine.quantityThucTe
                .toString(),
      ),
    );
  }
}
