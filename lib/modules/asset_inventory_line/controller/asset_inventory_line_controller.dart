import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/account_asset_asset/repository/record.dart';
import 'package:sea_hr/modules/account_asset_asset/repository/repos.dart';
import 'package:sea_hr/modules/asset_inventory/repository/record.dart';
import 'package:sea_hr/modules/asset_inventory/repository/repos.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';
import 'package:sea_hr/utils/latest_inventory_status_line.dart';
import 'package:sea_hr/utils/status_line.dart';
import 'package:sea_hr/modules/asset_inventory_line/repository/record.dart';
import 'package:sea_hr/modules/asset_inventory_line/repository/repos.dart';
import 'package:sea_hr/modules/hr_employee_temporary/employee_temporary.dart';
import 'package:sea_hr/modules/hr_employee_temporary/employee_temporary_repository.dart';

class AssetInventoryLineController extends GetxController
    with GetTickerProviderStateMixin {
  static AssetInventoryLineController get to =>
      Get.find<AssetInventoryLineController>();
  TextEditingController searchController = TextEditingController();
  Rx<bool> isCreate = false.obs;
  Rx<bool> isCompleted = false.obs;
  TabController? tabController;
  RxInt status = 0.obs;
  AssetInventoryRecord assetInventory =
      AssetInventoryRecord.initAssetInventory();
  RxInt limit = 40.obs;
  RxInt beforeAssetInventoryLineLength = 0.obs;

  AssetInventoryLineRecord currentInventoryLine =
      AssetInventoryLineRecord.initAssetInventoryLine();
  List<AssetInventoryLineRecord> listAssetInventoryLineRecord = [];
  List<AssetInventoryLineRecord> listAssetInventoryLineStart = [];

  RxList<AssetInventoryLineRecord> listAssetInventoryLine =
      <AssetInventoryLineRecord>[].obs;

  List<AccountAssetAssetRecord> listAccountAssetAssetRecord = [];

  RxList<EmployeeTemporary> listEmployees = <EmployeeTemporary>[].obs;

  RxList<StatusLine> listStatusLine = <StatusLine>[
    StatusLine(id: "dang_su_dung", name: "Đang sử dụng"),
    StatusLine(id: "hu_hong", name: "Hư hỏng"),
  ].obs;

  RxList<LatestInventoryStatusLine> listLatestInventoryStatusLine =
      <LatestInventoryStatusLine>[
    LatestInventoryStatusLine(id: "good", name: "Good"),
    LatestInventoryStatusLine(
        id: "damaged_waiting_for_repair", name: "Damaged waiting for repair"),
    LatestInventoryStatusLine(
        id: "damaged_waiting_for_liquidation",
        name: "Damaged waiting for liquidation"),
    LatestInventoryStatusLine(id: "self_destruct", name: "Self destruct"),
  ].obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    log("init Asset Inventory Line controller");
    status.value = 1;
    tabController = _createTabController(1);
    OdooEnvironment env = Get.find<MainController>().env;
    AssetInventoryLineRepository assetInventoryLineRepository =
        AssetInventoryLineRepository(env);
    assetInventoryLineRepository.domain = [];
    await assetInventoryLineRepository.fetchRecords();
    listAssetInventoryLineRecord = assetInventoryLineRepository.latestRecords;

    await fetchRecordsEmployees();

    status.value = 2;
    super.onInit();
  }

  void focusOnItem(int index) {
    int line = 1;
    line = index == 0 ? 1 : index;
    scrollController.animateTo(line * 20,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  String statusLine(String value) {
    switch (value) {
      case "dang_su_dung":
        return "Đang sử dụng";
      case "hu_hong":
        return "Hư hỏng";
    }
    return "Đang trống";
  }

  String latestInventoryStatusLine(String value) {
    switch (value) {
      case "good":
        return 'Good';
      case "damaged_waiting_for_repair":
        return 'Damaged waiting for repair';
      case "damaged_waiting_for_liquidation":
        return 'Damaged waiting for liquidation';
      case "self_destruct":
        return 'Self destruct';
    }
    return 'Latest Inventory Status';
  }

  TabController _createTabController(int length) {
    return TabController(length: length, vsync: this);
  }

  void clearCurrentInventoryLine() {
    currentInventoryLine = AssetInventoryLineRecord.initAssetInventoryLine();
  }

  void clearAssetInventory() {
    assetInventory = AssetInventoryRecord.initAssetInventory();
  }

  Future<void> fetchRecordsInventoryLine() async {
    try {
      status.value = 1;
      OdooEnvironment env = Get.find<MainController>().env;
      AssetInventoryLineRepository assetInventoryLineRepository =
          AssetInventoryLineRepository(env);
      assetInventoryLineRepository.domain = [
        ['asset_inventory_id', '=', assetInventory.id],
      ];
      assetInventoryLineRepository.limit = limit.value;
      await assetInventoryLineRepository.fetchRecords();
      listAssetInventoryLine.value = assetInventoryLineRepository.latestRecords;
      status.value = 2;
    } catch (e) {
      status.value = 3;
      log("$e", name: "AssetInventoryLineController fetchRecordsInventoryLine");
    }
  }

  // Lấy danh sách tài sản
  Future<void> fetchAccountAssetOfInventory() async {
    try {
      status.value = 1;
      OdooEnvironment env = Get.find<MainController>().env;
      AccountAssetRepository tempRepos = AccountAssetRepository(env);
      List<dynamic> domainAccountAsset = [];
      listAccountAssetAssetRecord = [];

      if (assetInventory.department!.isNotEmpty) {
        domainAccountAsset
            .add(['management_dept', '=', assetInventory.department?[0]]);
      } else {
        domainAccountAsset.add([
          'company_id',
          '=',
          Get.find<HomeController>().companyUser.value.id
        ]);
      }

      if (assetInventory.seaOfficeId!.isNotEmpty) {
        domainAccountAsset
            .add(['sea_office_id', '=', assetInventory.seaOfficeId?[0]]);
      }

      tempRepos.domain = domainAccountAsset;
      tempRepos.limit = 0;

      await tempRepos.fetchRecords();
      listAccountAssetAssetRecord = tempRepos.latestRecords;

      await getListAssetInventoryLineStart();
      status.value = 2;
    } catch (e) {
      status.value = 3;
      log("$e", name: "AssetInventoryController fetchAccountAssetOfInventory");
    }
  }

  //  Load danh sách inventory line ban đầu (account asset + inventory line)
  Future<void> getListAssetInventoryLineStart() async {
    OdooEnvironment env = Get.find<MainController>().env;
    AssetInventoryLineRepository tempRepos = AssetInventoryLineRepository(env);
    tempRepos.domain = [
      ['asset_inventory_id', '=', assetInventory.id]
    ];
    await tempRepos.fetchRecords();
    listAssetInventoryLine.value = tempRepos.latestRecords.toList();
  }

  Future<void> fetchRecordsStartInventoryLine() async {
    try {
      status.value = 1;
      listAssetInventoryLine.value = [];

      OdooEnvironment env = Get.find<MainController>().env;

      AssetInventoryRepository assetInventoryRepository =
          AssetInventoryRepository(env);
      await assetInventoryRepository.createInventoryLine(assetInventory.id);

      //end dkh
      AssetInventoryLineRepository tempRepos =
          AssetInventoryLineRepository(env);
      tempRepos.domain = [
        ['asset_inventory_id', '=', assetInventory.id]
      ];
      await tempRepos.fetchRecords();
      listAssetInventoryLine.value = tempRepos.latestRecords.toList();
      //   });
      // }
      update();
      log("dkh load done");
      status.value = 2;
    } catch (e) {
      status.value = 3;
      log("$e",
          name: "AssetInventoryLineController fetchRecordsStartInventoryLine");
    }
  }

  Future<void> fetchRecordsEmployees() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      EmployeeTemporaryRepository tempRepos = EmployeeTemporaryRepository(env);
      tempRepos.domain = [];
      await tempRepos.fetchRecords();
      listEmployees.value = tempRepos.latestRecords;
    } catch (e) {
      log("$e", name: "AssetInventoryLineController fetchRecordsEmployees");
    }
  }

  //  ==============================
  Future<void> createAssetInventoryLine() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      AssetInventoryLineRepository tempRepos =
          AssetInventoryLineRepository(env);
      isCompleted = false.obs;
      await tempRepos.create(currentInventoryLine).then((value) {
        isCompleted = true.obs;
        Get.find<AssetInventoryLineController>().fetchRecordsInventoryLine();
      }).catchError((error) {
        isCompleted = false.obs;
      });
      isCreate = false.obs;
    } catch (e) {
      log("$e",
          name: "AssetInventoryCommitteeController createAssetInventoryLine");
    }
  }

  Future<void> writeAssetInventoryLine() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      env.of<AssetInventoryLineRepository>().domain = [
        ['asset_inventory_id', '=', assetInventory.id]
      ];
      await env.of<AssetInventoryLineRepository>().fetchRecords();
      isCompleted = false.obs;
      await env
          .of<AssetInventoryLineRepository>()
          .write(currentInventoryLine)
          .then((value) {
        isCompleted = true.obs;
      }).catchError((error) {
        isCompleted = false.obs;
      });

      isCreate = false.obs;
    } catch (e) {
      log("$e",
          name: "AssetInventoryCommitteeController writeAssetInventoryLine");
    }
  }

  // Scan inventory line
  Future<AssetInventoryLineRecord?> scannerAssetInventoryLine(
      String code) async {
    try {
      final env = Get.find<MainController>().env;
      AssetInventoryLineRepository assetInventoryRepository =
          AssetInventoryLineRepository(env);

      assetInventoryRepository.domain = [
        ['asset_inventory_id', '=', assetInventory.id],
        ['asset_code', '=', code],
      ];
      assetInventoryRepository.limit = 1;
      await assetInventoryRepository.fetchRecords();
      final results = assetInventoryRepository.latestRecords;
      log('result $results');
      return results.isEmpty ? null : results[0];
    } catch (e) {
      log("$e", name: "AssetInventoryLineController fetchRecordsInventoryLine");
      // Xử lý ngoại lệ cụ thể tại đây (nếu cần)
    }
    return null;
  }

  Future<void> searchAssetInventoryLine(String value) async {
    status.value = 1;

    OdooEnvironment env = Get.find<MainController>().env;
    AssetInventoryLineRepository tempRepos = AssetInventoryLineRepository(env);

    tempRepos.domain = [
      ['asset_inventory_id', '=', assetInventory.id],
      '|',
      ['asset_id.name', 'ilike', '%$value%'],
      ['asset_code', 'ilike', '%$value%'],
    ];
    tempRepos.limit = 0;
    await tempRepos.fetchRecords();
    listAssetInventoryLine.value = tempRepos.latestRecords;

    status.value = 2;
  }

  void handleOnTapTabBarAssetInventoryLine(value) async {
    switch (value) {
      case 0:
        await fetchRecordsInventoryLine();
        break;
      case 1:
        await AssetInventoryAssetTemporaryController.to
            .fetchAssetInventoryAssetTemporary();
        break;
      default:
    }
  }

  void load() async {
    log("load more");
    limit.value = limit.value + 40;
    await fetchRecordsInventoryLine();
  }

  Future<bool> loadMore() async {
    beforeAssetInventoryLineLength.value = limit.value;
    await Future.delayed(const Duration(seconds: 0, milliseconds: 500));
    load();
    return true;
  }
}
