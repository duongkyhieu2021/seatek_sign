import 'package:equatable/equatable.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';

// ignore: must_be_immutable
class AssetCommitteePositionRecord extends Equatable implements OdooRecord {
  @override
   int id;
  String? name;

  AssetCommitteePositionRecord(
      {required this.id,
      this.name,
});
  

  @override
  List<Object?> get props =>
      [id, name];

  static AssetCommitteePositionRecord fromJson(Map<String, dynamic> json) {
    return AssetCommitteePositionRecord(
      id: json['id'],
      name:json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toVals() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<String> get oFields => [
        'id',
        'name',
      ];
}
