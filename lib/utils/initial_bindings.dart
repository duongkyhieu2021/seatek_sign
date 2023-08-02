import 'package:get/get.dart';
import 'package:sea_hr/controllers/login_controller.dart';
import 'package:sea_hr/controllers/main_controller.dart';
import 'package:sea_hr/controllers/start_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    await mainController();
    await startController();
    await loginController();
  }

  Future<void> mainController() async {
    Get.put(MainController(), permanent: true);
  }

  Future<void> startController() async {
    Get.put(StartController(), permanent: true);
  }

  Future<void> loginController() async {
    Get.put(LoginController(), permanent: true);
  }
}
