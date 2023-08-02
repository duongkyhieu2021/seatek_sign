import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/widgets/search_choices_widget.dart';

class AssetInventoryLocationDropdown extends StatefulWidget {
  const AssetInventoryLocationDropdown({Key? key}) : super(key: key);

  @override
  _AssetInventoryLocationDropdownState createState() =>
      _AssetInventoryLocationDropdownState();
}

class _AssetInventoryLocationDropdownState
    extends State<AssetInventoryLocationDropdown> {
  String _selectedValueLocation = "";
  List<String> selectedItems = [];
  bool isStart = false;
  final assetInventoryController = Get.find<AssetInventoryController>();
  @override
  Widget build(BuildContext context) {
    if (assetInventoryController.currentInventory.seaOfficeId!.isNotEmpty &&
        isStart == false) {
      List<dynamic>? seaOffices = [];
      try {
        for (int i = 0;
            i < assetInventoryController.currentInventory.seaOfficeId!.length;
            i++) {
          seaOffices = assetInventoryController.listSeaOffice
              .where((element) =>
                  element.id.toString() ==
                  assetInventoryController.currentInventory.seaOfficeId![i]
                      .toString())
              .map((element) => [element.id, element.name])
              .toList();
          if (seaOffices.isNotEmpty) {
            _selectedValueLocation = seaOffices[0][1].toString();
            selectedItems.add(seaOffices[0][0].toString());
          }
        }
      } catch (e) {
        log("Error $e");
      }
    }
    isStart = true;
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
      child: SearchChoicesWidget(
        items: assetInventoryController.listSeaOffice.map((item) {
          return DropdownMenuItem<String>(
            value: item.id.toString(),
            //disable default onTap to avoid closing menu when selecting an item
            enabled: true,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = selectedItems.contains(item.id.toString());

                return InkWell(
                  onTap: () {
                    isSelected
                        ? selectedItems.remove(item.id.toString())
                        : selectedItems.add(item.id.toString());
                    List<dynamic>? seaOffices = [];
                    for (int i = 0; i < selectedItems.length; i++) {
                      try {
                        List<dynamic> seaOffice = assetInventoryController
                            .listSeaOffice
                            .where((element) =>
                                element.id.toString() ==
                                selectedItems[i].toString())
                            .map((element) => [element.id, element.name])
                            .first;
                        seaOffices.add(seaOffice[0]);
                      } catch (e) {
                        log("Error $e");
                      }
                    }

                    assetInventoryController.currentInventory.seaOfficeId =
                        seaOffices;
                    //This rebuilds the StatefulWidget to update the button's text
                    setState(() {});
                    //This rebuilds the dropdownMenu Widget to update the check mark
                    menuSetState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        isSelected
                            ? const Icon(Icons.check_box_outlined)
                            : const Icon(Icons.check_box_outline_blank),
                        const SizedBox(width: 16),
                        Text(
                          softWrap: true,
                          item.name.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
        selectedValue: selectedItems.isEmpty ? null : selectedItems.last,
        title: assetInventoryController.currentInventory.seaOfficeId!.isEmpty
            ? "Chọn địa điểm"
            : _selectedValueLocation,
        onChanged: (value) {
          setState(() {
            _selectedValueLocation = value;
          });
        },
      ),
    );
  }
}
