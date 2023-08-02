import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/account_asset_asset/repository/record.dart';
import 'package:sea_hr/modules/account_asset_asset/repository/repos.dart';

class AccountAssetController extends GetxController {
  static AccountAssetController get to => Get.find<AccountAssetController>();
  TabController? tabController;
  RxInt status = 0.obs;
  RxInt limit = 40.obs;
  RxInt beforeAccountAssetLength = 0.obs;
  RxList<AccountAssetAssetRecord> listAccountAsset =
      <AccountAssetAssetRecord>[].obs;
  TextEditingController searchCodeController = TextEditingController();

  String statusSign(String value) {
    switch (value) {
      case "draft":
        return "Nháp";
      case "open":
        return "Đang sử dụng";
      case "pending":
        return "Đang chờ";
      case "liquidation":
        return "Thanh lý";
      case "close":
        return "Đã đóng";
    }
    return "Unknown state";
  }

  Color statusSignColor(String value) {
    switch (value) {
      case "draft":
        return Colors.grey;
      case "open":
        return Colors.red;
      case "pending":
        return Colors.orange;
      case "liquidation":
        return Colors.green;
      case "close":
        return Colors.red;
    }
    return Colors.grey;
  }

  @override
  void onInit() async {
    log("init account asset controller");
    await fetchRecordsAccountAsset();
    super.onInit();
  }

  Future<void> fetchRecordsAccountAsset() async {
    try {
      status.value = 1;
      OdooEnvironment env = Get.find<MainController>().env;
      AccountAssetRepository tempRepos = AccountAssetRepository(env);
      tempRepos.limit = limit.value;
      await tempRepos.fetchRecords();
      listAccountAsset.value = tempRepos.latestRecords;
      status.value = 2;
    } catch (e) {
      status.value = 3;
      log("$e", name: "AccountAssetController fetchRecordsAccountAsset");
    }
  }

  Future<void> searchAssetByCode(String value) async {
    status.value = 1;

    OdooEnvironment env = Get.find<MainController>().env;
    AccountAssetRepository tempRepos = AccountAssetRepository(env);
    tempRepos.domain = [
      '|',
      ['name', 'ilike', '%$value%'],
      ['code', 'ilike', '%$value%'],
    ];
    tempRepos.limit = limit.value;
    await tempRepos.fetchRecords();
    listAccountAsset.value = tempRepos.latestRecords;
    status.value = 2;
  }

  void load() async {
    limit.value = limit.value + 40;
    await fetchRecordsAccountAsset();
  }

  Future<bool> loadMore() async {
    beforeAccountAssetLength.value = limit.value;
    await Future.delayed(const Duration(seconds: 0, milliseconds: 500));
    load();
    return true;
  }

}
