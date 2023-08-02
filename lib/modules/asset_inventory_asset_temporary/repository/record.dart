import 'package:equatable/equatable.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

// ignore: must_be_immutable
class AssetInventoryAssetTemporaryRecord extends Equatable
    implements OdooRecord {
  @override
  int id;

  String? name;
  String? code;
  String? description;
  List<dynamic>? assetInventoryId;
  List<dynamic>? assetImages;

  AssetInventoryAssetTemporaryRecord({
    required this.id,
    this.name,
    this.code,
    this.description,
    this.assetInventoryId,
    this.assetImages,
  });

  factory AssetInventoryAssetTemporaryRecord.initAssetInventoryAssetTemporary() {
    return AssetInventoryAssetTemporaryRecord(
        id: 0,
        name: "",
        code: "",
        description: "",
        assetInventoryId: const [],
        assetImages: const []);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        description,
        assetInventoryId,
        assetImages,
      ];

  static AssetInventoryAssetTemporaryRecord fromJson(
      Map<String, dynamic> json) {
    return AssetInventoryAssetTemporaryRecord(
      id: json['id'],
      name: json['name'] == false ? '' : json['name'],
      code: json['code'] == false ? '' : json['code'],
      description: json['description'] == false ? '' : json['description'],
      assetInventoryId:
          json['asset_inventory_id'] == false ? [] : json['asset_inventory_id'],
      assetImages: json['asset_images'] == false ? [] : json['asset_images'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'asset_inventory_id': assetInventoryId,
      'asset_images': assetImages,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'asset_inventory_id': assetInventoryId?[0],
      'asset_images': assetImages!.isEmpty ? null : assetImages?[0],
    };
  }

  static List<String> get oFields => [
        'id',
        'name',
        'code',
        'description',
        'asset_inventory_id',
        'asset_images',
      ];
}
