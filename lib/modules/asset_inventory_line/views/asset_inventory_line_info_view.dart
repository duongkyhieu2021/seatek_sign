import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/utils/show_dialog.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/asset_inventory_line_general_view.dart';
import 'package:sea_hr/widgets/bottom_navigator_bar.dart';


class AssetInventoryLineInfoView extends StatelessWidget {
  final bool isCreate;
  const AssetInventoryLineInfoView({Key? key, required this.isCreate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final homeController = Get.find<HomeController>();
    final assetInventoryLineController =
        Get.find<AssetInventoryLineController>();
    final assetInventoryController = Get.find<AssetInventoryController>();

    assetInventoryLineController.currentInventoryLine.assetInventoryId = [
      assetInventoryController.currentInventory.id,
      assetInventoryController.currentInventory.name
    ];

    assetInventoryLineController.isCreate = isCreate.obs;
    return assetInventoryLineController.status.value == 1
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text("Thông tin danh sách kiểm kê"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: TabBar(
                controller: assetInventoryLineController.tabController,
                isScrollable: true,
                tabs: const [
                  Tab(text: "Danh sách Kiểm kê"),
                ],
              ),
            ),
            bottomNavigationBar: homeController.status.value == 1
                ? null
                : const BottomNavigatorAppBar(),
            body: const SafeArea(child: Body()),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (assetInventoryLineController.isCreate == true.obs) {
                  assetInventoryLineController
                      .createAssetInventoryLine()
                      .then((value) {
                    if (assetInventoryLineController.isCompleted == true.obs) {
                      ShowDialog().showSuccessDialog(
                        context,
                        "Thông báo",
                        "Tạo tài sản kiểm kê thành công!",
                        () {
                          Navigator.pop(context);
                          Get.back();
                        },
                      );
                    }
                  });
                } else {
                  assetInventoryLineController
                      .writeAssetInventoryLine()
                      .then((value) {
                    if (assetInventoryLineController.isCompleted == true.obs) {
                      ShowDialog().showSuccessDialog(
                        context,
                        "Thông báo",
                        "Cập nhật tài sản kiểm kê thành công!",
                        () {
                          Navigator.pop(context);
                          Get.back();
                        },
                      );
                    }
                  });
                }
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(assetInventoryLineController.isCreate == false.obs
                  ? "Lưu"
                  : "Tạo"),
            ),
          );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetInventoryLineController inventoryLineController =
        Get.find<AssetInventoryLineController>();

    return TabBarView(
      controller: inventoryLineController.tabController,
      physics: const BouncingScrollPhysics(),
      children: const [
        AssetInventoryLineGeneralView(),
      ],
    );
  }
}
