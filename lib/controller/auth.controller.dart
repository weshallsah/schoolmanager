import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/service/auth.service.dart';

class AuthController extends GetxController {
  TextEditingController school = TextEditingController();
  TextEditingController enroll = TextEditingController();
  TextEditingController password = TextEditingController();
  void submit() async {
    print("submitinggggg");
    final res = await http
        .post(Uri.parse('http://10.0.2.2:9000/api/v1/teacher/login'), body: {
      "school": school.text,
      "enroll": enroll.text,
      "password": password.text
    });
    final response = jsonDecode(res.body);
    // print(response);
    if (response['status'] == 200) {
      await AuthService.setlogin(UserModel.fromJson(response['payload'], true));
      school.clear();
      enroll.clear();
      password.clear();
      Get.offAll(Homescreen());
    }
  }
}
