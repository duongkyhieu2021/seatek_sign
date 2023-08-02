import 'dart:developer';

import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/asset_inventory/repository/record.dart';

class AssetInventoryRepository extends OdooRepository<AssetInventoryRecord> {
  @override
  final String modelName = 'asset.inventory';

  AssetInventoryRepository(OdooEnvironment env) : super(env);

  @override
  AssetInventoryRecord createRecordFromJson(Map<String, dynamic> json) {
    return AssetInventoryRecord.fromJson(json);
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
          'order': 'write_date desc',
          'limit': limit,
          'fields': AssetInventoryRecord.oFields,
        },
      });

      return res;
    } catch (e) {
      log("$e", name: "AssetInventoryRepository - searchRead");
      return [];
    }
  }

  Future<void> createInventoryLine(int assetInventoryId) async {
    try {
      dynamic res = await env.orpc.callKw({
        'model': 'asset.inventory',
        'method': 'start_asset_inventory',
        'args': [assetInventoryId],
        'kwargs': {},
      });
      log("dkh Start Asset Inventory $res");
      return res;
    } catch (e) {
      log("Error $e", name: "AccountAssetRepository - createInventoryLine");
    }
  }
}
