import 'dart:developer';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/modules/account_asset_image/repository/record.dart';

class AccountAssetImageRepository
    extends OdooRepository<AccountAssetImageRecord> {
  @override
  final String modelName = 'account.asset.image';

  AccountAssetImageRepository(OdooEnvironment env) : super(env);

  @override
  AccountAssetImageRecord createRecordFromJson(Map<String, dynamic> json) {
    return AccountAssetImageRecord.fromJson(json);
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
          'fields': AccountAssetImageRecord.oFields,
        },
      });
      
      return res;
    } catch (e) {
      log("$e", name: "AccountAssetImageRepository - searchRead");
      return [];
    }
  }
}
