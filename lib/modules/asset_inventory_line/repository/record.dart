import 'package:equatable/equatable.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

class AssetInventoryLineRecord extends Equatable implements OdooRecord {
  @override
   int id;

  List<dynamic>? assetId;
  String? assetCode;
  List<dynamic>? assetUom;
  double? quantitySoSach;
  double? quantityThucTe;
  double? quantityChenhLech;
  String? status;
  String? latestInventoryStatus;
  bool? daDanTem;
  List<dynamic>? assetUserTemporary;
  List<dynamic>? assetUser;
  List<dynamic>? assetInventoryId;
  String? note;
  String? deXuatXuLy;
  String? giaiTrinh;
  bool? active;

  AssetInventoryLineRecord({
    required this.id,
    this.assetId,
    this.assetUom,
    this.assetUser,
    this.assetUserTemporary,
    this.assetInventoryId,
    this.quantityThucTe,
    this.quantitySoSach,
    this.quantityChenhLech,
    this.status,
    this.latestInventoryStatus,
    this.deXuatXuLy,
    this.giaiTrinh,
    this.assetCode,
    this.note,
    this.active,
    this.daDanTem,
  });

  factory AssetInventoryLineRecord.initAssetInventoryLine() {
    return AssetInventoryLineRecord(
      id: 0,
      assetId: const [],
      assetUom: const [],
      assetUser: const [],
      assetUserTemporary: const [],
      assetInventoryId: const [],
      quantityThucTe: 0.0,
      quantitySoSach: 0.0,
      quantityChenhLech: 0.0,
      status: "dang_su_dung",
      latestInventoryStatus: "good",
      deXuatXuLy: null,
      giaiTrinh: null,
      assetCode: null,
      note: null,
      active: true,
      daDanTem: true,
    );
  }

  @override
  List<Object?> get props => [
        id,
        assetId,
        assetUom,
        assetUser,
        assetUserTemporary,
        assetInventoryId,
        quantityThucTe,
        quantitySoSach,
        quantityChenhLech,
        status,
        latestInventoryStatus,
        deXuatXuLy,
        giaiTrinh,
        assetCode,
        note,
        active,
        daDanTem,
      ];

  static AssetInventoryLineRecord fromJson(Map<String, dynamic> json) {
    return AssetInventoryLineRecord(
      id: json['id'],
      assetId: json['asset_id'] == false ? [] : json['asset_id'],
      assetUom: json['asset_uom'] == false ? [] : json['asset_uom'],
      assetUser: json['asset_user'] == false ? [] : json['asset_user'],
      assetUserTemporary: json['asset_user_temporary'] == false
          ? []
          : json['asset_user_temporary'],
      assetInventoryId:
          json['asset_inventory_id'] == false ? [] : json['asset_inventory_id'],
      quantityThucTe:
          json['quantity_thuc_te'] == false ? 0.0 : json['quantity_thuc_te'],
      quantitySoSach:
          json['quantity_so_sach'] == false ? 0.0 : json['quantity_so_sach'],
      quantityChenhLech: json['quantity_chenh_lech'] == false
          ? 0.0
          : json['quantity_chenh_lech'],
      status: json['status'] == false ? '' : json['status'],
      latestInventoryStatus: json['latest_inventory_status'] == false
          ? ''
          : json['latest_inventory_status'],
      deXuatXuLy: json['de_xuat_xu_ly'] == false ? '' : json['de_xuat_xu_ly'],
      giaiTrinh: json['giai_trinh'] == false ? '' : json['giai_trinh'],
      assetCode: json['asset_code'] == false ? '' : json['asset_code'],
      note: json['note'] == false ? '' : json['note'],
      active: json['active'] == false ? false : json['active'],
      daDanTem: json['da_dan_tem'] == false ? false : json['da_dan_tem'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'asset_id': assetId,
      'asset_uom': assetUom,
      'asset_user': assetUser,
      'asset_user_temporary': assetUserTemporary,
      'asset_inventory_id': assetInventoryId,
      'quantity_thuc_te': quantityThucTe,
      'quantity_so_sach': quantitySoSach,
      'quantity_chenh_lech': quantityChenhLech,
      'status': status,
      'latest_inventory_status': latestInventoryStatus,
      'de_xuat_xu_ly': deXuatXuLy,
      'giai_trinh': giaiTrinh,
      'asset_code': assetCode,
      'note': note,
      'active': active,
      'da_dan_tem': daDanTem,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    print("assetInventoryId toval $assetInventoryId");
    return {
      'id': id,
      'asset_id': assetId!.isEmpty ? false : assetId?[0],
      'asset_uom': assetUom!.isEmpty ? false : assetUom?[0],
      'asset_user': assetUser!.isEmpty ? false : assetUser?[0],
      'asset_user_temporary':
          assetUserTemporary!.isEmpty ? false : assetUserTemporary?[0],
      'asset_inventory_id':
          assetInventoryId!.isEmpty ? false : assetInventoryId?[0],
      'quantity_thuc_te': quantityThucTe,
      'quantity_so_sach': quantitySoSach,
      'quantity_chenh_lech': quantityChenhLech,
      'status': status,
      'latest_inventory_status': latestInventoryStatus,
      'de_xuat_xu_ly': deXuatXuLy,
      'giai_trinh': giaiTrinh,
      'asset_code': assetCode,
      'note': note,
      'active': active,
      'da_dan_tem': daDanTem,
    };
  }

  static List<String> get oFields => [
        'id',
        'asset_id',
        'asset_uom',
        'asset_user',
        'asset_user_temporary',
        'asset_inventory_id',
        'quantity_thuc_te',
        'quantity_so_sach',
        'quantity_chenh_lech',
        'status',
        'latest_inventory_status',
        'de_xuat_xu_ly',
        'giai_trinh',
        'asset_code',
        'note',
        'active',
        'da_dan_tem',
      ];
}
