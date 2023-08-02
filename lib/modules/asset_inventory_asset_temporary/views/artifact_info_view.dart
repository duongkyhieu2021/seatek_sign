// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/account_asset_image/controller/account_asset_image_controller.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/artifact_body_view.dart';

class ArtifactInfoView extends StatelessWidget {
  final bool isCreate;
  const ArtifactInfoView({
    Key? key,
    required this.isCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("Thông tin hiện vật"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AssetInventoryAssetTemporaryController.to
                  .clearCurrentAssetInventoryAssetTemporary();
              Navigator.pop(context);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (AssetInventoryAssetTemporaryController.to.isCreate.value ==
                true) {
              // NOTE: Tạo 1 hiện vật
              await AssetInventoryAssetTemporaryController.to
                  .createAssetInventoryAssetTemporary();

              // NOTE: Thêm ảnh mới
              if (AccountAssetImageController
                  .to.tempListUploadImages.isNotEmpty) {
                await AccountAssetImageController.to.handleCreateImageUpload();
                if (AccountAssetImageController.to.isCompleted.value = true) {
                  // Fluttertoast.showToast(
                  //     msg: "Tạo hiện vật thành công!",
                  //     gravity: ToastGravity.BOTTOM,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: Colors.green,
                  //     textColor: Colors.white,
                  //     fontSize: 16.0);
                  await AssetInventoryAssetTemporaryController.to
                      .fetchAssetInventoryAssetTemporary();
                  await AccountAssetImageController.to
                      .fetchAccountAssetImages();
                }
              }
            } else {
              await AssetInventoryAssetTemporaryController.to
                  .writeAssetInventoryAssetTemporary();

              // NOTE: Thêm ảnh mới
              if (AccountAssetImageController
                  .to.tempListUploadImages.isNotEmpty) {
                // NOTE: Tạo ảnh
                await AccountAssetImageController.to.handleCreateImageUpload();
              }
              // NOTE: Xóa ảnh
              await AccountAssetImageController.to.handleUnlinkImageUpload();
              // NOTE: Cập nhật hình ảnh
              await AccountAssetImageController.to.handleUpdateImage();
              if (AccountAssetImageController.to.isCompleted.value = true) {
                Fluttertoast.showToast(
                    msg: "Lưu hiện vật thành công!",
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                AccountAssetImageController.to.selected.value = -1;
                await AssetInventoryAssetTemporaryController.to
                    .fetchAssetInventoryAssetTemporary();
                await AccountAssetImageController.to.fetchAccountAssetImages();
              }
            }
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: GetBuilder<AssetInventoryAssetTemporaryController>(
            builder: (controller) => Text(
                AssetInventoryAssetTemporaryController.to.isCreate.value ==
                        false
                    ? "Lưu"
                    : "Tạo"),
          ),
        ),
        body: const ArtifactBodyView(),
      ),
    );
  }
}
