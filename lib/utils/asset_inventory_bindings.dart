import 'package:get/get.dart';
import 'package:sea_hr/modules/account_asset_image/controller/account_asset_image_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/controller/asset_inventory_employee_controller.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';
import 'package:sea_hr/modules/asset_inventory_committee/controller/asset_inventory_committee_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';

class AssetInventoryBindings extends Bindings {
  @override
  void dependencies() {
    assetInventoryCommitteeController();
    assetInventoryEmployeeController();
    assetInventoryLineController();
    assetInventoryAssetTemporaryController();
    accountAssetImageController();
  }

  Future<void> assetInventoryCommitteeController() async {
    Get.put(AssetInventoryCommitteeController());
  }

  Future<void> assetInventoryEmployeeController() async {
    Get.put(AssetInventoryEmployeeController());
  }

  Future<void> assetInventoryLineController() async {
    Get.put(AssetInventoryLineController());
  }

  Future<void> assetInventoryAssetTemporaryController() async {
    Get.put(AssetInventoryAssetTemporaryController());
  }

  Future<void> accountAssetImageController() async {
    Get.put(AccountAssetImageController());
  }
}
