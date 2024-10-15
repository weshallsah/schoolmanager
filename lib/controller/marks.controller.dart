import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';

class Markcontroller extends GetxController {
  RxInt isupload = 0.obs;
  RxList subjects = [].obs;
  RxList students = [].obs;
  List formcontroller = [];
  String school = "";

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    UserModel user = await AuthService.getuser();
    school = user.school;
    // print(isadmin.value);
    var res = await http
        .get(Uri.parse("http://10.0.2.2:9000/api/v1/student/list/${school}"));
    var response = jsonDecode(res.body);
    print(response);
    students.value = response['payload'];


    print("subjectsss gettttingggggg");
    res = await http.get(
      Uri.parse("http://10.0.2.2:9000/api/v1/subjects/list/1"),
    );
    response = jsonDecode(res.body);
    print(response);
    if (response['payload'] != null) {
      subjects.value = response['payload']['subjects'];
    }
    for (int i = 0; i < subjects.length; i++) {
      formcontroller.add(TextEditingController());
    }
  }
  void upload()async{
    
  }
}
