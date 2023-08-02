import 'dart:developer';

import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/asset_committee_position/repository/record.dart';

class AssetCommitteePositionRepository
    extends OdooRepository<AssetCommitteePositionRecord> {
  @override
  final String modelName = 'asset.committee.position';
  AssetCommitteePositionRepository(OdooEnvironment env) : super(env);

  @override
  AssetCommitteePositionRecord createRecordFromJson(
      Map<String, dynamic> json) {
    return AssetCommitteePositionRecord.fromJson(json);
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
          'fields': AssetCommitteePositionRecord.oFields,
        },
      });
      return res;
    } catch (e) {
      log("$e", name: "AssetCommitteePositionReposition - searchRead");
      return [];
    }
  }
}
