import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';

class AssetInventoryLineSearch extends StatefulWidget {
  const AssetInventoryLineSearch({Key? key}) : super(key: key);

  @override
  State<AssetInventoryLineSearch> createState() =>
      _AssetInventoryLineSearchState();
}

class _AssetInventoryLineSearchState extends State<AssetInventoryLineSearch> {
  String keySearch = "";
  @override
  Widget build(BuildContext context) {
    AssetInventoryLineController assetInventoryLineController =
        Get.find<AssetInventoryLineController>();

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: assetInventoryLineController.searchController,
        onChanged: (value) {
          assetInventoryLineController
              .searchAssetInventoryLine(value.toString());
          setState(() {
            keySearch = value.toString();
          });
        },
        decoration: InputDecoration(
          hintText: "Tìm kiếm theo mã hoặc tên tài sản kiểm kê",
          filled: true,
          fillColor: Colors.grey[300],
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: keySearch != ""
              ? IconButton(
                  onPressed: () {
                    assetInventoryLineController.searchController.clear();
                    setState(() {
                      keySearch = "";
                    });
                    assetInventoryLineController.fetchRecordsInventoryLine();
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
    );
  }
}
