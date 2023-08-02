// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_code.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_da_dan_tem.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_de_xuat_xu_ly_input.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_dropdown.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_giai_trinh_input.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_latest_inventory_status_dropdown.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_note_input.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_quantity_chenh_lech_input.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_quantity_so_sach_input.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_quantity_thuc_te_input.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_status_dropdown.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_uom.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/widgets/line_user_temporary_dropdown.dart';


class AssetInventoryLineGeneralView extends StatelessWidget {
  const AssetInventoryLineGeneralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          padding: const EdgeInsets.all(8.0),
          child: const Column(children: [
            AssetLineDropdown(),
            AssetLineCode(),
            AssetLineUom(),
            AssetLineQuantitySoSachInput(),
            AssetQuantityThucTeInput(),
            AssetLineQuantityChenhLechInput(),
            AssetLineStatusDropdown(),
            AssetLineLatestInventoryStatusDropdown(),
            AssetLineDaDanTem(),
            AssetLineUserTemporaryDropdown(),
            AssetLineNoteInput(),
            AssetLineDeXuatXuLyInput(),
            AssetLineGiaiTrinhInput(),
          ]),
        )
      ],
    );
  }
}
