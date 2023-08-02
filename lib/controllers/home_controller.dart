import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:odoo_repository/odoo_repository.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/asset_inventory/repository/record.dart';
import 'package:sea_hr/modules/hr_employee_multi_company/hr_employee_multi_company.dart';
import 'package:sea_hr/modules/hr_employee_multi_company/hr_employee_multi_company_repos.dart';
import 'package:sea_hr/modules/res_company/repository/company.dart';
import 'package:sea_hr/modules/hr_department/repository/department.dart';
import 'package:sea_hr/modules/hr_employee/repository/employee.dart';
import 'package:sea_hr/modules/hr_job/repository/hr_job.dart';
import 'package:sea_hr/modules/res_user/repository/user.dart';
import 'package:sea_hr/modules/res_company/repository/company_repository.dart';
import 'package:sea_hr/modules/hr_department/repository/department_repository.dart';
import 'package:sea_hr/modules/hr_employee/repository/employee_repo.dart';
import 'package:sea_hr/modules/hr_job/repository/hr_job_repository.dart';
import 'package:sea_hr/modules/res_user/repository/user_repository.dart';

import '../modules/asset_inventory/controller/asset_inventory_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();
  TextEditingController selectCompanyController = TextEditingController();
  RxInt currentIndex = 0.obs;
  Rx<User> user = User.publicUser().obs;
  Rx<Company> companyUser = Company.initCompany().obs;
  RxList<Department> departmentsUserChanged = <Department>[].obs;

  /// 1 loading
  /// 2 success
  /// 3 error
  RxInt status = 0.obs;
  RxList<User> users = <User>[].obs;
  RxList<Company> companiesOfU = <Company>[].obs;
  RxList<EmployeeMulti> employeeMulti = <EmployeeMulti>[].obs;
  Rx<EmployeeMulti> employeePerson = EmployeeMulti(id: 0).obs;
  RxList<HrJob> hrJobs = <HrJob>[].obs;
  RxList<HrEmployeeMultiCompany> hrEmployeeMultiCompany =
      <HrEmployeeMultiCompany>[].obs;
  RxList<AssetInventoryRecord> listAssetInventory =
      <AssetInventoryRecord>[].obs;

  Future<int> changeCompany(int id) async {
    int result = await CompanyRepository(Get.find<MainController>().env)
        .changeCompany(id);
    if (result == 1) {
      Company? company = companiesOfU.firstWhereOrNull((p0) => p0.id == id);
      if (company != null) {
        companyUser.value = company;
      }
      UserRepository(Get.find<MainController>().env).fetchRecords();
      await handleCheckIfUserInChargeOfAnyDepartments();
      await AssetInventoryController.to.fetchRecordsInventory();
      await AssetInventoryController.to.fetchRecordsDepartmentByCompany();
      Get.back();
    }

    return result;
  }

  @override
  void onInit() async {
    status.value = 1;
    log("init home controller");
    await MainController.to.env.of<UserRepository>().fetchRecords();
    //
    await MainController.to.env.of<CompanyRepository>().fetchRecords();
    //
    await MainController.to.env.of<EmployeeRepository>().fetchRecords();
    //
    await MainController.to.env.of<HrJobRepository>().fetchRecords();
    //
    await MainController.to.env
        .of<HrEmployeeMultiCompanyRepository>()
        .fetchRecords();

    users.value = MainController.to.env.of<UserRepository>().latestRecords;

    if (users.isNotEmpty) {
      user.value = users[0];
    }
    companiesOfU.value =
        MainController.to.env.of<CompanyRepository>().latestRecords;

    await handleCheckIfUserInChargeOfAnyDepartments();

    if (user.value.companyId != null && user.value.companyId!.isNotEmpty) {
      int cId = user.value.companyId![0];
      try {
        companyUser.value = companiesOfU.where((p0) => p0.id == cId).first;
      } catch (e) {
        status.value = 3;
        log("company id $cId", name: "HomeController onInit");
        log("$e", name: "HomeController onInit");
      }
    }

    employeeMulti.value =
        MainController.to.env.of<EmployeeRepository>().latestRecords;

    hrJobs.value = MainController.to.env.of<HrJobRepository>().latestRecords;
    hrEmployeeMultiCompany.value = MainController.to.env
        .of<HrEmployeeMultiCompanyRepository>()
        .latestRecords;

    EmployeeMulti? employeeUser = employeeMulti.firstWhereOrNull(
      (element) {
        if (element.userId != null &&
            element.userId!.isNotEmpty &&
            element.userId![0] == user.value.id) {
          return true;
        }
        return false;
      },
    );

    employeeUser == null ? null : employeePerson.value = employeeUser;
    status.value = 2;
    selectCompanyController.text = "ABC";
    super.onInit();
  }

  Future<void> handleCheckIfUserInChargeOfAnyDepartments() async {
    try {
      departmentsUserChanged.value = [];
      OdooEnvironment env = Get.find<MainController>().env;
      UserRepository userRepository =
          Get.find<MainController>().env.of<UserRepository>();
      EmployeeRepository employeeRepository = EmployeeRepository(env);
      DepartmentRepository departmentRepository = DepartmentRepository(env);

      int userId = userRepository.userLogin.id;
      List<dynamic> employeeListBasedOnUserId =
          await employeeRepository.handleGetEmployeeBasedOnUserId(userId);

      if (employeeListBasedOnUserId.isNotEmpty) {
        if ((employeeListBasedOnUserId[0]['name'] as List).isNotEmpty) {
          List<dynamic> departmentsInCharge =
              await departmentRepository.searchDepartmentsUserInCharge(
                  employeeListBasedOnUserId[0]['name'][0]);

          for (var e in departmentsInCharge) {
            Department item = Department.fromJson(e);
            departmentsUserChanged.add(item);
          }
        }
      }
    } catch (e) {
      log("$e",
          name: "HomeController handleCheckIfUserInChargeOfAnyDepartments");
    }
  }
}
