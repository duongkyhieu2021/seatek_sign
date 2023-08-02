import 'package:flutter/material.dart';
import 'package:sea_hr/modules/asset_inventory/views/asset_inventory_item_skeleton.dart';


class AssetsInventorySkeletons extends StatelessWidget {
  const AssetsInventorySkeletons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) {
        return const AssetInventoryItemSkeleton();
      },
    ));
  }
}
