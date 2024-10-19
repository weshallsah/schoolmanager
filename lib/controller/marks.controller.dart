import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class Markcontroller extends GetxController {
  RxInt isupload = 0.obs;
  RxList subjects = [].obs;
  RxList students = [].obs;
  RxMap uploaded = {}.obs;
  List formcontroller = [];
  String school = "";
  String id = "";
  RxInt tream = 1.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    UserModel user = await AuthService.getuser();
    school = user.school;
    id = user.id;
    var res = await http.get(Uri.parse(
      "http://${localhost}/api/v1/student/list/${school}/${user.std}",
    ));
    // print(res.body);
    var response = jsonDecode(res.body);
    // print(response);
    students.value = response['payload'];
    students.value.reactive;
    for (var st in students) {
      uploaded[st['_id']] = false;
    }
    res = await http.get(Uri.parse(
      "http://${localhost}/api/v1/marks/getmark/${tream.value}/${user.std}/${user.id}",
    ));
    // print(res.body);
    response = jsonDecode(res.body);
    print(response);
    for (var st in response['payload']) {
      if (st['tream'] == tream.value) {
        uploaded[st['student']] = true;
      }
    }
    uploaded.value.reactive;
    res = await http.get(
      Uri.parse("http://${localhost}/api/v1/subjects/list/1"),
    );
    response = jsonDecode(res.body);
    // print(response);
    if (response['payload'] != null) {
      subjects.value = response['payload']['subjects'];
    }
    subjects.value.reactive;
    for (int i = 0; i < subjects.length; i++) {
      formcontroller.add(TextEditingController());
    }
    refresh();
  }

  void upload(int index, GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      List marks = [];
      for (int i = 0; i < subjects.length; i++) {
        if (formcontroller[i].text.isEmpty) {
          showtoast(_scaffoldKey, "please enter mark of ${subjects[i]}", true);
          return;
        }
        marks.add(formcontroller[i].text);
      }
      final res = await http
          .post(Uri.parse("http://${localhost}/api/v1/marks/upload"), body: {
        "student": students[index]['_id'],
        "teacher": id,
        "tream": tream.value.toString(),
        "standard": "1",
        "subject": jsonEncode(subjects),
        "marks": jsonEncode(marks),
      });
      final response = jsonDecode(res.body);
      print(response['status']);
      if (response['status'] == 200) {
        showtoast(_scaffoldKey, "Marks uploaded!", false);
      }
      if (response['status'] == 400) {
        showtoast(_scaffoldKey, "Alredy existed", true);
      }
      uploaded[students[index]['_id']] = true;
      for (int i = 0; i < subjects.length; i++) {
        formcontroller[i].clear();
      }
      isupload.value = 0;
    } catch (e) {
      showtoast(_scaffoldKey, "Someting went wrong", true);
    }
  }
}
