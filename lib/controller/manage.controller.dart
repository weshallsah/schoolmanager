import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class ManageController extends GetxController {
  RxList list = [].obs;
  List items = [
    'STD -1',
    'STD 1',
    'STD 2',
    'STD 3',
    'STD 4',
    'STD 5',
    'STD 6',
    'STD 7',
  ].obs;
  RxList selecteditem = [].obs;
  RxMap teacherstd = {}.obs;
  // RxString selecteditem = 'STD 1'.obs;
  String school = "";
  @override
  void onInit() async {
    // TODO: implement onInit
    try {
      super.onInit();
      UserModel userModel = await AuthService.getuser();
      school = userModel.school;
      if (school == "") {
        return;
      }
      final res = await http
          .get(Uri.parse("http://${localhost}/api/v1/teacher/list/${school}"));
      // print(res);
      final response = jsonDecode(res.body);
      // print(response);
      list.value = response['payload'];
      for (var teacher in response['payload']) {
        // list.add(teacher);
        if (teacher['standard'] == -1) {
          // teacherstd['-1'] = false;
          // print("teacher has -1");
          continue;
        }
        // print("teacher dont have -1");
        teacherstd["${teacher['standard']}"] = true;
      }
      for (int i = 1; i < 8; i++) {
        if (teacherstd["${i}"] == null) {
          teacherstd["${i}"] = false;
        }
      }
    } catch (e) {
      print("error := e");
    }
  }

  void standard(GlobalKey<ScaffoldState> _gloabalkey, int index) async {
    bool ismy = false;
    try {
      String digit = "";
      for (int i = selecteditem[index].length - 1; i >= 0; i--) {
        // print(selecteditem[index][i]);
        if (selecteditem[index][i].toString().isNum) {
          digit = selecteditem[index][i] + digit;
        }
        if (selecteditem[index][i] == '-') {
          digit = selecteditem[index][i] + digit;
        }
      }
      print(teacherstd[digit]);
      if (teacherstd[digit] != null && teacherstd[digit]) {
        ismy = true;
        throw "standard alredy have a teacher";
      }
      print(list[index]['standard']);
      // print(list[index]);
      print("${teacherstd[list[index]['standard']]}");
      teacherstd["${list[index]['standard']}"] = false;
      final res = await http.get(Uri.parse(
          "http://${localhost}/api/v1/teacher/standard/${list[index]['_id']}/${digit}"));
      final response = jsonDecode(res.body);
      print(response);
      if (response['status'] == 200) {
        showtoast(_gloabalkey, "standard updated", false);
        onInit(); 
        return;
      } else {
        showtoast(_gloabalkey, "Something went wrong", true);
      }
    } catch (e) {
      print("Error  :=  ${e}");
      showtoast(
          _gloabalkey, ismy ? e.toString() : "Something went wrong", true);
    }
  }

  void fire(GlobalKey<ScaffoldState> _gloabalkey, int index) async {
    try {
      print(list[index]['_id']);
      final res = await http.get(Uri.parse(
          "http://${localhost}/api/v1/teacher/fire/${list[index]['_id']}"));
      final response = jsonDecode(res.body);
      print(response);
      if (response['status'] == 200) {
        showtoast(_gloabalkey, "Teacher Remove", false);
        onInit();
        return;
      } else {
        showtoast(_gloabalkey, "Something went wrong", true);
      }
    } catch (e) {
      print("Error  :=  ${e}");
      showtoast(_gloabalkey, "Something went wrong", true);
    }
  }
}
