import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sea_hr/modules/account_asset_asset/views/account_asset_asset_info_view.dart';
import 'package:sea_hr/modules/asset_inventoried_department/views/asset_inventory_employee_info_view.dart';
import 'package:sea_hr/modules/asset_inventory/views/asset_inventory_info_view.dart';
import 'package:sea_hr/modules/asset_inventory/views/asset_inventory_view.dart';
import 'package:sea_hr/modules/asset_inventory_asset_temporary/views/artifact_info_view.dart';
import 'package:sea_hr/modules/asset_inventory_committee/views/asset_inventory_committee_info_view.dart';
import 'package:sea_hr/modules/asset_inventory_line/views/asset_inventory_line_info_view.dart';
import 'package:sea_hr/theme.dart';
import 'package:sea_hr/utils/asset_inventory_bindings.dart';
import 'package:sea_hr/utils/home_bindings.dart';
import 'package:sea_hr/utils/initial_bindings.dart';
import 'package:sea_hr/views/home/home.dart';
import 'package:sea_hr/views/login_page.dart';
import 'package:sea_hr/views/start_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await GetStorage.init();
  Get.config(
    enableLog: false,
    defaultTransition: Transition.native,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Phoenix(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: false,
      theme: ThemeApp.light(),
      initialRoute: "/",
      initialBinding: InitialBindings(),
      getPages: [
        GetPage(
          name: "/",
          page: () => const StartPage(),
        ),
        GetPage(
            name: "/login",
            page: () => const LoginPage(),
            transition: Transition.noTransition),
        GetPage(
            name: "/home",
            page: () => const Home(),
            binding: HomeBindings(),
            transition: Transition.noTransition),
        GetPage(
            name: "/asset_inventory",
            binding: AssetInventoryBindings(),
            page: () => const AssetInventoryView(),
            transition: Transition.noTransition),
        GetPage(
          name: "/account_asset_info",
          page: () => const AccountAssetInfoPage(),
        ),
        GetPage(
          name: "/asset_inventory_info_edit",
          page: () => const AssetInventoryInfoView(isCreate: false),
        ),
        GetPage(
          name: "/asset_inventory_info_create",
          page: () => const AssetInventoryInfoView(isCreate: true),
        ),
        GetPage(
          name: "/asset_inventory_committee_info_edit",
          page: () => const AssetInventoryCommitteeInfoView(isCreate: false),
        ),
        GetPage(
          name: "/asset_inventory_committee_info_create",
          page: () => const AssetInventoryCommitteeInfoView(isCreate: true),
        ),
        GetPage(
          name: "/asset_inventory_line_info_create",
          page: () => const AssetInventoryLineInfoView(isCreate: true),
        ),
        GetPage(
          name: "/asset_inventory_line_info_edit",
          page: () => const AssetInventoryLineInfoView(isCreate: false),
        ),
        GetPage(
          name: "/asset_inventory_employee_info_create",
          page: () => const AssetInventoryEmployeeInfoView(isCreate: true),
        ),
        GetPage(
          name: "/asset_inventory_employee_info_edit",
          page: () => const AssetInventoryEmployeeInfoView(isCreate: false),
        ),
        GetPage(
          name: "/artifact_info_create",
          page: () => const ArtifactInfoView(isCreate: true),
        ),
        GetPage(
          name: "/artifact_info_edit",
          page: () => const ArtifactInfoView(isCreate: false),
        ),
      ],
    );
  }
}
