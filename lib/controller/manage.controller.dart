import 'dart:convert';

import 'package:get/get.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/utils/constant.dart';

class ManageController extends GetxController {
  RxList list = [].obs;
  String school = "";
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    UserModel userModel = await AuthService.getuser();
    school = userModel.school;
    if (school == "") {
      return;
    }
    final res = await http
        .get(Uri.parse("http://${localhost}/api/v1/teacher/list/${school}"));
    print(res);
    final response = jsonDecode(res.body);
    print(response);
    for (var teacher in response['payload']) {
      list.add(teacher);
    }
  }
}
