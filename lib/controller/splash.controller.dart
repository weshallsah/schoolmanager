import 'package:get/get.dart';
import 'package:schoolmanager/screen/auth.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/service/auth.service.dart';

class SplashController extends GetxController {
  RxBool islogin = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    islogin.value = await AuthService.islogin();
    print(islogin);
    if (islogin.value) {
      Get.offAll(Homescreen());
      return;
    }
    Get.offAll(Authscreen());
  }
}
