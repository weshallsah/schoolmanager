import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';

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
  @override
  void onInit() async {
    super.onInit();
    UserModel user = await AuthService.getuser();
    isadmin.value = user.isadmin;
    print(isadmin.value);
    selecteddate.value =
        ((dateTime.year * 100) + dateTime.month) * 100 + dateTime.day;
    today.value = ((dateTime.year * 100) + dateTime.month) * 100 + dateTime.day;
  }
}
