import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class BonafideController extends GetxController {
  TextEditingController enroll = TextEditingController();
  RxBool isloaded = false.obs;
  RxBool isloading = false.obs;
  RxString bonafide = "".obs;
  Future generate(GlobalKey<ScaffoldState> _key) async {
    try {
      isloading.value = true;
      isloaded.value = false;
      bonafide.value = "";
      if (enroll.text.isEmpty) {
        showtoast(_key, "enter enrollment number", false);
        return;
      }
      UserModel user = await AuthService.getuser();
      print(user.school);
      final res = await http.get(Uri.parse(
          "http://${localhost}/api/v1/student/bonafide/${enroll.text}/${user.school}"));
      print(res.body);
      if (res.statusCode != 200) {
        throw "somwthing went wrong";
      }
      final response = res.body;
      print(response);
      final tempDir = "/storage/emulated/0/Download";
      final date = DateTime.now();
      File file = await File('${tempDir}/bonafide${enroll.text}.png').create();
      file.writeAsBytesSync(response.codeUnits);
      imageCache.clear();
      imageCache.clearLiveImages();
      print(file.path);
      await Future.delayed(Duration(milliseconds: 200));
      bonafide.value = file.path;
      if (bonafide.value != "") {
        isloaded.value = true;
      }
      isloaded.reactive;
      isloading.value = false;
    } catch (e) {
      print("Error := ${e}");
      showtoast(_key, "somwthing went wrong", false);
    }
    isloading.value = false;
  }
}

// api/v1/student/bonafide/TCH001/new english high school