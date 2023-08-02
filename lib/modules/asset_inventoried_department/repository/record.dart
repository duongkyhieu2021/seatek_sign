import 'package:equatable/equatable.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

class AssetInventoryEmployeeRecord extends Equatable implements OdooRecord {
  @override
   int id;
  List<dynamic>? assetInventoryId;
  List<dynamic>? department;
  List<dynamic>? employeeIdTemp;
  List<dynamic>? employeeId;
  List<dynamic>? jobId;

  AssetInventoryEmployeeRecord({
    required this.id,
    this.assetInventoryId,
    this.department,
    this.employeeIdTemp,
    this.employeeId,
    this.jobId,
  });

  factory AssetInventoryEmployeeRecord.initAssetInventoryEmployee() {
    return AssetInventoryEmployeeRecord(
      id: 0,
      assetInventoryId: const [],
      department: const [],
      employeeIdTemp: const [],
      employeeId: const [],
      jobId: const [],
    );
  }

  @override
  List<Object?> get props =>
      [id, assetInventoryId, department, employeeIdTemp, employeeId, jobId];

  static AssetInventoryEmployeeRecord fromJson(Map<String, dynamic> json) {
    return AssetInventoryEmployeeRecord(
      id: json['id'],
      assetInventoryId:
          json['asset_inventory_id'] == false ? [] : json['asset_inventory_id'],
      department: json['department'] == false ? [] : json['department'],
      employeeIdTemp:
          json['employee_id_temp'] == false ? [] : json['employee_id_temp'],
      employeeId: json['employee_id'] == false ? [] : json['employee_id'],
      jobId: json['jobId'] ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'asset_inventory_id': assetInventoryId,
      'department': department,
      'employee_id_temp': employeeIdTemp,
      'employee_id': employeeId,
      'job_id': jobId,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    return {
      'id': id,
      'asset_inventory_id':
          assetInventoryId!.isEmpty ? false : assetInventoryId?[0],
      'department': department!.isEmpty ? false : department?[0],
      'employee_id_temp': employeeIdTemp!.isEmpty ? false : employeeIdTemp?[0],
      'employee_id': employeeId!.isEmpty ? false : employeeId?[0],
      'job_id': jobId!.isEmpty ? false : jobId?[0],
    };
  }

  static List<String> get oFields => [
        'id',
        'asset_inventory_id',
        'department',
        'employee_id_temp',
        'employee_id',
        'job_id',
      ];
}
