import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';

class AssetInventoryLineListsView extends StatefulWidget {
  const AssetInventoryLineListsView({Key? key}) : super(key: key);

  @override
  State<AssetInventoryLineListsView> createState() =>
      _AssetInventoryLineListsViewState();
}

class _AssetInventoryLineListsViewState
    extends State<AssetInventoryLineListsView> {
  static const double fontSize = 12;
  final homeController = Get.find<HomeController>();
  final assetInventoryLineController = Get.find<AssetInventoryLineController>();
  bool _sortAscending = true;
  int? _sortColumnIndex;
  final ScrollController _controller = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  void _sort<T>(
    int columnIndex,
    bool ascending,
  ) {
    // _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  // NOTE: Lưu QuantityThucTe khi submit
  void handleOnSubmitQuantityThucTe(value, index) {
    AssetInventoryLineController.to.currentInventoryLine =
        AssetInventoryLineController.to.listAssetInventoryLine[index];
    double? quantityThucTe =
        AssetInventoryLineController.to.currentInventoryLine.quantityThucTe;
    // NOTE: Nếu QuantityThucTe != value thì cập nhật
    if (quantityThucTe != double.parse(value)) {
      AssetInventoryLineController.to.currentInventoryLine.quantityThucTe =
          double.parse(value);
      AssetInventoryLineController.to.writeAssetInventoryLine();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventoryLine = assetInventoryLineController.listAssetInventoryLine;
    double quantityFixedwidth = 60;
    DataRow getRow(int index) {
      return DataRow2.byIndex(
        index: index,
        selected: false,
        onTap: () {
          assetInventoryLineController.currentInventoryLine =
              inventoryLine[index];
          Get.toNamed("/asset_inventory_line_info_edit");
        },
        cells: [
          DataCell(Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: const TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              inventoryLine[index].assetId![1].toString())),
          DataCell(Text(
              softWrap: true,
              style: const TextStyle(fontSize: fontSize),
              inventoryLine[index].quantitySoSach!.toString())),
          DataCell(
              // showEditIcon: true,
              TextField(
            style: const TextStyle(fontSize: fontSize),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
            ],
            controller: TextEditingController(
              text: inventoryLine[index].quantityThucTe.toString(),
            ),
            onSubmitted: (value) {
              handleOnSubmitQuantityThucTe(value, index);
            },
            decoration: const InputDecoration(
              isDense: true,
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          )),
          DataCell(Text(
              softWrap: true,
              style: const TextStyle(fontSize: fontSize),
              inventoryLine[index].quantityChenhLech.toString())),
        ],
      );
    }

    return Expanded(
      child: Stack(children: [
        DataTable2(
          fixedCornerColor: Colors.blue,
          dataRowHeight: 60,
          scrollController: _controller,
          horizontalScrollController: _horizontalController,
          columnSpacing: 20,
          horizontalMargin: 5,
          bottomMargin: 2,
          minWidth: 300,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          showBottomBorder: true,
          columns: [
            DataColumn2(
              label: const Text('Tên TS', style: TextStyle(fontSize: fontSize)),
              size: ColumnSize.M,
              onSort: (columnIndex, ascending) =>
                  _sort<String>(columnIndex, ascending),
            ),
            DataColumn2(
              fixedWidth: quantityFixedwidth,
              label: const Text('SLSS', style: TextStyle(fontSize: fontSize)),
              size: ColumnSize.S,
              onSort: (columnIndex, ascending) =>
                  _sort<String>(columnIndex, ascending),
            ),
            DataColumn2(
              fixedWidth: quantityFixedwidth,
              label: const Text('SLTT', style: TextStyle(fontSize: fontSize)),
              size: ColumnSize.S,
              onSort: (columnIndex, ascending) =>
                  _sort<String>(columnIndex, ascending),
            ),
            DataColumn2(
              fixedWidth: quantityFixedwidth,
              label: const Text('SLCL', style: TextStyle(fontSize: fontSize)),
              size: ColumnSize.S,
              onSort: (columnIndex, ascending) =>
                  _sort<String>(columnIndex, ascending),
            ),
          ],
          rows: List<DataRow>.generate(
              inventoryLine.length, (index) => getRow(index)),
        ),
      ]),
    );
  }
}
