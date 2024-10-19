import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class ProgressController extends GetxController {
  RxList students = [].obs;
  RxInt tream = 1.obs;
  RxList subject = [].obs;
  RxInt isfeedback = 0.obs;
  RxList formfield = [].obs;
  RxBool isgenerate = true.obs;
  RxBool isadmin = false.obs;
  var progress;
  RxBool isloading = false.obs;
  var items = [
    'STD 1',
    'STD 2',
    'STD 3',
    'STD 4',
    'STD 5',
    'STD 6',
    'STD 7',
  ].obs;
  RxString selecteditem = 'STD 1'.obs;
  UserModel? userModel;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    userModel = await AuthService.getuser();
    isadmin.value = userModel!.isadmin;
    final res = await http.get(Uri.parse(
      "http://${localhost}/api/v1/student/marks/${userModel!.school}/${tream}/${userModel!.std}",
    ));
    print(res.body);
    final response = await jsonDecode(res.body);
    if (res.statusCode != 200) {
      return;
    }
    if (response['payload'].length <= 0) {
      students.value = [];
      return;
    }
    students.value = response['payload'];
    students.reactive;
    subject.value = jsonDecode(response['payload'][0]['result']['subject'][0]);
    subject.reactive;
    for (int i = 0; i < subject.length; i++) {
      formfield.add(TextEditingController());
    }
    refresh();
  }

  void Download(int idx) async {
    try {
      isloading.value = true;
      final res = await http
          .post(Uri.parse("http://${localhost}/api/v1/marks/download"), body: {
        "tream": tream.value.toString(),
        "markID": students[idx]['result']['_id'],
      });
      print(res.body);
      final response = res.body;
      print(response);
      final tempDir = "/storage/emulated/0/Download/";
      File file =
          await File('${tempDir}/progress${students[idx]['enroll']}.png')
              .create();
      file.writeAsBytesSync(response.codeUnits);
      print(file.path);
      progress = File(file.path);
      isloading.value = false;
    } catch (e) {
      print("Error := ${e}");
    }
  }

  Future generate(int idx, GlobalKey<ScaffoldState> _globalKey) async {
    try {
      List feedbacks = [];
      for (int i = 0; i < subject.length; i++) {
        feedbacks.add(formfield[i].text);
      }
      final res = await http
          .post(Uri.parse("http://${localhost}/api/v1/marks/generate"), body: {
        "feedbacks": jsonEncode(feedbacks),
        "marks": students[idx]['result']['_id']
      });
      print(res.body);
      final response = await jsonDecode(res.body);
      // students[idx] = response['payload'];

      print(response);
      if (response['status'] == 200) {
        students[idx]['result']['progress'] = true;
        showtoast(_globalKey, "progress generated successfully", false);
        for (int i = 0; i < subject.length; i++) {
          formfield.value.clear();
        }
        isfeedback.value = 0;
        refresh();
      }
      if (response['status'] == 400) {
        showtoast(_globalKey, "Certificate alredy exist", false);
      }
    } catch (e) {}
  }
}
