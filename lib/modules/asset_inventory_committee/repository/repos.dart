import 'dart:developer';

import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/asset_inventory_committee/repository/record.dart';


class AssetInventoryCommitteeRepository
    extends OdooRepository<AssetInventoryCommitteeRecord> {
  @override
  final String modelName = 'asset.inventory.committee';
  AssetInventoryCommitteeRepository(OdooEnvironment env) : super(env);

  @override
  AssetInventoryCommitteeRecord createRecordFromJson(
      Map<String, dynamic> json) {
    return AssetInventoryCommitteeRecord.fromJson(json);
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
          'fields': AssetInventoryCommitteeRecord.oFields,
        },
      });
      return res;
    } catch (e) {
      log("$e", name: "AssetInventoryCommitteeRepository - searchRead");
      return [];
    }
  }

  
}
