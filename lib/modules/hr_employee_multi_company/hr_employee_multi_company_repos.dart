import 'dart:developer';

//import 'package:odoo_repository/odoo_repository.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/hr_employee_multi_company/hr_employee_multi_company.dart';

class HrEmployeeMultiCompanyRepository
    extends OdooRepository<HrEmployeeMultiCompany> {
  @override
  final String modelName = 'hr.employee.multi.company';

  HrEmployeeMultiCompanyRepository(OdooEnvironment env) : super(env);

  @override
  HrEmployeeMultiCompany createRecordFromJson(Map<String, dynamic> json) {
    return HrEmployeeMultiCompany.fromJson(json);
  }

  @override
  Future<List<dynamic>> searchRead() async {
    try {
      List<dynamic> res = await env.orpc.callKw({
        'model': modelName,
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'domain': domain,
          'fields': HrEmployeeMultiCompany.oFields,
        },
      });
      return res;
    } catch (e) {
      log("$e", name: "HrEmployeeMultiCompanyRepository - searchRead");
      return [];
    }
  }
}
