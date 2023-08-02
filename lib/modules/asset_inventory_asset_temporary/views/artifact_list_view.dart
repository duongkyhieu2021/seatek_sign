import 'package:flutter/material.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';
import 'package:sea_hr/widgets/list_empty.dart';

class ArtifactListView extends StatelessWidget {
  const ArtifactListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: AssetInventoryAssetTemporaryController
                .to.handleArtifactInfoCreate,
            child: const Text('Tạo'),
          ),
          const SizedBox(
            height: 12.0,
          ),
          AssetInventoryAssetTemporaryController
                  .to.listAssetInventoryAssetTemporary.isEmpty
              ? const ListEmpty(title: "Danh sách hiện vật trống")
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: AssetInventoryAssetTemporaryController
                      .to.listAssetInventoryAssetTemporary.length,
                  itemBuilder: (context, index) {
                    final assetInventoryAssetTemporary =
                        AssetInventoryAssetTemporaryController
                            .to.listAssetInventoryAssetTemporary[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        onTap: () {
                          AssetInventoryAssetTemporaryController.to
                              .handleArtifactInfoEdit(index);
                        },
                        title: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "[${assetInventoryAssetTemporary.code}] ${assetInventoryAssetTemporary.name}",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          assetInventoryAssetTemporary.description.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        shape: const RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
