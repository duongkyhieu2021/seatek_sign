import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/modules/asset_inventory/controller/asset_inventory_controller.dart';
import 'package:sea_hr/modules/asset_inventoried_department/controller/asset_inventory_employee_controller.dart';
import 'package:sea_hr/modules/asset_inventory_line/controller/asset_inventory_line_controller.dart';
import 'package:sea_hr/modules/asset_inventory/repository/record.dart';
import 'package:sea_hr/modules/asset_inventory/views/asset_inventory_item_skeleton.dart';
import 'package:sea_hr/widgets/icon_name_widget.dart';
import 'package:sea_hr/widgets/item_title.dart';

class AssetInventoryLists extends StatefulWidget {
  const AssetInventoryLists({Key? key}) : super(key: key);

  @override
  State<AssetInventoryLists> createState() => _AssetInventoryListsState();
}

class _AssetInventoryListsState extends State<AssetInventoryLists> {
  final homeController = Get.find<HomeController>();
  final assetInventoryController = Get.find<AssetInventoryController>();
  final int loadMoreBatchSize = 40;
  late ScrollController _scrollController;
  late bool isLoading;
  int index = 0;
  _AssetInventoryListsState() {
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
          assetInventoryController.limit.value += loadMoreBatchSize;
        });

        // Delay 1 giây trước khi lấy data
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            assetInventoryController.fetchRecordsInventory();

            isLoading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventory = assetInventoryController.listAssetInventory;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: assetInventoryController.limit.value > inventory.length
              ? inventory.length + 2
              : assetInventoryController.limit.value,
          itemBuilder: (context, index) {
            if (index < inventory.length) {
              return _ItemInventory(inventory: inventory[index]);
            } else {
              // Hiển thị skeleton ở cuối danh sách
              if (isLoading == true) {
                // Kiểm tra nếu còn asset thì hiển thị skeleton
                return const AssetInventoryItemSkeleton();
              }
            }
            return const SizedBox(
              height: 100.0,
            );
          }),
    );
  }
}

class _ItemInventory extends StatelessWidget {
  final AssetInventoryRecord inventory;
  const _ItemInventory({
    required this.inventory,
  });
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        final assetInventoryController = Get.find<AssetInventoryController>();
        assetInventoryController.fetchRecordsInventoryCommittee(inventory.id);

        final assetInventoryLineController =
            Get.find<AssetInventoryLineController>();

        final inventoryEmployeeController =
            Get.find<AssetInventoryEmployeeController>();
        
        inventoryEmployeeController.assetInventoryId.value = inventory.id;
        assetInventoryLineController.assetInventory = inventory;

        assetInventoryController.currentInventory = inventory;

        Get.toNamed("/asset_inventory_info_edit");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Card(
          elevation: 2.0,
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
                title: ItemTitle(title: inventory.name!.toUpperCase()),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: [
        
                      Row(
                        children: [
                          IconNameWidget(
                            iconData: Icons.home_work_outlined,
                            name: inventory.state.toString(),
                          )
                        ],
                      )
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
