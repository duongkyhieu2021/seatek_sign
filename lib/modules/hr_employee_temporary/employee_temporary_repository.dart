import 'dart:developer';

import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/hr_employee_temporary/employee_temporary.dart';

class EmployeeTemporaryRepository extends OdooRepository<EmployeeTemporary> {
  @override
  final String modelName = 'hr.employee.temporary';

  EmployeeTemporaryRepository(OdooEnvironment env) : super(env);

  @override
  EmployeeTemporary createRecordFromJson(Map<String, dynamic> json) {
    return EmployeeTemporary.fromJson(json);
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
          'fields': EmployeeTemporary.oFields,
        },
      });
      return res;
    } catch (e) {
      log("$e", name: "employee_repo - searchRead");
      return [];
    }
  }

  
}
