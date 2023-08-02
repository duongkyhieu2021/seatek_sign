import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/account_asset_asset/controller/account_assset_asset_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/widgets/search_choices_widget.dart';

class AssetLineDropdown extends StatefulWidget {
  const AssetLineDropdown({Key? key}) : super(key: key);

  @override
  _AssetLineDropdownState createState() => _AssetLineDropdownState();
}

class _AssetLineDropdownState extends State<AssetLineDropdown> {
  final accountAssetController = Get.find<AccountAssetController>();
  final assetInventoryLineController = Get.find<AssetInventoryLineController>();

  Object? _selectedValueAsset;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: SearchChoicesWidget(
            items: accountAssetController.listAccountAsset.map((element) {
              return DropdownMenuItem<Object>(
                value: element,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    element.code.toString() != ""
                        ? '[${element.code.toString()}] ${element.name.toString()}'
                        : element.name.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
            selectedValue: _selectedValueAsset,
            title: assetInventoryLineController
                    .currentInventoryLine.assetId!.isEmpty
                ? "Chọn tài sản"
                : assetInventoryLineController.currentInventoryLine.assetId?[1],
            onChanged: (value) {
              List<dynamic>? assets = assetInventoryLineController
                      .currentInventoryLine.assetId!.isEmpty
                  ? []
                  : assetInventoryLineController.currentInventoryLine.assetId;

              assets = accountAssetController.listAccountAsset
                  .where((element) => element.id == value.id)
                  .map((element) => [element.id, element.name, element.code])
                  .toList();
              assetInventoryLineController.currentInventoryLine.assetId =
                  assets[0];
              setState(() {
                _selectedValueAsset = value;
              });
            }));
  }
}
