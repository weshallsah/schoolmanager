import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class AttendanceController extends GetxController {
  DateTime dateTime = DateTime.now();
  RxInt selecteddate = 0.obs;
  RxBool present = false.obs;
  RxBool Absent = false.obs;
  RxBool isadmin = false.obs;
  RxInt presentcnt = 0.obs;
  RxString std = "".obs;
  RxInt today = 0.obs;
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
  RxBool isuploaded = true.obs;
  RxList student = [].obs;
  RxMap presentlist = {}.obs;
  RxInt cnt = 0.obs;
  RxBool istaken = false.obs;
  UserModel? user;
  @override
  void onInit() async {
    super.onInit();
    try {
      user = await AuthService.getuser();
      isadmin.value = user!.isadmin;
      std.value = "std ${user!.std}";
      String digit = user!.std.toString();
      if (isadmin.value) {
        print(selecteditem.value);
        digit = "";
      }
      print(digit);
      if (isadmin.value) {
        for (int i = selecteditem.value.length - 1; i >= 0; i--) {
          if (selecteditem.value[i].toString().isNum) {
            digit = selecteditem.value[i] + digit;
          }
        }
      }
      print(digit);
      var res = await http.get(Uri.parse(
          "http://${localhost}/api/v1/student/list/${user!.school}/${digit}"));
      var response = jsonDecode(res.body);
      print(response);
      if (response['payload'].length > 0) {
        student.value = response['payload'];
        for (var st in student) {
          presentlist.value[st['_id']] = false;
        }
      } else {
        student.value = [];
      }
      selecteddate.value =
          ((dateTime.year * 100) + dateTime.month) * 100 + dateTime.day;
      // res = await http.get(Uri.parse("http://${localhost}/api/v1/Marks/check/${user!.school}/${dateTime}/"));
      today.value =
          ((dateTime.year * 100) + dateTime.month) * 100 + dateTime.day;
      istaken.value = await AttendanceService.istaken(today);
      await getpresent();
    } catch (e) {
      print("Error := ${e}");
    }
  }

  Future getpresent() async {
    try {
      String digit = user!.std.toString();
      presentcnt.value = 0;
      for (var st in student) {
        presentlist.value[st['_id']] = false;
      }
      // print(digit);
      if (isadmin.value) {
        digit = "";
        for (int i = selecteditem.value.length - 1; i >= 0; i--) {
          if (selecteditem.value[i].toString().isNum) {
            digit = selecteditem.value[i] + digit;
          }
        }
      }
      print(selecteddate);
      final res = await await http.get(
        Uri.parse(
          "http://${localhost}/api/v1/attendance/list/${selecteddate.toString()}/${user!.school}/${digit}",
        ),
      );
      final Response = jsonDecode(res.body);
      if (res.statusCode != 200) {
        throw 'something went wrong';
      }
      if (Response['payload'] == null) {
        return;
      }
      for (var element in Response['payload']['present']) {
        if (element != null) {
          // print(element);
          presentlist.value[element] = true;
          presentcnt.value++;
        }
      }
      presentlist.values.reactive;
      refresh();
    } catch (e) {
      print(e);
    }
  }

  void upload(GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      List presentupload = [];
      for (int i = 0; i < student.length; i++) {
        if (presentlist[student[i]['_id']]) {
          presentupload.add(student[i]['_id']);
        }
      }
      print(presentupload);
      final res = await http.post(
          Uri.parse(
            "http://${localhost}/api/v1/attendance/upload/${today}/${user!.school}/${user!.std}",
          ),
          body: {
            "attendance": jsonEncode(presentupload),
          });
      print(res.body);
      final Response = jsonDecode(res.body);
      if (Response['status'] == 200) {
        await AttendanceService.setlogin(today);
        istaken.value = true;
        showtoast(_scaffoldKey, Response['payload'], false);
        return;
      }
      showtoast(_scaffoldKey, "someting went wrong", true);
    } catch (e) {
      showtoast(_scaffoldKey, "something went wrong", true);
    }
  }
}
