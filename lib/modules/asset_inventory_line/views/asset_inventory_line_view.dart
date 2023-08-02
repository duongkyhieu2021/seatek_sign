import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/artifact_view.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/asset_inventory_line_body.dart';

class AssetInventoryLineView extends StatelessWidget {
  const AssetInventoryLineView({Key? key}) : super(key: key);

  Future<void> scanBarCode() async {
    final String barcode = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Hủy",
      true,
      ScanMode.QR,
    );

    if (barcode != "-1") {
      final value = await AssetInventoryLineController.to
          .scannerAssetInventoryLine(barcode);

      if (value != null) {
        value.quantityThucTe = (value.quantityThucTe! + 1.0);
        value.assetInventoryId = [
          AssetInventoryLineController.to.assetInventory.id
        ];

        AssetInventoryLineController.to.currentInventoryLine = value;
        await AssetInventoryLineController.to.writeAssetInventoryLine();
        AssetInventoryLineController.to.fetchRecordsInventoryLine();
        Fluttertoast.showToast(
          msg: "Kiểm kê thành công!",
          backgroundColor: Colors.green,
          gravity: ToastGravity.TOP,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Mã $barcode không tìm thấy",
          backgroundColor: Colors.red,
          gravity: ToastGravity.TOP,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Obx(() {
      if (AssetInventoryController.to.status.value == 1) {
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.blue,
                size: 60,
              ),
            ));
      } else {
        return Scaffold(
          key: scaffoldKey,
          body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints.expand(height: 50),
                    child: TabBar(
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                        labelColor: Colors.black,
                        onTap: AssetInventoryLineController
                            .to.handleOnTapTabBarAssetInventoryLine,
                        tabs: const [
                          Tab(text: "Danh sách kiểm kê"),
                          Tab(text: "Hiện vật"),
                        ]),
                  ),
                  const Expanded(
                    child: TabBarView(children: [
                      AssetInventoryLineBody(),
                      ArtifactView(),
                    ]),
                  )
                ],
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: scanBarCode,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 32.0,
            ),
          ),
        );
      }
    });
  }
}
