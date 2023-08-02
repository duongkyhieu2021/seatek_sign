import 'package:get/get.dart';
//import 'package:odoo_repository/odoo_repository.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
//import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:sea_hr/OdooRepository/OdooRpc/odoo_rpc.dart';
import 'package:sea_hr/config.dart';
import 'package:sea_hr/models/network_connect.dart';
import 'package:sea_hr/models/odoo_kv_hive_impl.dart';
import 'package:sea_hr/modules/asset_inventory/repository/repos.dart';
import 'package:sea_hr/modules/hr_employee_multi_company/hr_employee_multi_company_repos.dart';
import 'package:sea_hr/modules/res_company/repository/company_repository.dart';
import 'package:sea_hr/modules/hr_employee/repository/employee_repo.dart';
import 'package:sea_hr/modules/hr_job/repository/hr_job_repository.dart';
import 'package:sea_hr/modules/res_user/repository/user_repository.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  OdooKvHive cache = OdooKvHive();
  NetworkConnectivity netConn = NetworkConnectivity();
  late OdooEnvironment env;

  RxInt currentIndexOfNavigatorBottom = 0.obs;

  Future<void> logout() async {
    UserRepository(env).logOutUser();
    cache.delete(Config.cacheSessionKey);
    Get.offAllNamed("/login");
    currentIndexOfNavigatorBottom.value = 0;
  }

  Future init() async {
    await cache.init();
    OdooSession? session =
        cache.get(Config.cacheSessionKey, defaultValue: null);

    env = OdooEnvironment(OdooClient(Config.odooServerURL, session),
        Config.odooDbName, cache, netConn);

    env.add(UserRepository(env));
    env.add(CompanyRepository(env));
    env.add(EmployeeRepository(env));
    env.add(HrJobRepository(env));
    env.add(AssetInventoryRepository(env));
    env.add(HrEmployeeMultiCompanyRepository(env));

    update();
  }
}
