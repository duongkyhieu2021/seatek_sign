import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sea_hr/controllers/home_controller.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/views/drawer/dialog_select_company.dart';
import 'package:sea_hr/views/home/widgets/body.dart';
import 'package:sea_hr/widgets/bottom_navigator_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Obx(
        () => SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              key: scaffoldKey,
              appBar: HomeController.to.status.value == 1
                  ? null
                  : AppBar(
                      automaticallyImplyLeading: false,
                      elevation: 1,
                      title: Row(
                        children: [
                          (HomeController.to.user.value.image == null) ||
                                  (HomeController.to.user.value.image) == ""
                              ? const CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage("assets/images/avatar.png"))
                              : CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: MemoryImage(
                                    base64Decode(
                                        HomeController.to.user.value.image ??
                                            ""),
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  HomeController.to.user.value.name ?? "",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  HomeController.to.companyUser.value.name,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        PopupMenuButton(
                            elevation: 5,
                            offset: const Offset(0, kToolbarHeight),
                            icon: const Icon(Icons.settings),
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem<int>(
                                  value: 0,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.sync,
                                        color: Colors.black,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Chuyển công ty"),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<int>(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.black,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Đăng xuất"),
                                    ],
                                  ),
                                ),
                              ];
                            },
                            onSelected: (value) {
                              if (value == 0) {
                                if (HomeController.to.companiesOfU.isNotEmpty &&
                                    HomeController.to.companiesOfU[0].id != 0) {
                                  Get.bottomSheet(const DialogSelectCompany());
                                }
                              } else if (value == 1) {
                                Get.dialog(AlertDialog(
                                  title: const Text("Xác nhận"),
                                  content: const Text("Bạn có muốn đăng xuất?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text(
                                          "Hủy",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 92, 90, 90),
                                              fontSize: 16),
                                        )),
                                    TextButton(
                                        onPressed:
                                            Get.find<MainController>().logout,
                                        child: const Text(
                                          "Đăng xuất",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 16),
                                        )),
                                  ],
                                ));
                              }
                            }),
                      ],
                    ),
              bottomNavigationBar: HomeController.to.status.value == 1
                  ? null
                  : const BottomNavigatorAppBar(),
              body: SafeArea(
                child: SingleChildScrollView(
                    child: HomeController.to.status.value == 1
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: LoadingAnimationWidget.prograssiveDots(
                                color: Colors.blue,
                                size: 60,
                              ),
                            ))
                        : HomeController.to.status.value == 3
                            ? const Center(
                                child: Text(
                                    "Lỗi ứng dụng, liên hệ Nhà phát triển."))
                            : const Body()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
