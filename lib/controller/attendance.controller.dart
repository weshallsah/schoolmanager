import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/utils/snakbar.dart';

class AttendanceController extends GetxController {
  DateTime dateTime = DateTime.now();
  RxInt selecteddate = 0.obs;
  RxBool present = true.obs;
  RxBool Absent = true.obs;
  RxBool isadmin = false.obs;
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
  String school = "";
  RxBool istaken = false.obs;
  @override
  void onInit() async {
    super.onInit();
    UserModel user = await AuthService.getuser();
    isadmin.value = user.isadmin;
    school = user.school;
    // print(isadmin.value);
    final res = await http
        .get(Uri.parse("http://10.0.2.2:9000/api/v1/student/list/${school}"));
    final response = jsonDecode(res.body);
    // print(response);
    for (var teacher in response['payload']) {
      student.add(teacher);
    }
    for (int i = 0; i < student.length; i++) {
      presentlist.add("");
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
        "http://10.0.2.2:9000/api/v1/attendance/list/${selecteddate.toString()}/${school}",
      ),
    );
    final Response = jsonDecode(res.body);
    print(Response["payload"]);
    if (Response['payload'] != null) {
      presentlist.value = Response["payload"]['present'];
    }
  }

  void upload(GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      final res = await http.post(
          Uri.parse(
            "http://10.0.2.2:9000/api/v1/attendance/upload/${today}/${school}",
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
