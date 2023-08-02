import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/general_view.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/asset_inventory_line_view.dart';

class AssetInventoryInfoView extends StatelessWidget {
  final bool isCreate;
  const AssetInventoryInfoView({Key? key, required this.isCreate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    AssetInventoryController.to.currentInventory.companyId = [
      HomeController.to.companyUser.value.id,
      HomeController.to.companyUser.value.name,
      HomeController.to.companyUser.value.shortName
    ];
    AssetInventoryController.to.fetchRecordsDepartmentByCompany();

    AssetInventoryController.to.isCreate = isCreate.obs;
    return AssetInventoryController.to.status.value == 1
        ? Center(
            child: LoadingAnimationWidget.prograssiveDots(
            color: Colors.blue,
            size: 60,
          ))
        : SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: const Text("Thông tin kiểm kê"),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    AssetInventoryController.to.tabController?.index = 0;
                    AssetInventoryController.to.fetchRecordsInventory();
                    Navigator.pop(context);
                  },
                ),
                bottom: TabBar(
                  onTap: AssetInventoryController.to.handleOnTapTabBar,
                  controller: AssetInventoryController.to.tabController,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: "Thông tin chung"),
                    Tab(text: "Danh sách kiểm kê"),
                  ],
                ),
              ),
              body: const Body(),
            ),
          );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetInventoryController inventoryController =
        Get.find<AssetInventoryController>();

    return TabBarView(
      controller: inventoryController.tabController,
      physics: const BouncingScrollPhysics(),
      children: const [
        AssetInventoryGeneralView(),
        AssetInventoryLineView(),
      ],
    );
  }
}
