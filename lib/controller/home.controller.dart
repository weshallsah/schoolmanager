import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schoolmanager/controller/splash.controller.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/Bonafide.dart';
import 'package:schoolmanager/screen/Leaveing.dart';
import 'package:schoolmanager/screen/attendace.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/screen/progress.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';
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
  RxBool isrequested = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    try {
      UserModel userModel = await AuthService.getuser();
      username.value = userModel.name;
      school.value = userModel.school;
      isadmin.value = userModel.isadmin;
      photo.value = userModel.photo;
      if (!isrequested.value) {
        print(isrequested);
        final res = await http.get(Uri.parse(
            'http://${localhost}/api/v1/teacher/getteacher/${userModel.id}'));
        print(res.statusCode);
        if (res.statusCode == 200) {
          print("here");
          final response = jsonDecode(res.body)['payload'];
          if (userModel.std != response['standard']) {
            UserModel newuser = UserModel.fromJson(response, true);
            await AuthService.setlogin(newuser);
          }
        }
        isrequested.value = true;
      }
      refresh();
    } catch (e) {
      print("Error := ${e}");
    }
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

  void bonafide() async {
    var status = await Permission.storage.status;
    print(status);
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Get.to(() => Bonafide());
  }

  void Progress() async {
    var status = await Permission.storage.status;
    print(status);
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Get.to(() => ProgressCard());
  }

  void leave() async {
    var status = await Permission.storage.status;
    print(status);
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Get.to(() => LeaveingCertificate());
  }

  void logout() async {
    AuthService.deleteuser();
  }
}
