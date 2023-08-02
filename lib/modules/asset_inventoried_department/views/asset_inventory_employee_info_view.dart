import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventoried_department/controller/asset_inventory_employee_controller.dart';
import 'package:sea_hr/utils/show_dialog.dart';
import 'package:sea_hr/modules/asset_inventoried_department/views/asset_inventory_employee_general_view.dart';


class AssetInventoryEmployeeInfoView extends StatelessWidget {
  final bool isCreate;
  const AssetInventoryEmployeeInfoView({Key? key, required this.isCreate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final assetInventoryEmployeeController =
        Get.find<AssetInventoryEmployeeController>();

    assetInventoryEmployeeController.isCreate = isCreate.obs;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Thông tin nhân viên"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            assetInventoryEmployeeController.fetchRecordsEmployee();
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: assetInventoryEmployeeController.tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "Nhân viên"),
          ],
        ),
      ),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (assetInventoryEmployeeController.isCreate == true.obs) {
            assetInventoryEmployeeController
                .createAssetInventoryEmployee()
                .then((value) {
              if (assetInventoryEmployeeController.isCompleted == true.obs) {
                ShowDialog().showSuccessDialog(
                  context,
                  "Thông báo",
                  "Thêm nhân viên thành công!",
                  () {
                    Navigator.pop(context);
                    Get.back();
                  },
                );
              }
            });
          } else {
            print("update");
            assetInventoryEmployeeController
                .writeAssetInventoryEmployee()
                .then((value) {
              if (assetInventoryEmployeeController.isCompleted == true.obs) {
                ShowDialog().showSuccessDialog(
                  context,
                  "Thông báo",
                  "Cập nhật thông tin nhân viên thành công!",
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
        child: Text(assetInventoryEmployeeController.isCreate == false.obs
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
    AssetInventoryEmployeeController inventoryEmployeeController =
        Get.find<AssetInventoryEmployeeController>();
    return TabBarView(
      controller: inventoryEmployeeController.tabController,
      physics: const BouncingScrollPhysics(),
      children: const [
        AssetInventoryEmployeeGeneralView(),
      ],
    );
  }
}
