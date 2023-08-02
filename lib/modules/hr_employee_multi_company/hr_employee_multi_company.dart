import 'package:equatable/equatable.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

class HrEmployeeMultiCompany extends Equatable implements OdooRecord {
  @override
   int id;
  final List<dynamic>? name;
  final List<dynamic>? companyId;
  final List<dynamic>? departmentId;
  final List<dynamic>? jobId;

   HrEmployeeMultiCompany({
    required this.id,
    this.name,
    this.companyId,
    this.departmentId,
    this.jobId,
  });

  @override
  List<Object?> get props => [id, name, companyId, departmentId, jobId];

  static HrEmployeeMultiCompany fromJson(Map<String, dynamic> json) {
    return HrEmployeeMultiCompany(
      id: json['id'],
      name: json['name'] == false ? [] : json['name'],
      companyId: json['company_id'] == false ? [] : json['company_id'],
      departmentId: json['department_id'] == false ? [] : json['department_id'],
      jobId: json['job_id'] == false ? [] : json['job_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "company_id": companyId,
      "department_id": departmentId,
      "job_id": jobId,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    return {
      "id": id,
      "name": name,
      "company_id": companyId,
      "department_id": departmentId,
      "job_id": jobId,
    };
  }

  static List<String> get oFields => [
        'id',
        'name',
        'company_id',
        'department_id',
        'job_id',
      ];
}
