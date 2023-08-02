import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sea_hr/OdooRepository/odoo_repository.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/account_asset_image/repository/record.dart';
import 'package:sea_hr/modules/account_asset_image/repository/repos.dart';
import 'package:sea_hr/modules/account_asset_image/views/images_upload.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/controller/asset_inventory_asset_temporary_controller.dart';

class AccountAssetImageController extends GetxController {
  static AccountAssetImageController get to =>
      Get.find<AccountAssetImageController>();

  RxBool isCompleted = false.obs;
  RxInt status = 0.obs;
  RxInt selected = (-1).obs;
  Rx<AccountAssetImageRecord> currentAccountAssetImage =
      AccountAssetImageRecord.initAccountAssetImage().obs;
  RxList<AccountAssetImageRecord> listAccountAssetImage =
      <AccountAssetImageRecord>[].obs;

  RxList<AccountAssetImageRecord> tempListUploadImages =
      <AccountAssetImageRecord>[].obs;

  // NOTE: Ds ảnh cần xóa
  List<AccountAssetImageRecord> listAccountAssetImageUnLink = [];

  // NOTE: Ds ảnh cần update
  List<AccountAssetImageRecord> listAccountAssetImageUpdate = [];
  @override
  void onInit() {
    log("init AccountAssetImageController");
    MainController mainController = Get.find<MainController>();
    OdooEnvironment env = mainController.env;
    AccountAssetImageRepository tempRepos = AccountAssetImageRepository(env);
    mainController.env.add(tempRepos);
    super.onInit();
  }

  void clearCurrentAccountAssetImage() {
    currentAccountAssetImage =
        AccountAssetImageRecord.initAccountAssetImage().obs;
  }

  Future<void> fetchAccountAssetImages() async {
    try {
      status.value = 1;
      OdooEnvironment env = Get.find<MainController>().env;
      AccountAssetImageRepository tempRepos = AccountAssetImageRepository(env);
      tempRepos.domain = [
        [
          'asset_temporary_id',
          '=',
          AssetInventoryAssetTemporaryController
              .to.currentAssetInventoryAssetTemporary.id
        ]
      ];
      await tempRepos.fetchRecords();
      listAccountAssetImage.clear();
      listAccountAssetImage.value = tempRepos.latestRecords;
      status.value = 2;
      update();
    } catch (e) {
      status.value = 3;
      log("AccountAssetImageController fetchAccountAssetImage $e");
    }
  }

  // NOTE: Hàm tạo ảnh
  Future<void> createAccountAssetImage() async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      isCompleted.value = false;
      await env
          .of<AccountAssetImageRepository>()
          .create(currentAccountAssetImage.value)
          .then((value) {
        isCompleted.value = true;
      }).catchError((error) {
        log("error createAccountAssetImage $error");
      });
    } catch (e) {
      log("$e AccountAssetImageController createAccountAssetImage");
    }
  }

  // NOTE: Hàm cập nhật ảnh
  Future<void> writeAccountAssetImage(
      AccountAssetImageRecord accountAssetImage) async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;

      env.of<AccountAssetImageRepository>().domain = [
        [
          'asset_temporary_id',
          '=',
          AssetInventoryAssetTemporaryController
              .to.currentAssetInventoryAssetTemporary.id
        ]
      ];

      await env.of<AccountAssetImageRepository>().fetchRecords();
      isCompleted.value = false;
      await env
          .of<AccountAssetImageRepository>()
          .write(accountAssetImage)
          .then((value) {
        isCompleted.value = true;
      }).catchError((error) {
        log("error writeAccountAssetImage $error");
      });
    } catch (e) {
      log("$e AccountAssetImageController writeAccountAssetImage");
    }
  }

  // NOTE: Hàm xóa ảnh khi bấm lưu
  Future<void> unlinkAccountAssetImage(
      AccountAssetImageRecord accountAssetImage) async {
    try {
      OdooEnvironment env = Get.find<MainController>().env;
      isCompleted.value = false;
      print("dkh $accountAssetImage");
      await env
          .of<AccountAssetImageRepository>()
          .unlink(accountAssetImage)
          .then((value) {
        isCompleted.value = true;
      }).catchError((error) {
        log("error unlinkAccountAssetImage $error");
      });
    } catch (e) {
      log("$e AccountAssetImageController unlinkAccountAssetImage");
    }
  }

  Future<void> openImagesUploadModal(BuildContext parentContext, int index) =>
      showDialog(
          context: parentContext,
          builder: (parentContext) =>
              ImagesUpload(parentContext: parentContext, index: index));

  // NOTE: Hàm chuyển ảnh về base64Encode khi chụp
  void handleImagesUpload() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      // Read the image file as bytes
      List<int> imageBytes = await photo.readAsBytes();

      // Encode the image bytes to Base64
      String base64Image = base64Encode(imageBytes);

      currentAccountAssetImage.value.assetImage = base64Image;
      update();
    }
  }

  // NOTE: Hàm upload ảnh tạm thời
  void handleUploadImage(BuildContext context) {
    tempListUploadImages.add(currentAccountAssetImage.value);
    listAccountAssetImage.add(currentAccountAssetImage.value);
    clearCurrentAccountAssetImage();
    Navigator.pop(context);
    update();
  }

  // NOTE: Hàm tạo ảnh lên database
  Future<void> handleCreateImageUpload() async {
    try {
      for (var element in tempListUploadImages) {
        element.assetTemporaryId = [
          AssetInventoryAssetTemporaryController
              .to.currentAssetInventoryAssetTemporary.id
        ];
        currentAccountAssetImage.value = element;
        await createAccountAssetImage();
      }
      tempListUploadImages.clear();
    } catch (e) {
      log("$e handleCreateImageUpload");
    }
  }

  // NOTE: Hàm xóa ảnh khi bấm lưu
  Future<void> handleUnlinkImageUpload() async {
    try {
      for (var element in listAccountAssetImageUnLink) {
        await unlinkAccountAssetImage(element);
      }
      listAccountAssetImageUnLink.clear();
      // !D/EGL
    } catch (e) {
      log("$e handleUnlinkImageUpload");
    }
  }

  // NOTE: Hàm xử lý xóa ảnh
  void handleDeleteImage(int index) async {
    try {
      listAccountAssetImageUnLink = [];
      selected.value = index;
      if (listAccountAssetImage[index].assetTemporaryId!.isNotEmpty) {
        listAccountAssetImageUnLink.add(listAccountAssetImage[index]);
      } else {
        listAccountAssetImage.removeAt(index);
      }
      update();
    } catch (e) {
      log("$e handleDeleteImage");
    }
  }

  // NOTE: Hàm cập nhật accountAssetImage tạm
  void updateAccountAssetImage(BuildContext context, int index) {
    try {
      listAccountAssetImageUpdate.add(currentAccountAssetImage.value);
      clearCurrentAccountAssetImage();
      Navigator.pop(context);
    } catch (e) {
      log("$e updateAccountAssetImage");
    }
  }

  // NOTE: Hàm cập nhật thông tin ảnh khi lưu
  Future<void> handleUpdateImage() async {
    try {
      for (var element in listAccountAssetImageUpdate) {
        await writeAccountAssetImage(element);
      }
      // !D/EGL
      listAccountAssetImageUpdate = [];
    } catch (e) {
      log("$e handleUpdateImage");
    }
  }
}
