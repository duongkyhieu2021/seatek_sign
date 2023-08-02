import 'package:flutter/material.dart';
import 'package:sea_hr/modules/account_asset_image/controller/account_asset_image_controller.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/widgets/artifact_code_input.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/widgets/artifact_desc.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/widgets/artifact_images.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/widgets/artifact_name_input.dart';

class ArtifactBodyView extends StatelessWidget {
  const ArtifactBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const ArtifactCodeInput(),
          const SizedBox(height: 12.0),
          const ArtifactNameInput(),
          const SizedBox(height: 12.0),
          const ArtifactDesc(),
          const SizedBox(height: 12.0),
          ElevatedButton.icon(
              onPressed: () {
                AccountAssetImageController.to
                    .openImagesUploadModal(context, 0);
              },
              icon: const Icon(
                Icons.cloud_upload,
              ),
              label: const Text(
                "Tải ảnh",
                style: TextStyle(fontSize: 14.0),
              )),
          const SizedBox(
            height: 12.0,
          ),
          const Expanded(child: ArtifactImages()),
        ],
      ),
    );
  }
}
