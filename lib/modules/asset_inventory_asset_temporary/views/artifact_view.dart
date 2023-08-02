import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/artifact_list_view.dart';
import 'package:sea_hr/widgets/list_empty.dart';

class ArtifactView extends StatelessWidget {
  const ArtifactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AssetInventoryAssetTemporaryController.to.status.value == 1
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.blue,
                size: 60,
              ),
            ))
        : AssetInventoryAssetTemporaryController.to.status.value == 3
            ? const Center(child: Text("Lỗi ứng dụng, liên hệ Nhà phát triển."))
            : Container(
                padding: const EdgeInsets.all(12.0),
                child: const ArtifactListView()));
  }
}
