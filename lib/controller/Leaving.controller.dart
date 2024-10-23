import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/snakbar.dart';

import '../utils/constant.dart';

class LeavingController extends GetxController {
  List fieldnames = [
    "StudentID",
    "School/Board Annual Exam result",
    "last paid dues",
    "Fee Concession",
    "NCC/Boy Scout/Girl Guide",
    "General Conduct",
    "Reason for Leaving",
    "Remarks",
  ];
  RxBool isloading = false.obs;
  RxList Formfild = [].obs;
  RxString Lc = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    for (int i = 0; i < fieldnames.length; i++) {
      Formfild.add(TextEditingController());
    }
  }

  void getLeavingcertificate(GlobalKey<ScaffoldState> _formkey) async {
    bool ismy = false;
    try {
      Lc.value = "";
      isloading.value = true;
      UserModel userModel = await AuthService.getuser();
      final res = await http.post(
        Uri.parse("http://${localhost}/api/v1/student/LeavingCertificate"),
        body: {
          "schoolId": userModel.school,
          "StudentID": Formfild[0].text,
          "Examresult": Formfild[1].text,
          "lastpaiddues": Formfild[2].text,
          "FeeConcession": Formfild[3].text,
          "activites": Formfild[4].text,
          "GeneralConduct": Formfild[5].text,
          "ReasonforLeaving": Formfild[6].text,
          "Remarks": Formfild[7].text
        },
      );
      if (res.statusCode == 404) {
        ismy = true;
        throw "No student found with this enroll";
      }
      print(res.statusCode);
      if (res.statusCode != 200) {
        throw "server went wrong";
      }

      final response = res.body;
      print(response.codeUnits);
      var status = await Permission.storage.status;
      print(status);
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final tempDir = "/storage/emulated/0/Download";
      File file = await File('${tempDir}/${Formfild[0].text}LC.png').create();
      // print(file);
      imageCache.clear();
      imageCache.clearLiveImages();
      file.writeAsBytesSync(response.codeUnits);
      Lc.value = file.path;
      showtoast(_formkey, "Lc generated", false);
      isloading.value = false;
      for (int i = 0; i < Formfild.length; i++) {
        Formfild[i].clear();
      }
    } catch (e) {
      print("Error := ${e}");
      showtoast(_formkey, ismy ? e.toString() : "Someting went wrong", true);
      Get.back();
    }
  }
}
