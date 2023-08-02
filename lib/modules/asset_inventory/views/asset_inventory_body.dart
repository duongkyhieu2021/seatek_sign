import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventory/views/asset_inventory_lists.dart';
import 'package:sea_hr/widgets/list_empty.dart';

class AssetInventoryBody extends StatelessWidget {
  const AssetInventoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AssetInventoryController.to.status.value == 1
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.blue,
                size: 60,
              ),
            ))
        : AssetInventoryController.to.status.value == 3
            ? const Center(child: Text("Lỗi ứng dụng, liên hệ Nhà phát triển."))
            : AssetInventoryController.to.listAssetInventory.isNotEmpty
                ? const AssetInventoryLists()
                : const ListEmpty(
                    title: "Danh sách kiểm kê trống",
                  ));
  }
}
