import 'dart:developer';

import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/repository/record.dart';

class AssetInventoryAssetTemporaryRepository
    extends OdooRepository<AssetInventoryAssetTemporaryRecord> {
  @override
  final String modelName = 'asset.inventory.asset.temporary';

  AssetInventoryAssetTemporaryRepository(OdooEnvironment env) : super(env);

  @override
  AssetInventoryAssetTemporaryRecord createRecordFromJson(
      Map<String, dynamic> json) {
    return AssetInventoryAssetTemporaryRecord.fromJson(json);
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
          'fields': AssetInventoryAssetTemporaryRecord.oFields,
        },
      });

      return res;
    } catch (e) {
      log("$e", name: "AssetInventoryAssetTemporaryRepository - searchRead");
      return [];
    }
  }
}
