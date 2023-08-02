import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/asset_inventory_committee/repository/record.dart';
import 'package:sea_hr/modules/asset_inventory_committee/repository/repos.dart';

class AssetInventoryCommitteeController extends GetxController
    with GetTickerProviderStateMixin {
  static AssetInventoryCommitteeController get to =>
      Get.find<AssetInventoryCommitteeController>();
  RxInt assetInventoryId = 0.obs;
  Rx<bool> isCreate = false.obs;
  Rx<bool> isCompleted = false.obs;
  TabController? tabController;
  RxInt status = 0.obs;
  AssetInventoryCommitteeRecord assetInventoryCommitteeRecord =
      AssetInventoryCommitteeRecord.initAssetInventoryCommittee();
  List<AssetInventoryCommitteeRecord> listAssetInventoryCommittee =
      <AssetInventoryCommitteeRecord>[];
  @override
  void onInit() async {
    log("init Asset Inventory Committee controller");
    status.value = 1;
    tabController = _createTabController(1);

    status.value = 2;
    super.onInit();
  }

  TabController _createTabController(int length) {
    return TabController(length: length, vsync: this);
  }

  void clearAssetInventoryCommitteeRecord() {
    assetInventoryCommitteeRecord =
        AssetInventoryCommitteeRecord.initAssetInventoryCommittee();
  }

  Future<void> fetchRecordsCommittee() async {
    // try {
    status.value = 1;
    final env = Get.find<MainController>().env;
    AssetInventoryCommitteeRepository inventoryCommitteeRepository =
        AssetInventoryCommitteeRepository(env);
    inventoryCommitteeRepository.domain = [
      ["asset_inventory_id", "=", assetInventoryId.value]
    ];
    await inventoryCommitteeRepository.fetchRecords();
    listAssetInventoryCommittee =
        inventoryCommitteeRepository.latestRecords.toList();
    status.value = 2;
  }

  //  ==============================
  Future<void> createAssetInventoryCommittee() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      isCompleted = false.obs;
      await env
          .of<AssetInventoryCommitteeRepository>()
          .create(assetInventoryCommitteeRecord)
          .then((value) {
        isCompleted = true.obs;
        Get.find<AssetInventoryCommitteeController>().fetchRecordsCommittee();
      }).catchError((error) {
        isCompleted = false.obs;
      });
      isCreate = false.obs;
    } catch (e) {
      log("$e", name: "AssetInventoryCommitteeController createAssetCommittee");
    }
  }

  Future<void> writeAssetInventoryCommittee() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      isCompleted = false.obs;
      AssetInventoryCommitteeRepository inventoryCommitteeRepository =
          env.of<AssetInventoryCommitteeRepository>();
      inventoryCommitteeRepository.domain = [
        ["asset_inventory_id", "=", assetInventoryId.value]
      ];
      await inventoryCommitteeRepository.fetchRecords();

      await env
          .of<AssetInventoryCommitteeRepository>()
          .write(assetInventoryCommitteeRecord)
          .then((value) {
        isCompleted = true.obs;
        Get.find<AssetInventoryCommitteeController>().fetchRecordsCommittee();
      }).catchError((error) {
        isCompleted = false.obs;
      });

      isCreate = false.obs;
    } catch (e) {
      log("$e", name: "AssetInventoryCommitteeController writeCommittee");
    }
  }
}
