import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/modules/account_asset_image/controller/account_asset_image_controller.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/widgets/artifact_images_list.dart';

class ArtifactImages extends StatelessWidget {
  const ArtifactImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(() => AccountAssetImageController.to.status.value == 1
          ? Center(
              child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.blue,
              size: 60,
            ))
          : const ArtifactImagesList()),
    );
  }
}
