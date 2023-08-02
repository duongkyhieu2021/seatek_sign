import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/modules/account_asset_asset/controller/account_assset_asset_controller.dart';
import 'package:sea_hr/modules/account_asset_asset/views/widgets/asset_lists.dart';
import 'package:sea_hr/modules/account_asset_asset/views/widgets/search_input_widget.dart';
import '../../../../widgets/list_empty.dart';

class AccountAssetPage extends StatelessWidget {
  const AccountAssetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            const SearchInputWidget(),
            AccountAssetController.to.listAccountAsset.isNotEmpty
                ? const Expanded(child: AssetLists())
                : const ListEmpty(
                    title: "Không tìm thấy",
                  )
          ],
        ));
  }
}
