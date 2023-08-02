import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/line_lists_view.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_search.dart';
import 'package:sea_hr/widgets/list_empty.dart';

class AssetInventoryLineBody extends StatelessWidget {
  const AssetInventoryLineBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (AssetInventoryLineController.to.assetInventory.id != 0)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                const AssetInventoryLineSearch(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (AssetInventoryLineController.to.assetInventory.state ==
                        "draft")
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            await AssetInventoryController.to
                                .writeAssetInventory();
                            AssetInventoryLineController.to
                                .fetchRecordsStartInventoryLine();
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text("Bắt đầu kiểm kê"),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text("Process"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        Obx(() => AssetInventoryLineController.to.status.value == 1
            ? Center(
                child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.blue,
                size: 60,
              ))
            : AssetInventoryLineController.to.status.value == 3
                ? const Center(
                    child: Text("Lỗi ứng dụng, liên hệ Nhà phát triển."))
                : AssetInventoryLineController.to.listAssetInventoryLine.isEmpty
                    ? const ListEmpty(title: "Danh sách kiểm kê trống!")
                    : const AssetInventoryLineListsView()),
      ],
    );
  }
}
