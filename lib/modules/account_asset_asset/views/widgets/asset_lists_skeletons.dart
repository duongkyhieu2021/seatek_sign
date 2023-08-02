import 'package:flutter/material.dart';
import 'package:sea_hr/modules/account_asset_asset/views/widgets/asset_item_skeleton.dart';


class AssetListsSkeletons extends StatelessWidget {
  const AssetListsSkeletons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) {
        return const AssetItemSkeleton();
      },
    ));
  }
}
