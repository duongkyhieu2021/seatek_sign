import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/repository/record.dart';
import 'package:sea_hr/modules/asset_inventoried_department/repository/repos.dart';
import 'package:sea_hr/modules/hr_employee_temporary/employee_temporary.dart';
import 'package:sea_hr/modules/hr_employee_temporary/employee_temporary_repository.dart';

class AssetInventoryEmployeeController extends GetxController
    with GetTickerProviderStateMixin {
  static AssetInventoryEmployeeController get to =>
      Get.find<AssetInventoryEmployeeController>();
  RxInt assetInventoryId = 0.obs;
  Rx<bool> isCreate = false.obs;
  Rx<bool> isCompleted = false.obs;
  TabController? tabController;
  RxInt status = 0.obs;

  AssetInventoryEmployeeRecord assetInventoryEmployeeRecord =
      AssetInventoryEmployeeRecord.initAssetInventoryEmployee();
  RxList<AssetInventoryEmployeeRecord> listJobId =
      <AssetInventoryEmployeeRecord>[].obs;

  List<AssetInventoryEmployeeRecord> listAssetInventoryEmployee =
      <AssetInventoryEmployeeRecord>[];
  RxList<EmployeeTemporary> listEmployeesTemp = <EmployeeTemporary>[].obs;

  @override
  void onInit() async {
    log("init Asset Inventory Employee controller");
    status.value = 1;
    tabController = _createTabController(1);
    status.value = 2;
    super.onInit();
  }

  TabController _createTabController(int length) {
    return TabController(length: length, vsync: this);
  }

  void clearAssetInventoryEmployeeRecord() {
    assetInventoryEmployeeRecord =
        AssetInventoryEmployeeRecord.initAssetInventoryEmployee();
  }

  Future<void> fetchRecordsEmployee() async {
    try {
      status.value = 1;
      listAssetInventoryEmployee = [];
      final env = Get.find<MainController>().env;
      AssetInventoryEmployeeRepository inventoryEmployeeRepository =
          AssetInventoryEmployeeRepository(env);

      inventoryEmployeeRepository.domain = [
        ["asset_inventory_id", "=", assetInventoryId.value]
      ];
      await inventoryEmployeeRepository.fetchRecords();
      List<AssetInventoryEmployeeRecord> listAssetInventoryEmployeeTemp =
          inventoryEmployeeRepository.latestRecords.toList();
      final listHrEmployeeMultiCompany =
          Get.find<HomeController>().hrEmployeeMultiCompany;

      for (var inventoryEmployeeTemp in listAssetInventoryEmployeeTemp) {
        final result = listHrEmployeeMultiCompany.firstWhere(
            (element) => element.id == inventoryEmployeeTemp.employeeId![0]);

        inventoryEmployeeTemp.jobId = result.jobId ?? [];

        listAssetInventoryEmployee.add(inventoryEmployeeTemp);
        listJobId.value = listAssetInventoryEmployee;
      }

      status.value = 2;
    } catch (e) {
      log("$e", name: "AssetInventoryEmployeeController fetchRecordsEmployee");
    }
  }

  Future<void> fetchRecordsEmployeesTemp() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      EmployeeTemporaryRepository tempRepos = EmployeeTemporaryRepository(env);
      List<dynamic> domain = [];
      if (assetInventoryEmployeeRecord.department!.isNotEmpty) {
        domain.add([
          'department_id',
          '=',
          assetInventoryEmployeeRecord.department?[0]
        ]);
      }

      tempRepos.domain = domain;
      await tempRepos.fetchRecords();
      listEmployeesTemp.value = tempRepos.latestRecords;
      // log("listEmployeesTemp $listEmployeesTemp");
    } catch (e) {
      log("$e",
          name: "AssetInventoryEmployeeController fetchRecordsEmployeesTemp");
    }
  }

  Future<void> createAssetInventoryEmployee() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;

      isCompleted = false.obs;
      await env
          .of<AssetInventoryEmployeeRepository>()
          .create(assetInventoryEmployeeRecord)
          .then((result) {
        isCompleted = true.obs;
        Get.find<AssetInventoryEmployeeController>().fetchRecordsEmployee();
      }).catchError((error) {
        isCompleted = false.obs;
      });

      isCreate = false.obs;
    } catch (e) {
      log("$e",
          name:
              "AssetInventoryEmployeeController createAssetInventoryEmployee");
    }
  }

  Future<void> writeAssetInventoryEmployee() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      isCompleted = false.obs;
      AssetInventoryEmployeeRepository inventoryEmployeeRepository =
          env.of<AssetInventoryEmployeeRepository>();

      inventoryEmployeeRepository.domain = [
        ["asset_inventory_id", "=", assetInventoryId.value]
      ];
      await inventoryEmployeeRepository.fetchRecords();
      await env
          .of<AssetInventoryEmployeeRepository>()
          .write(assetInventoryEmployeeRecord)
          .then((value) {
        isCompleted = true.obs;
        Get.find<AssetInventoryEmployeeController>().fetchRecordsEmployee();
      }).catchError((error) {
        print("error $error");
        isCompleted = false.obs;
      });

      isCreate = false.obs;
    } catch (e) {
      log("$e",
          name: "AssetInventoryEmployeeController writeAssetInventoryEmployee");
    }
  }
}
