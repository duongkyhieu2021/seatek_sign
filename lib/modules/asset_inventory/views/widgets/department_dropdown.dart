import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/widgets/search_choices_widget.dart';

class AssetInventoryDepartmentDropdown extends StatefulWidget {
  const AssetInventoryDepartmentDropdown({Key? key}) : super(key: key);

  @override
  _AssetInventoryDepartmentDropdownState createState() =>
      _AssetInventoryDepartmentDropdownState();
}

class _AssetInventoryDepartmentDropdownState
    extends State<AssetInventoryDepartmentDropdown> {
  final assetInventoryController = Get.find<AssetInventoryController>();
  String _selectedValueDepartment = "";
  List<String> selectedItems = [];
  bool isStart = false;
  @override
  Widget build(BuildContext context) {
    if (assetInventoryController.currentInventory.department!.isNotEmpty &&
        isStart == false) {
      List<dynamic>? departments = [];
      try {
        for (int i = 0;
            i < assetInventoryController.currentInventory.department!.length;
            i++) {
          departments = assetInventoryController.listDepartment
              .where((element) =>
                  element.id.toString() ==
                  assetInventoryController.currentInventory.department![i]
                      .toString())
              .map((element) => [element.id, element.name])
              .toList();
          log("dkh start departments $i $departments");
          if (departments.isNotEmpty) {
            _selectedValueDepartment = departments[0][1].toString();
            selectedItems.add(departments[0][0].toString());
            log("dkh start selectedItems $i $selectedItems");
          }
        }

        //selectedItems = departments;
        log("dkh _selectedValueDepartment $_selectedValueDepartment");
      } catch (e) {
        log("Error $e");
      }
    }
    isStart = true;
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
      child: SearchChoicesWidget(
        items: assetInventoryController.listDepartment.map((item) {
          return DropdownMenuItem<String>(
            value: item.id.toString(),
            //disable default onTap to avoid closing menu when selecting an item
            enabled: true,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final _isSelected = selectedItems.contains(item.id.toString());

                return InkWell(
                  onTap: () {
                    _isSelected
                        ? selectedItems.remove(item.id.toString())
                        : selectedItems.add(item.id.toString());
                    List<dynamic>? departments = [];
                    for (int i = 0; i < selectedItems.length; i++) {
                      try {
                        List<dynamic> department = assetInventoryController
                            .listDepartment
                            .where((element) =>
                                element.id.toString() ==
                                selectedItems[i].toString())
                            .map((element) => [element.id, element.name])
                            .first;
                        departments.add(department[0]);
                      } catch (e) {
                        log("Error $e");
                      }
                    }

                    assetInventoryController.currentInventory.department =
                        departments;
                    //This rebuilds the StatefulWidget to update the button's text
                    setState(() {});
                    //This rebuilds the dropdownMenu Widget to update the check mark
                    menuSetState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        _isSelected
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
        title: assetInventoryController.currentInventory.department!.isEmpty
            ? "Chọn phòng ban"
            : _selectedValueDepartment,
        onChanged: (value) {
          setState(() {
            _selectedValueDepartment = value;
          });
        },
      ),
    );
  }
}
