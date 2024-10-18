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
  RxList presentlist = [].obs;
  RxInt cnt = 0.obs;
  RxBool istaken = false.obs;
  UserModel? user;
  @override
  void onInit() async {
    super.onInit();
    user = await AuthService.getuser();
    isadmin.value = user!.isadmin;
    std.value = "std ${user!.std}";
    // print(isadmin.value);
    final res = await http.get(
        Uri.parse("http://${localhost}/api/v1/student/list/${user!.school}"));
    final response = jsonDecode(res.body);
    // print(response);
    for (var teacher in response['payload']) {
      student.add(teacher);
    }
    selecteddate.value =
        ((dateTime.year * 100) + dateTime.month) * 100 + dateTime.day;
    today.value = ((dateTime.year * 100) + dateTime.month) * 100 + dateTime.day;
    istaken.value = await AttendanceService.istaken(today);
    await getpresent();
  }

  Future getpresent() async {
    final res = await await http.get(
      Uri.parse(
        "http://${localhost}/api/v1/attendance/list/${selecteddate.toString()}/${user!.school}/${user!.std}",
      ),
    );
    final Response = jsonDecode(res.body);
    print(Response["payload"]);
    if (Response['payload'] != null) {
      for (int i = 0; i < Response['payload'].length; i++) {
        presentlist.value[i] = Response['payload'][i];
      }
    }
  }

  void upload(GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      final res = await http.post(
          Uri.parse(
            "http://${localhost}/api/v1/attendance/upload/${today}/${user!.school}/${user!.std}",
          ),
          body: {
            "attendance": jsonEncode(presentlist),
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
