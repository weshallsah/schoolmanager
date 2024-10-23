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
  RxList subjects = ["English", "Hindi", "Marathi", "Science", "Maths"].obs;
  RxList students = [].obs;
  RxMap uploaded = {}.obs;
  RxMap fail = {}.obs;
  List formcontroller = [];
  String school = "";
  String id = "";
  RxInt tream = 1.obs;
  RxBool Regular = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    try {
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
        fail[st['_id']] = false;
      }
      res = await http.get(Uri.parse(
        "http://${localhost}/api/v1/marks/getmark/${tream.value}/${user.std}/${user.id}",
      ));
      // print(res.body);
      response = jsonDecode(res.body);
      print(response);
      for (var st in response['payload']) {
        if (st['tream'] == tream.value) {
          double mark = 0;
          uploaded[st['student']] = true;
          for (var m in st['marks']) {
            mark += m;
          }
          mark = ((mark / (st['marks'].length * 100)) * 100);
          print(mark);
          fail[st['student']] = mark < 35;
        }
      }
      uploaded.value.reactive;
      subjects.value.reactive;
      for (int i = 0; i < subjects.length; i++) {
        formcontroller.add(TextEditingController());
      }
      refresh();
    } catch (e) {
      print(e);
    }
  }

  void upload(int index, GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      UserModel user = await AuthService.getuser();
      school = user.school;
      id = user.id;
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
        "standard": "${user.std}",
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
      fail[students[index]['_id']] = false;
      for (int i = 0; i < subjects.length; i++) {
        formcontroller[i].clear();
      }
      isupload.value = 0;
    } catch (e) {
      print(e);
      showtoast(_scaffoldKey, "Someting went wrong", true);
    }
  }
}
