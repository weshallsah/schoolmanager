import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController name = TextEditingController();
  RxBool isloading = false.obs;
  RxBool issignup = false.obs;
  void submit(GlobalKey<ScaffoldState> _scaffoldkey) async {
    try {
      FocusScope.of(_scaffoldkey.currentContext as BuildContext).unfocus();
      isloading.value = true;
      print("submitinggggg");
      if (password.text.isEmpty) {
        throw "please enter password";
      }
      if (!email.text.isEmail || email.text.isEmpty) {
        throw "Email is invalid";
      }
      // print("false");
      final res = await http.post(
          Uri.parse('http://${localhost}/api/v1/teacher/login'),
          body: {"email": email.text, "password": password.text});
      print(res.body);
      final response = jsonDecode(res.body);
      print(response);
      if (response['status'] == 200) {
        showtoast(_scaffoldkey, "Login successful", false);
        await AuthService.setlogin(
            UserModel.fromJson(response['payload'], true));
        email.clear();
        password.clear();
        Get.offAll(() => Homescreen());
        isloading.value = false;
        return;
      }
      if (response['status'] != 500) {
        showtoast(_scaffoldkey, response['message'], true);
      } else {
        throw "Something went worng";
      }
    } catch (e) {
      print(e);
      showtoast(_scaffoldkey, e.toString(), true);
    }
    isloading.value = false;
  }

  void signup(GlobalKey<ScaffoldState> _scaffoldkey) async {
    try {
      FocusScope.of(_scaffoldkey.currentContext as BuildContext).unfocus();
      isloading.value = true;
      // print("submitinggggg");
      if (password.text.isEmpty) {
        throw "please enter password";
      }
      if (!email.text.isEmail || email.text.isEmpty) {
        throw "Email is invalid";
      }
      if (school.text.isEmpty) {
        throw "please enter school";
      }
      if (name.text.isEmpty) {
        throw "please enter your name";
      }
      // print("false");
      final res = await http.post(
          Uri.parse('http://${localhost}/api/v1/teacher/register'),
          body: {
            "email": email.text,
            "password": password.text,
            "school": school.text,
            "name": name.text
          });
      print(res.body);
      final response = jsonDecode(res.body);
      print(response);
      if (response['status'] == 200) {
        showtoast(_scaffoldkey, "Login successful", false);
        await AuthService.setlogin(
            UserModel.fromJson(response['payload'], true));
        email.clear();
        password.clear();
        name.clear();
        school.clear();
        Get.offAll(() => Homescreen());
        isloading.value = false;
        return;
      }
      if (response['status'] != 500) {
        showtoast(_scaffoldkey, response['message'], true);
      } else {
        throw "Something went worng";
      }
    } catch (e) {
      print(e);
      showtoast(_scaffoldkey, e.toString(), true);
    }
    isloading.value = false;
  }
}
