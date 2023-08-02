import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/utils/show_dialog.dart';
import 'package:sea_hr/modules/asset_inventory_committee/controller/asset_inventory_committee_controller.dart';
import 'asset_inventory_committee_general_view.dart';

class AssetInventoryCommitteeInfoView extends StatelessWidget {
  final bool isCreate;
  const AssetInventoryCommitteeInfoView({Key? key, required this.isCreate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final assetInventoryCommitteeController =
        Get.find<AssetInventoryCommitteeController>();

    assetInventoryCommitteeController.isCreate = isCreate.obs;

    return Obx(() {
      return assetInventoryCommitteeController.status.value == 1
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: const Text("Thông tin kiểm kê"),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    assetInventoryCommitteeController.fetchRecordsCommittee();
                    Navigator.pop(context);
                  },
                ),
                bottom: TabBar(
                  controller: assetInventoryCommitteeController.tabController,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: "Ban Kiểm kê"),
                  ],
                ),
              ),
              // bottomNavigationBar: homeController.status.value == 1
              //     ? null
              //     : const BottomNavigatorAppBar(),
              body: const Body(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (assetInventoryCommitteeController.isCreate == true.obs) {
                    assetInventoryCommitteeController
                        .createAssetInventoryCommittee()
                        .then((value) {
                      if (assetInventoryCommitteeController.isCompleted ==
                          true.obs) {
                        ShowDialog().showSuccessDialog(
                          context,
                          "Thông báo",
                          "Tạo ban kiểm kê thành công!",
                          () {
                            Navigator.pop(context);
                            Get.back();
                          },
                        );
                      }
                    });
                  } else {
                    assetInventoryCommitteeController
                        .writeAssetInventoryCommittee()
                        .then((value) {
                      if (assetInventoryCommitteeController.isCompleted ==
                          true.obs) {
                        ShowDialog().showSuccessDialog(
                          context,
                          "Thông báo",
                          "Cập nhật ban kiểm kê thành công!",
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
                child: Text(
                    assetInventoryCommitteeController.isCreate == false.obs
                        ? "Lưu"
                        : "Tạo"),
              ),
            );
    });
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetInventoryCommitteeController inventoryCommitteeController =
        Get.find<AssetInventoryCommitteeController>();
    return TabBarView(
      controller: inventoryCommitteeController.tabController,
      physics: const BouncingScrollPhysics(),
      children: const [
        AssetInventoryCommitteeGeneralView(),
      ],
    );
  }
}
