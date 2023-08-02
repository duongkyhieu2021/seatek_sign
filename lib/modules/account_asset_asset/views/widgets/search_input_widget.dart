import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sea_hr/modules/account_asset_asset/controller/account_assset_asset_controller.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({Key? key}) : super(key: key);

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  String keySearch = "";

  Future<String> scanBarCode() async {
    final String barcode = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Hủy",
      true,
      ScanMode.QR,
    );
    return barcode == "-1" ? "Chưa quét được barcode" : barcode.toString();
  }

  @override
  Widget build(BuildContext context) {
    AccountAssetController accountAssetController =
        Get.find<AccountAssetController>();

    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 20, top: 20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: accountAssetController.searchCodeController,
              onChanged: (value) {
                accountAssetController.searchAssetByCode(value.toString());
                setState(() {
                  keySearch = value.toString();
                });
              },
              decoration: InputDecoration(
                hintText: "Tìm kiếm theo mã hoặc tên tài sản",
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                suffixIcon: keySearch != ""
                    ? IconButton(
                        onPressed: () {
                          accountAssetController.searchCodeController.clear();
                          setState(() {
                            keySearch = "";
                          });
                          accountAssetController.fetchRecordsAccountAsset();
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).primaryColor,
                        ))
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.transparent,
                        )),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[300]!.withOpacity(1),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[350]!.withOpacity(1),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[350]!.withOpacity(1),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
          IconButton(
            onPressed: () async {
              final String barcode = await scanBarCode();
              accountAssetController.searchAssetByCode(barcode);
            },
            icon: Icon(
              Icons.qr_code_scanner,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
