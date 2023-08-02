import 'dart:developer';

import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/asset_inventory_line/repository/record.dart';

class AssetInventoryLineRepository
    extends OdooRepository<AssetInventoryLineRecord> {
  @override
  final String modelName = 'asset.inventory.line';
  AssetInventoryLineRepository(OdooEnvironment env) : super(env);

  @override
  AssetInventoryLineRecord createRecordFromJson(Map<String, dynamic> json) {
    return AssetInventoryLineRecord.fromJson(json);
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
          'limit': limit,
          'fields': AssetInventoryLineRecord.oFields,
        },
      });

      return res;
    } catch (e) {
      log("$e", name: "AssetInventoryLineRepository - searchRead");
      return [];
    }
  }
  
}
