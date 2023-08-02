import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/account_asset_image/controller/account_asset_image_controller.dart';

class ArtifactImagesList extends StatelessWidget {
  const ArtifactImagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountAssetImageController>(
      builder: (controller) => GridView.builder(
        shrinkWrap: true,
        physics:
            const BouncingScrollPhysics(), // Disable scrolling for this GridView
        itemCount: AccountAssetImageController.to.listAccountAssetImage.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          final assetImage = AccountAssetImageController
              .to.listAccountAssetImage[index].assetImage;
          if (assetImage != null) {
            return Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                Image.memory(
                  base64Decode(assetImage),
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                      onPressed: () {
                        AccountAssetImageController
                                .to.currentAccountAssetImage.value =
                            AccountAssetImageController
                                .to.listAccountAssetImage[index];
                        AccountAssetImageController.to
                            .openImagesUploadModal(context, index);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                      onPressed: () => AccountAssetImageController.to
                          .handleDeleteImage(index),
                      icon: Icon(
                        Icons.delete,
                        color: AccountAssetImageController.to.selected.value ==
                                index
                            ? Colors.red
                            : Colors.white,
                      )),
                )
              ],
            );
          } else {
            return Container(); // Or any other fallback widget
          }
        },
      ),
    );
  }
}
