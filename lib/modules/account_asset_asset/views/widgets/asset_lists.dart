import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:sea_hr/modules/account_asset_asset/controller/account_assset_asset_controller.dart';
import 'package:sea_hr/modules/account_asset_asset/repository/record.dart';
import 'package:sea_hr/widgets/icon_name_widget.dart';

import 'package:sea_hr/widgets/item_title.dart';

class AssetLists extends StatelessWidget {
  const AssetLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LoadMore(
        isFinish: AccountAssetController.to.beforeAccountAssetLength.value >=
            AccountAssetController.to.listAccountAsset.length + 5,
        onLoadMore: AccountAssetController.to.loadMore,
        whenEmptyLoad: true,
        delegate: const DefaultLoadMoreDelegate(),
        textBuilder: DefaultLoadMoreTextBuilder.english,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: AccountAssetController.to.listAccountAsset.length,
          itemBuilder: (context, index) {
            return _ItemAsset(
                asset: AccountAssetController.to.listAccountAsset[index]);
          },
        ),
      );
    });
  }
}

class _ItemAsset extends StatelessWidget {
  final AccountAssetAssetRecord asset;

  const _ItemAsset({
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Get.toNamed("/account_asset_info", arguments: [asset]);
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
                title: ItemTitle(title: "${asset.name?.toUpperCase()}"),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconNameWidget(
                            iconData: Icons.code,
                            name: asset.code?.isNotEmpty ?? false
                                ? asset.code.toString()
                                : "Trống",
                          ),
                          IconNameWidget(
                            iconData: Icons.qr_code,
                            name: asset.barcode?.isNotEmpty ?? false
                                ? asset.barcode.toString()
                                : "Trống",
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconNameWidget(
                            iconData: Icons.person_2_outlined,
                            name: asset.assetUser?.isNotEmpty ?? false
                                ? asset.assetUser![1]
                                : 'Trống',
                          ),
                          IconNameWidget(
                            iconData: Icons.location_on_outlined,
                            name: asset.seaOfficeId?.isNotEmpty ?? false
                                ? asset.seaOfficeId![1].toString()
                                : "Trống",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
