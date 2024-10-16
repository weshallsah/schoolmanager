import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';

class AuthController extends GetxController {
  TextEditingController school = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void submit() async {
    print("submitinggggg");
    final res = await http
        .post(Uri.parse('http://${localhost}/api/v1/teacher/login'), body: {
      "school": school.text,
      "email": email.text,
      "password": password.text
    });
    print(res.body);
    final response = jsonDecode(res.body);
    // print(response);
    if (response['status'] == 200) {
      await AuthService.setlogin(UserModel.fromJson(response['payload'], true));
      school.clear();
      email.clear();
      password.clear();
      Get.offAll(Homescreen());
    }
  }
}
