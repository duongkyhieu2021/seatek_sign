import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/repository/record.dart';
import 'package:sea_hr/widgets/icon_name_widget.dart';
import 'package:sea_hr/widgets/item_title.dart';

class AssetInventoryLineItemView extends StatelessWidget {
  final AssetInventoryLineRecord inventoryLine;
  const AssetInventoryLineItemView({
    super.key,
    required this.inventoryLine,
  });

  @override
  Widget build(BuildContext context) {
    final inventoryLineController = Get.find<AssetInventoryLineController>();
    return InkResponse(
      onTap: () {
        inventoryLineController.currentInventoryLine = inventoryLine;
        Get.toNamed("/asset_inventory_line_info_edit");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: ItemTitle(
                    title: inventoryLine.assetId!.isNotEmpty
                        ? inventoryLine.assetId![1].toString().toUpperCase()
                        : "Trống tên"),
                subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconNameWidget(
                                iconData: Icons.auto_stories_outlined,
                                name:
                                    "SL sổ sách: ${inventoryLine.quantitySoSach?.toStringAsFixed(0) ?? ''}"),
                          ],
                        ),
                        Row(
                          children: [
                            IconNameWidget(
                                iconData: Icons.analytics_outlined,
                                name:
                                    "Số lượng thực tế : ${inventoryLine.quantityThucTe?.toStringAsFixed(0) ?? ''}"),
                          ],
                        ),
                        Row(
                          children: [
                            IconNameWidget(
                                iconData: Icons.expand_outlined,
                                name:
                                    "Số lượng chênh lệch : ${inventoryLine.quantityChenhLech?.toStringAsFixed(0) ?? ''}"),
                          ],
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
