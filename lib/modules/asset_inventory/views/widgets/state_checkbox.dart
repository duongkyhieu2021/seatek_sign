import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';

class AssetInventoryStateDraft extends StatelessWidget {
  const AssetInventoryStateDraft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetInventoryController = Get.find<AssetInventoryController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Column(children: [
        StatefulBuilder(builder: (context, menuSetState) {
          return InkWell(
            onTap: () {
              assetInventoryController.currentInventory.draftState =
                  !assetInventoryController.currentInventory.draftState;
              log("dkh tap ${assetInventoryController.currentInventory.draftState}");
              menuSetState(() {});
            },
            child: Row(children: [
              assetInventoryController.currentInventory.draftState
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank),
              const Text(
                softWrap: true,
                "Draft:",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ]),
          );
        }),
        StatefulBuilder(builder: (context, menuSetState) {
          return InkWell(
            onTap: () {
              assetInventoryController.currentInventory.processState =
                  !assetInventoryController.currentInventory.processState;
              log("dkh tap ${assetInventoryController.currentInventory.processState}");
              menuSetState(() {});
            },
            child: Row(children: [
              assetInventoryController.currentInventory.processState
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank),
              const Text(
                softWrap: true,
                "Running:",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ]),
          );
        }),
        StatefulBuilder(builder: (context, menuSetState) {
          return InkWell(
            onTap: () {
              assetInventoryController.currentInventory.pendingState =
                  !assetInventoryController.currentInventory.pendingState;
              menuSetState(() {});
            },
            child: Row(children: [
              assetInventoryController.currentInventory.pendingState
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank),
              const Text(
                softWrap: true,
                "Pending:",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ]),
          );
        }),
        StatefulBuilder(builder: (context, menuSetState) {
          return InkWell(
            onTap: () {
              assetInventoryController.currentInventory.liquidationState =
                  !assetInventoryController.currentInventory.liquidationState;
              menuSetState(() {});
            },
            child: Row(children: [
              assetInventoryController.currentInventory.liquidationState
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank),
              const Text(
                softWrap: true,
                "Liquidation:",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ]),
          );
        }),
      ]),
    );
  }
}
