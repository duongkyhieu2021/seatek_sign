import 'package:equatable/equatable.dart';
//import 'package:odoo_repository/odoo_repository.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

// ignore: must_be_immutable
class EmployeeTemporary extends Equatable implements OdooRecord {
  @override
   int id;
  String? name;
  List<dynamic>? employeeId;
  List<dynamic>? companyId;
  List<dynamic>? departmentId;
  bool? active;

  EmployeeTemporary({
    required this.id,
    this.name,
    this.employeeId,
    this.companyId,
    this.departmentId,
    this.active,
  });

  @override
  List<Object?> get props => [id, name, employeeId, companyId, departmentId];

  static EmployeeTemporary fromJson(Map<String, dynamic> json) {
    return EmployeeTemporary(
      id: json['id'],
      name: json['name'] ?? "",
      employeeId: json['employee_id'] == false ? [] : json['employee_id'],
      companyId: json['company_id'] == false ? [] : json['company_id'],
      departmentId: json['department_id'] == false ? [] : json['department_id'],
      active: json['active'] == false ? false : json['active'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "employee_id": employeeId,
      "company_id": companyId,
      "department_id": departmentId,
      "active": active,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    return {
      "id": id,
      "name": name,
      "employee_id": employeeId!.isEmpty ? false : employeeId?[0],
      "company_id": companyId!.isEmpty ? false : companyId?[0],
      "department_id": departmentId!.isEmpty ? false : departmentId?[0],
      "active": active,
    };
  }

  static List<String> get oFields => [
        'id',
        'name',
        'employee_id',
        'company_id',
        'department_id',
        'active',
      ];
}
