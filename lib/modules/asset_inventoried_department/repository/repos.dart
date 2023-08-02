import 'dart:developer';

import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/asset_inventoried_department/repository/record.dart';


class AssetInventoryEmployeeRepository
    extends OdooRepository<AssetInventoryEmployeeRecord> {
  @override
  final String modelName = 'asset.inventoried.department';
  AssetInventoryEmployeeRepository(OdooEnvironment env) : super(env);

  @override
  AssetInventoryEmployeeRecord createRecordFromJson(Map<String, dynamic> json) {
    return AssetInventoryEmployeeRecord.fromJson(json);
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
          'fields': AssetInventoryEmployeeRecord.oFields,
        },
      });
      return res;
    } catch (e) {
      log("$e", name: "AssetInventoryEmployeeRepository - searchRead");
      return [];
    }
  }
}
