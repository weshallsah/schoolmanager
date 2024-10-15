import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolmanager/controller/splash.controller.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/attendace.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class HomeController extends GetxController {
  RxList<String> name = ["attendance", "bonafide", "certificate", "leave"].obs;
  RxString username = "".obs;
  RxString school = "".obs;
  RxBool isadmin = false.obs;
  final Rx<DateTime> date = DateTime.now().obs;
  RxString greet = "Good Evening".obs;
  RxBool isadmission = false.obs;
  RxString photo = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    UserModel userModel = await AuthService.getuser();
    username.value = userModel.name;
    school.value = userModel.school;
    isadmin.value = userModel.isadmin;
    photo.value = userModel.photo;
  }

  void clicked(int idx) {
    switch (idx) {
      case 0:
        attendace();
        break;
      case 1:
        bonafide();
        break;
      case 2:
        Progress();
        break;
      case 3:
        leave();
        break;
      default:
    }
  }

  void attendace() {
    print("attendance");
    Get.to(() => Attendancescreen());
  }

  void bonafide() {
    print("bonafide");
  }

  void Progress() {
    print("progress");
  }

  void leave() {
    print("leave");
  }

  void logout() async {
    AuthService.deleteuser();
  }
}
