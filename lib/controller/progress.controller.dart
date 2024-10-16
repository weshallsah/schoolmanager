import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';

class ProgressController extends GetxController {
  RxList students = [].obs;
  RxInt tream = 1.obs;
  RxList subject = [].obs;
  // RxList marks = [].obs;
  RxInt isfeedback = 0.obs;
  RxList formfield = [].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    UserModel userModel = await AuthService.getuser();
    final res = await http.get(Uri.parse(
      "http://10.0.2.2:9000/api/v1/student/marks/${userModel.school}/${tream}/${1}",
    ));
    print(res.body);
    final response = await jsonDecode(res.body);
    students.value = response['payload'];
    subject.value = jsonDecode(response['payload'][0]['result']['subject'][0]);
    for (int i = 0; i < subject.length; i++) {
      formfield.add(TextEditingController());
    }
    // for (int i = 0; i < students.length; i++) {
    // subject.add(jsonDecode(response['payload'][i]['result']['subject'][0]));
    // marks.add(response['payload'][i]['result']['marks']);
    // }
  }

  void getprogress() async {
    
  }
}
