import 'dart:developer';

//import 'package:odoo_repository/odoo_repository.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/hr_department_temporary/department_temporary.dart';

class DepartmentTemporaryRepository
    extends OdooRepository<DepartmentTemporary> {
  @override
  final String modelName = 'hr.department.temporary';
  DepartmentTemporaryRepository(OdooEnvironment env) : super(env);

  @override
  DepartmentTemporary createRecordFromJson(Map<String, dynamic> json) {
    return DepartmentTemporary.fromJson(json);
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
          'fields': DepartmentTemporary.oFields,
        },
      });
      return res;
    } catch (e) {
      log("$e", name: "DepartmentTemporaryRepository - searchRead");
      return [];
    }
  }
}
