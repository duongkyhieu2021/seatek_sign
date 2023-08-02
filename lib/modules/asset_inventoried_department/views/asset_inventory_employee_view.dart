import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventoried_department/controller/asset_inventory_employee_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/repository/record.dart';
import 'package:sea_hr/widgets/icon_name_widget.dart';
import 'package:sea_hr/widgets/item_title.dart';
import 'dart:math' as math;
import 'package:sea_hr/widgets/list_empty.dart';

class AssetInventoryEmployeeView extends StatelessWidget {
  const AssetInventoryEmployeeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inventoryEmployeeController =
        Get.find<AssetInventoryEmployeeController>();
    inventoryEmployeeController.fetchRecordsEmployee();
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
                      'Nhân viên',
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
                      inventoryEmployeeController
                          .clearAssetInventoryEmployeeRecord();
                      inventoryEmployeeController.listEmployeesTemp.value = [];
                      inventoryEmployeeController.listJobId.clear();
                      Get.toNamed("/asset_inventory_employee_info_create");
                    },
                  ),
                  Transform.rotate(
                    angle: math.pi * animationValue / 2,
                    alignment: Alignment.center,
                    child: const Icon(Icons.arrow_right, size: 24),
                  )
                ],
              ),
            ),
          );
        },
        content: Container(
          width: double.infinity,
          color: Colors.white,
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
          child: Obx(() =>
              AssetInventoryEmployeeController.to.status.value == 1
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AssetInventoryEmployeeController.to
                          .listAssetInventoryEmployee.isEmpty
                      ? const ListEmpty(
                          title: "Danh sách nhân viên trống",
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: AssetInventoryEmployeeController.to
                              .listAssetInventoryEmployee
                              .length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                _ItemInventoryEmployee(
                                  inventoryEmployee: AssetInventoryEmployeeController.to
                                      .listAssetInventoryEmployee[index],
                                ),
                              ],
                            );
                          })),
        ),
      ),
    );
  }
}

class _ItemInventoryEmployee extends StatelessWidget {
  final AssetInventoryEmployeeRecord inventoryEmployee;
  const _ItemInventoryEmployee({
    required this.inventoryEmployee,
  });
  @override
  Widget build(BuildContext context) {
    String employeeTitle = "---";
    String job = "---";
    if (inventoryEmployee.employeeId!.isNotEmpty) {
      employeeTitle = inventoryEmployee.employeeId![1].toString();
    }
    if (inventoryEmployee.jobId!.isNotEmpty) {
      job = inventoryEmployee.jobId![1].toString();
    }
    return InkResponse(
      onTap: () {
        final assetInventoryCommitteeController =
            Get.find<AssetInventoryEmployeeController>();
        assetInventoryCommitteeController.assetInventoryEmployeeRecord =
            inventoryEmployee;
        Get.toNamed("/asset_inventory_employee_info_edit");
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
                title: ItemTitle(title: employeeTitle.toUpperCase()),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconNameWidget(
                              iconData: Icons.work_outline, name: job)
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
