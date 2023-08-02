import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_autoupdate/flutter_autoupdate.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/modules/res_user/repository/user_repository.dart';
import 'package:version/version.dart';

class StartController extends GetxController {
  UpdateResult? updateResult;
  int status = 2;

  @override
  void onInit() async {
    super.onInit();
    MainController mainController = Get.find<MainController>();
    await mainController.init();
    await checkVersion().then((value) async {
      int result = await UserRepository(mainController.env).checkSession();
      if (status == 2) {
        if (result == 1) {
          await Future.delayed(const Duration(milliseconds: 1000));
          Get.offAndToNamed("/home");
        } else {
          await Future.delayed(const Duration(milliseconds: 1000));
          Get.offAndToNamed("/login");
        }
      }
    });
  }

  Future<void> checkVersion() async {
    final internet = await InternetConnectionChecker().hasConnection;
    if (internet) {
      final packageInfo = await PackageInfo.fromPlatform();
      final versionApp = packageInfo.version;

      final manager = UpdateManager(
        versionUrl:
            "https://seahr-11803-default-rtdb.firebaseio.com/sea_hr.json",
      );
      final result = await manager.fetchUpdates();
      if (result!.latestVersion > Version.parse(versionApp)) {
        status = 1;
        updateResult = result;
        showUpdateDialog();
      }
    }
  }

  void showUpdateDialog() {
    // Đoạn mã hiển thị hộp thoại cập nhật từ câu hỏi ban đầu
    showDialog(
      barrierDismissible: false,
      context: Get.overlayContext!,
      builder: (_) => AlertDialog(
        title: const Text("Thông báo"),
        content:
            const Text("Vui lòng cập nhật phiên bản mới để tiếp tục sử dụng"),
        actions: [
          TextButton(
            child: const Text("Cập nhật"),
            onPressed: () {
              performAutoUpdate();
            },
          ),
        ],
      ),
    );
  }

  Future<void> performAutoUpdate() async {
    // Đoạn mã thực hiện cập nhật từ câu hỏi ban đầu
    Navigator.of(Get.overlayContext!).pop();
    showDialog(
      barrierDismissible: false,
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(left: 7, top: 20),
                child: Text("Đang cập nhật..."),
              ),
            ],
          ),
        );
      },
    );
    final controller = await updateResult!.initializeUpdate();
    controller.stream.listen((event) async {
      if (event.completed) {
        await controller.close();
        await updateResult!.runUpdate(event.path, autoExit: true);
        status = 2;
      }
    });
    Navigator.of(Get.overlayContext!).pop();
  }
}
