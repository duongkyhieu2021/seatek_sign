import 'package:equatable/equatable.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

// ignore: must_be_immutable
class AccountAssetImageRecord extends Equatable implements OdooRecord {
  @override
   int id;

  List<dynamic>? accountAssetId;
  List<dynamic>? assetTemporaryId;
  String? assetImage;
  String? assetFilename;

  AccountAssetImageRecord({
    required this.id,
    this.accountAssetId,
    this.assetTemporaryId,
    this.assetImage,
    this.assetFilename,
  });

  factory AccountAssetImageRecord.initAccountAssetImage() {
    return AccountAssetImageRecord(
      id: 0,
      accountAssetId: const [],
      assetTemporaryId: const [],
      assetImage: "",
      assetFilename: "",
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountAssetId,
        assetTemporaryId,
        assetImage,
        assetFilename,
      ];

  static AccountAssetImageRecord fromJson(Map<String, dynamic> json) {
    return AccountAssetImageRecord(
      id: json['id'],
      accountAssetId:
          json['account_asset_id'] == false ? [] : json['account_asset_id'],
      assetTemporaryId:
          json['asset_temporary_id'] == false ? [] : json['asset_temporary_id'],
      assetImage: json['asset_image'] == false ? "" : json['asset_image'],
      assetFilename:
          json['asset_filename'] == false ? "" : json['asset_filename'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_asset_id': accountAssetId,
      'asset_temporary_id': assetTemporaryId,
      'asset_image': assetImage,
      'asset_filename': assetFilename,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    return {
      'id': id,
      'account_asset_id': accountAssetId!.isEmpty ? null : accountAssetId?[0],
      'asset_temporary_id':
          assetTemporaryId!.isEmpty ? null : assetTemporaryId?[0],
      'asset_image': assetImage,
      'asset_filename': assetFilename,
    };
  }

  static List<String> get oFields => [
        'id',
        'account_asset_id',
        'asset_temporary_id',
        'asset_image',
        'asset_filename',
      ];
}
