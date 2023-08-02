// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_hr/modules/account_asset_image/controller/account_asset_image_controller.dart';
import 'package:sea_hr/modules/account_asset_image/views/image_name_input.dart';
import 'package:sea_hr/theme.dart';

class ImagesUpload extends StatelessWidget {
  final BuildContext parentContext;
  final int index;
  const ImagesUpload({
    Key? key,
    required this.parentContext,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<AccountAssetImageController>(
            builder: (controller) => AccountAssetImageController
                        .to.currentAccountAssetImage.value.assetImage ==
                    ""
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed:
                        AccountAssetImageController.to.handleImagesUpload,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: ThemeApp.light().primaryColor,
                      size: 60.0,
                    ))
                : Image.memory(
                    base64Decode(AccountAssetImageController
                        .to.currentAccountAssetImage.value.assetImage!),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const ImageNameInput()
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            AccountAssetImageController.to.clearCurrentAccountAssetImage();
            Navigator.pop(context); // Đóng AlertDialog
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () async {
            log("message ${AccountAssetImageController.to.currentAccountAssetImage.value.id}");
            if (AccountAssetImageController
                    .to.currentAccountAssetImage.value.id ==
                0) {
              // NOTE: Hàm lưu ảnh tạm thời
              AccountAssetImageController.to.handleUploadImage(context);
            } else {
              AccountAssetImageController.to
                  .updateAccountAssetImage(context, index);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
