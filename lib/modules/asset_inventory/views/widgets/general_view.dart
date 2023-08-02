import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/asset_inventoried_department/views/asset_inventory_employee_view.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/utils/show_dialog.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/company_input.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/department_dropdown.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/end_time.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/location_dropdown.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/name_input.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/start_time.dart';
import 'package:sea_hr/modules/asset_inventory/views/widgets/state_checkbox.dart';
import 'dart:math' as math;

import 'package:sea_hr/modules/asset_inventory_committee/views/asset_inventory_committee_view.dart';

class AssetInventoryGeneralView extends StatelessWidget {
  const AssetInventoryGeneralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF858C94), width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ExpansionWidget(
                            initiallyExpanded: false,
                            titleBuilder: (double animationValue, _,
                                bool isExpanded, toggleFunction) {
                              return InkWell(
                                  onTap: () => toggleFunction(animated: true),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Expanded(
                                            child: Text(
                                          'Thông tin chung',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF09101D)),
                                        )),
                                        Transform.rotate(
                                          angle: math.pi * animationValue / 2,
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.arrow_right,
                                              size: 24),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                            content: Container(
                              width: double.infinity,
                              color: Colors.white,
                              padding: const EdgeInsets.all(8.0),
                              child: const Column(children: [
                                AssetInventoryNameInput(),
                                AssetInventoryCompanyInput(),
                                AssetInventoryDepartmentDropdown(),
                                AssetInventoryLocationDropdown(),
                                AssetInventoryStartTime(),
                                AssetInventoryEndTime(),
                                AssetInventoryStateDraft(),
                              ]),
                            )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AssetInventoryCommitteeView(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AssetInventoryEmployeeView(),
                    )
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (AssetInventoryController.to.isCreate == true.obs) {
                AssetInventoryController.to
                    .createAssetInventory()
                    .then((value) {
                  if (AssetInventoryController.to.isCompleted == true.obs) {
                    ShowDialog().showSuccessDialog(
                      context,
                      "Thông báo",
                      "Tạo tài sản kiểm kê thành công!",
                      () {
                        AssetInventoryController.to.tabController?.index = 0;
                        Navigator.pushNamed(context, "/asset_inventory");
                      },
                    );
                  }
                });
              } else {
                await AssetInventoryController.to
                    .writeAssetInventory()
                    .then((value) {
                  if (AssetInventoryController.to.isCompleted == true.obs) {
                    ShowDialog().showSuccessDialog(
                      context,
                      "Thông báo",
                      "Cập nhật tài sản kiểm kê thành công!",
                      () {
                        AssetInventoryController.to.tabController?.index = 0;
                        Navigator.pushNamed(context, "/asset_inventory");
                      },
                    );
                  }
                });
              }
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(AssetInventoryController.to.isCreate == false.obs
                ? "Lưu"
                : "Tạo"),
          ),
        ));
  }
}
