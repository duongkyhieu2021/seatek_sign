import 'package:equatable/equatable.dart';
//import 'package:odoo_repository/odoo_repository.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

class HrJob extends Equatable implements OdooRecord {
  @override
   int id;
  final String? name;
  final List<dynamic>? companyId;
  final List<dynamic>? departmentId;

   HrJob({
    required this.id,
    this.name,
    this.companyId,
    this.departmentId,
  });

  @override
  List<Object?> get props => [id, name, companyId, departmentId];

  static HrJob fromJson(Map<String, dynamic> json) {
    return HrJob(
      id: json['id'],
      name: json['name'],
      companyId: json['company_id'] == false ? [] : json['company_id'],
      departmentId: json['department_id'] == false ? [] : json['department_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "company_id": companyId,
      "department_id": departmentId,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    return {
      "id": id,
      "name": name,
      "company_id": companyId,
      "department_id": departmentId,
    };
  }

  static List<String> get oFields => [
        'id',
        'name',
        'company_id',
        'department_id',
      ];
}
