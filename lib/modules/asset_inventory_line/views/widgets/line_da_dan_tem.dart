import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';

class AssetLineDaDanTem extends StatefulWidget {
  const AssetLineDaDanTem({Key? key}) : super(key: key);

  @override
  _AssetLineDaDanTemState createState() => _AssetLineDaDanTemState();
}

class _AssetLineDaDanTemState extends State<AssetLineDaDanTem> {
  final assetInventoryLineController = Get.find<AssetInventoryLineController>();
  bool? _checkBoxDaDanTem = true;

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() {
    setState(() {
      _checkBoxDaDanTem =
          assetInventoryLineController.currentInventoryLine.daDanTem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Đã dán tem",
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFF09101D)),
          ),
          Checkbox(
            value: _checkBoxDaDanTem,
            onChanged: (value) {
              setState(() {
                _checkBoxDaDanTem = value;
              });
              assetInventoryLineController.currentInventoryLine.daDanTem =
                  value;
            },
          )
        ],
      ),
    );
  }
}
