import 'package:expansion_widget/expansion_widget.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventory_committee/controller/asset_inventory_committee_controller.dart';
import 'package:sea_hr/modules/asset_inventory_committee/repository/record.dart';
import 'package:sea_hr/widgets/icon_name_widget.dart';
import 'package:sea_hr/widgets/item_title.dart';
import '../../../../../../widgets/list_empty.dart';

class AssetInventoryCommitteeView extends StatelessWidget {
  const AssetInventoryCommitteeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetInventoryCommitteeController.to.assetInventoryId =
        AssetInventoryController.to.currentInventory.id.obs;
    AssetInventoryCommitteeController.to.fetchRecordsCommittee();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF858C94), width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionWidget(
          initiallyExpanded: false,
          titleBuilder:
              (double animationValue, _, bool isExpanded, toggleFunction) {
            return InkWell(
                onTap: () => toggleFunction(animated: true),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          'Ban kiểm kê',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF09101D)),
                        ),
                      ),
                      IconButton(
                        iconSize: 28,
                        icon: const Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          AssetInventoryCommitteeController.to
                              .clearAssetInventoryCommitteeRecord();
                          Get.toNamed("/asset_inventory_committee_info_create");
                        },
                      ),
                      Transform.rotate(
                        angle: math.pi * animationValue / 2,
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_right, size: 24),
                      )
                    ],
                  ),
                ));
          },
          content: Container(
            width: double.infinity,
            color: Colors.white,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 3),
            padding:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
            child: Obx(() =>
                AssetInventoryCommitteeController.to.status.value == 1
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : AssetInventoryCommitteeController
                            .to.listAssetInventoryCommittee.isEmpty
                        ? const ListEmpty(
                            title: "Ban kiểm kê trống",
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: AssetInventoryCommitteeController
                                .to.listAssetInventoryCommittee.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  _ItemInventoryCommittee(
                                    inventoryCommittee:
                                        AssetInventoryCommitteeController.to
                                            .listAssetInventoryCommittee[index],
                                  ),
                                ],
                              );
                            })),
          )),
    );
  }
}

class _ItemInventoryCommittee extends StatelessWidget {
  final AssetInventoryCommitteeRecord inventoryCommittee;
  const _ItemInventoryCommittee({
    required this.inventoryCommittee,
  });
  @override
  Widget build(BuildContext context) {
    String committeeTitle = "---";
    String position = "---";
    if (inventoryCommittee.employeeId!.isNotEmpty) {
      committeeTitle = inventoryCommittee.employeeId![1].toString();
    }
    if (inventoryCommittee.position!.isNotEmpty) {
      position = inventoryCommittee.position![1].toString();
    }
    return InkResponse(
      onTap: () {
        final assetInventoryCommitteeController =
            Get.find<AssetInventoryCommitteeController>();
        assetInventoryCommitteeController.assetInventoryCommitteeRecord =
            inventoryCommittee;
        Get.toNamed("/asset_inventory_committee_info_edit");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: ItemTitle(title: committeeTitle.toUpperCase()),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconNameWidget(
                              iconData: Icons.work_outline, name: position)
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
