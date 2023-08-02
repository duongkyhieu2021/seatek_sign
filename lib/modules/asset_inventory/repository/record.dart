import 'package:equatable/equatable.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

// ignore: must_be_immutable
class AssetInventoryRecord extends Equatable implements OdooRecord {
  @override
  late final int id;

  String? name;
  DateTime? startTime;
  DateTime? endTime;
  List<dynamic>? companyId;
  List<dynamic>? department;
  List<dynamic>? seaOfficeId;
  String? state = "draft";
  bool draftState = false;
  bool processState = true;
  bool pendingState = false;
  bool liquidationState = false;

  AssetInventoryRecord({
    required this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.companyId,
    this.department,
    this.seaOfficeId,
    this.state = "draft",
    this.draftState = false,
    this.processState = true,
    this.pendingState = true,
    this.liquidationState = true,
  });

  factory AssetInventoryRecord.initAssetInventory() {
    return AssetInventoryRecord(
        id: 0,
        name: "",
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        companyId: const [],
        department: const [],
        state: "draft",
        draftState: false,
        processState: true,
        pendingState: true,
        liquidationState: true,
        seaOfficeId: const []);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        startTime,
        endTime,
        companyId,
        department,
        seaOfficeId,
        state,
        draftState,
        processState,
        pendingState,
        liquidationState,
      ];

  static AssetInventoryRecord fromJson(Map<String, dynamic> json) {
    return AssetInventoryRecord(
      id: json['id'],
      name: json['name'] == false ? '' : json['name'],
      state: json['state'] == false ? 'draft' : json['state'],
      startTime: json['start_time'] == false
          ? DateTime.now()
          : DateTime.parse(json['start_time']),
      endTime: json['end_time'] == false
          ? DateTime.now()
          : DateTime.parse(json['end_time']),
      companyId: json['company_id'] == false ? [] : json['company_id'],
      department: json['department'] == false ? [] : json['department'],
      seaOfficeId: json['sea_office_id'] == false ? [] : json['sea_office_id'],
      draftState: json['draft_state'] ?? false,
      processState: json['process_state'] ?? false,
      pendingState: json['pending_state'] ?? false,
      liquidationState: json['liquidation_state'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_time': startTime.toString(),
      'end_time': endTime.toString(),
      'company_id': companyId,
      'department': department,
      'sea_office_id': seaOfficeId,
      'state': state,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    return {
      'id': id,
      'name': name,
      'start_time': startTime.toString(),
      'end_time': endTime.toString(),
      'company_id': companyId!.isEmpty ? false : companyId?[0],
      'department': department!.isEmpty
          ? [
              [6, 'False', []]
            ]
          : [
              [6, 'False', department]
            ],
      'sea_office_id': seaOfficeId!.isEmpty
          ? [
              [6, 'False', []]
            ]
          : [
              [6, 'False', seaOfficeId]
            ],
      'state': state,
      'draft_state': draftState,
      'process_state': processState,
      'pending_state': pendingState,
      'liquidation_state': liquidationState,
    };
  }

  static List<String> get oFields => [
        'id',
        'name',
        'start_time',
        'end_time',
        'company_id',
        'department',
        'sea_office_id',
        'state',
        'draft_state',
        'process_state',
        'pending_state',
        'liquidation_state',
      ];
}
