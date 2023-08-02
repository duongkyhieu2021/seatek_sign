import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/asset_committee_position/repository/record.dart';
import 'package:sea_hr/modules/asset_committee_position/repository/repos.dart';
import 'package:sea_hr/modules/asset_inventoried_department/repository/repos.dart';
import 'package:sea_hr/modules/asset_inventory/repository/repos.dart';
import 'package:sea_hr/modules/asset_inventory/repository/record.dart';
import 'package:sea_hr/modules/asset_inventory_committee/repository/record.dart';
import 'package:sea_hr/modules/asset_inventory_committee/repository/repos.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/repository/repos.dart';
import 'package:sea_hr/modules/hr_department/repository/department.dart';
import 'package:sea_hr/modules/hr_department/repository/department_repository.dart';
import 'package:sea_hr/modules/hr_employee_temporary/employee_temporary.dart';
import 'package:sea_hr/modules/hr_employee_temporary/employee_temporary_repository.dart';
import 'package:sea_hr/modules/sea_office/sea_office.dart';
import 'package:sea_hr/modules/sea_office/sea_office_repository.dart';

class AssetInventoryController extends GetxController
    with GetTickerProviderStateMixin {
  static AssetInventoryController get to =>
      Get.find<AssetInventoryController>();
  RxInt lineIndex = 0.obs;
  Rx<bool> isCreate = false.obs;
  Rx<bool> isCompleted = false.obs;
  TabController? tabController;
  RxInt status = 0.obs;
  RxInt companyId = 0.obs;
  RxInt limit = 40.obs;
  Rx<AssetInventoryCommitteeRecord> assetInventoryCommittee =
      AssetInventoryCommitteeRecord.initAssetInventoryCommittee().obs;

  AssetInventoryRecord currentInventory =
      AssetInventoryRecord.initAssetInventory();

  RxList<AssetInventoryRecord> listAssetInventory =
      <AssetInventoryRecord>[].obs;
  RxList<AssetInventoryCommitteeRecord> listAssetInventoryCommittee =
      <AssetInventoryCommitteeRecord>[].obs;
  RxList<Department> listDepartment = <Department>[].obs;
  RxList<EmployeeTemporary> listEmployees = <EmployeeTemporary>[].obs;
  RxList<AssetCommitteePositionRecord> listPosition =
      <AssetCommitteePositionRecord>[].obs;

  RxList<SeaOffice> listSeaOffice = <SeaOffice>[].obs;

  @override
  void onInit() async {
    log("init Asset Inventory controller");

    tabController = _createTabController(2);

    MainController mainController = Get.find<MainController>();
    OdooEnvironment env = mainController.env;
    AssetInventoryRepository assetInventoryRepositoryRepos =
        AssetInventoryRepository(env);
    AssetInventoryCommitteeRepository assetInventoryCommittee =
        AssetInventoryCommitteeRepository(env);
    SeaOfficeRepository seaOffice = SeaOfficeRepository(env);
    AssetCommitteePositionRepository positionRepos =
        AssetCommitteePositionRepository(env);
    AssetInventoryEmployeeRepository assetInventoryEmployeeRepos =
        AssetInventoryEmployeeRepository(env);

    mainController.env.add(assetInventoryCommittee);
    mainController.env.add(seaOffice);
    mainController.env.add(positionRepos);
    mainController.env.add(assetInventoryRepositoryRepos);
    mainController.env.add(AssetInventoryLineRepository(env));
    mainController.env.add(assetInventoryEmployeeRepos);

    await env.of<SeaOfficeRepository>().fetchRecords();
    await env.of<AssetCommitteePositionRepository>().fetchRecords();

    await fetchRecordsEmployeeByCompany();

    listSeaOffice.value = seaOffice.latestRecords.toList();
    listPosition.value = positionRepos.latestRecords.toList();

    super.onInit();
  }

  TabController _createTabController(int length) {
    return TabController(length: length, vsync: this);
  }

  Future<int> fetchRecordsInventory() async {
    try {
      status.value = 1;
      final env = Get.find<MainController>().env;
      AssetInventoryRepository tempRepos = AssetInventoryRepository(env);
      tempRepos.order = 'write_date desc';
      tempRepos.domain = [
        ['company_id', '=', Get.find<HomeController>().companyUser.value.id]
      ];
      tempRepos.limit = limit.value;
      await tempRepos.fetchRecords();

      listAssetInventory.value = tempRepos.latestRecords.toList();

      status.value = 2;

      return listAssetInventory.length;
    } catch (e) {
      status.value = 3;
      log("$e", name: "AssetInventoryController fetchRecordsInventory");
      return 0;
    }
  }

  Future<void> fetchRecordsInventoryCommittee(int assetInventoryId) async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      AssetInventoryCommitteeRepository tempRepos =
          AssetInventoryCommitteeRepository(env);
      tempRepos.domain = [
        ['asset_inventory_id', '=', assetInventoryId]
      ];
      await tempRepos.fetchRecords();
      listAssetInventoryCommittee.addAll(tempRepos.latestRecords);
    } catch (e) {
      log("$e", name: "AssetInventoryController listAssetInventoryCommittee");
    }
  }

  void clearCurrentInventory() {
    currentInventory = AssetInventoryRecord.initAssetInventory();
  }

  Future<void> fetchRecordsDepartmentByCompany() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      DepartmentRepository tempRepos = DepartmentRepository(env);

      tempRepos.domain = [
        ['company_id', '=', Get.find<HomeController>().companyUser.value.id]
      ];
      await tempRepos.fetchRecords();
      listDepartment.value = tempRepos.latestRecords;
      // log("listDepartment $listDepartment");
    } catch (e) {
      log("$e",
          name: "AssetInventoryController fetchRecordsDepartmentByCompany");
    }
  }

  Future<void> fetchRecordsEmployeeByCompany() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      EmployeeTemporaryRepository tempRepos = EmployeeTemporaryRepository(env);
      tempRepos.domain = [
        ['department_id', '=', 235]
      ];
      await tempRepos.fetchRecords();
      listEmployees.value = tempRepos.latestRecords;
    } catch (e) {
      log("$e", name: "AssetInventoryController fetchRecordsEmployeeByCompany");
    }
  }

  //  ==============================
  Future<void> createAssetInventory() async {
    try {
      log("dkh start createAssetInventory");
      OdooEnvironment env = Get.find<MainController>().env;
      AssetInventoryRepository tempRepos = env.of<AssetInventoryRepository>();
      isCompleted = false.obs;
      await tempRepos.create(currentInventory).then((result) {
        Get.find<AssetInventoryController>()
            .fetchRecordsInventory()
            .then((result) {
          lineIndex.value = result;
        });
        isCompleted = true.obs;
      }).catchError((error) {
        isCompleted = false.obs;
      });

      isCreate = false.obs;
    } catch (e) {
      log("$e", name: "AssetInventoryController createAssetInventory");
    }
  }

  Future<void> writeAssetInventory() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      AssetInventoryRepository tempRepos = env.of<AssetInventoryRepository>();
      tempRepos.order = 'write_date desc';
      tempRepos.domain = [
        ['company_id', '=', Get.find<HomeController>().companyUser.value.id]
      ];
      tempRepos.limit = limit.value;
      await tempRepos.fetchRecords();

      isCompleted = false.obs;
      await env
          .of<AssetInventoryRepository>()
          .write(currentInventory)
          .then((result) {
        isCompleted = true.obs;
        Get.find<AssetInventoryController>().fetchRecordsInventory();
      }).catchError((error) {
        isCompleted = false.obs;
      });

      isCreate = false.obs;
    } catch (e) {
      log("$e", name: "AssetInventoryController writeAssetInventory");
    }
  }

  // NOTE: Xử lý sự kiện khi nhấn vào Tab Bar page inventory
  void handleOnTapTabBar(value) {
    if (value == 0) {
      AssetInventoryLineController.to.fetchAccountAssetOfInventory();
    }
    if (value == 1) {
      AssetInventoryLineController.to.fetchRecordsInventoryLine();
    }
  }
}
