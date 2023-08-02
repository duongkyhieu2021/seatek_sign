import 'package:get/get.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/modules/account_asset_asset/controller/account_assset_asset_controller.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    homeController();
    accountAssetController();
    assetInventoryController();
  }

  Future<void> homeController() async {
    Get.put(HomeController());
  }

  Future<void> accountAssetController() async {
    Get.put(AccountAssetController());
  }

  Future<void> assetInventoryController() async {
    Get.put(AssetInventoryController());
  }
}
