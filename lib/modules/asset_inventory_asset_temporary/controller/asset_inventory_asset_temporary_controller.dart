import 'dart:developer';

import 'package:get/get.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/account_asset_image/controller/account_asset_image_controller.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/repository/record.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/repository/repos.dart';

class AssetInventoryAssetTemporaryController extends GetxController {
  static AssetInventoryAssetTemporaryController get to =>
      Get.find<AssetInventoryAssetTemporaryController>();
  RxBool isCompleted = false.obs;
  RxInt status = 0.obs;
  Rx<bool> isCreate = false.obs;
  AssetInventoryAssetTemporaryRecord currentAssetInventoryAssetTemporary =
      AssetInventoryAssetTemporaryRecord.initAssetInventoryAssetTemporary();
  RxList<AssetInventoryAssetTemporaryRecord> listAssetInventoryAssetTemporary =
      <AssetInventoryAssetTemporaryRecord>[].obs;

  @override
  void onInit() {
    log("init AssetInventoryAssetTemporaryController");
    MainController mainController = Get.find<MainController>();
    OdooEnvironment env = mainController.env;
    AssetInventoryAssetTemporaryRepository tempRepos =
        AssetInventoryAssetTemporaryRepository(env);
    mainController.env.add(tempRepos);
    super.onInit();
  }

  void clearCurrentAssetInventoryAssetTemporary() {
    currentAssetInventoryAssetTemporary =
        AssetInventoryAssetTemporaryRecord.initAssetInventoryAssetTemporary();
  }

  Future<void> fetchAssetInventoryAssetTemporary() async {
    try {
      status.value = 1;
      OdooEnvironment env = Get.find<MainController>().env;
      AssetInventoryAssetTemporaryRepository tempRepos =
          AssetInventoryAssetTemporaryRepository(env);
      tempRepos.domain = [
        [
          'asset_inventory_id',
          '=',
          AssetInventoryController.to.currentInventory.id
        ],
      ];

      await tempRepos.fetchRecords();
      listAssetInventoryAssetTemporary.value = tempRepos.latestRecords;
      update();
      status.value = 2;
    } catch (e) {
      status.value = 3;
      log("$e",
          name:
              "AssetInventoryAssetTemporaryController fetchAssetInventoryAssetTemporary");
    }
  }

  Future<void> createAssetInventoryAssetTemporary() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      isCompleted.value = false;
      await env
          .of<AssetInventoryAssetTemporaryRepository>()
          .create(currentAssetInventoryAssetTemporary)
          .then((value) {
        currentAssetInventoryAssetTemporary = value;
        isCompleted.value = true;
      }).catchError((error) {
        isCompleted.value = false;
        log("createAssetInventoryAssetTemporary error $error");
      });
      isCreate = false.obs;
      update();
    } catch (e) {
      log("$e",
          name:
              "AssetInventoryAssetTemporaryController createAssetInventoryAssetTemporary");
    }
  }

  Future<void> writeAssetInventoryAssetTemporary() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      isCompleted.value = false;
      await env
          .of<AssetInventoryAssetTemporaryRepository>()
          .write(currentAssetInventoryAssetTemporary)
          .then((value) {
        isCompleted.value = true;
        fetchAssetInventoryAssetTemporary();
      }).catchError((error) {
        isCompleted.value = false;
        log("writeAssetInventoryAssetTemporary error $error");
      });
      // update();
    } catch (e) {
      log("$e",
          name:
              "AssetInventoryAssetTemporaryController writeAssetInventoryAssetTemporary");
    }
  }

  // NOTE: Hàm xử lý khi tạo một hiện vật
  void handleArtifactInfoCreate() {
    Get.toNamed("/artifact_info_create");
    clearCurrentAssetInventoryAssetTemporary();
    isCreate.value = true;
    currentAssetInventoryAssetTemporary.assetInventoryId = [
      AssetInventoryController.to.currentInventory.id
    ];
    AccountAssetImageController.to.selected.value = -1;
    AccountAssetImageController.to.tempListUploadImages.value = [];
    AccountAssetImageController.to.listAccountAssetImage.value = [];
  }

  // NOTE: Hàm xử lý khi nhấn vào 1 hiện vật
  void handleArtifactInfoEdit(int index) async {
    Get.toNamed("/artifact_info_edit");
    currentAssetInventoryAssetTemporary =
        listAssetInventoryAssetTemporary[index];
    isCreate.value = false;
    AccountAssetImageController.to.selected.value = -1;

    currentAssetInventoryAssetTemporary.assetInventoryId = [
      AssetInventoryController.to.currentInventory.id
    ];
    // NOTE: Gán ds ảnh tạm rỗng
    AccountAssetImageController.to.tempListUploadImages.value = [];
    await AccountAssetImageController.to.fetchAccountAssetImages();
  }
}
