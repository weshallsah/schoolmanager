import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

// 5 9 13 14

class Admissioncontroller extends GetxController {
  RxList<String> studenttitle = [
    "Name",
    "Father Name",
    "Mother Name",
    "Enroll",
    "Phone",
    "Mother Toungue",
    "Place of Birth",
    "Aadhar number",
    "Address",
    "serial",
  ].obs;
  var items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
  ].obs;
  // var Nationality = [];
  var Religion = ['Hindu', 'Muslim', 'Christian'];
  var caste = ['SC', 'ST', 'OBC', 'General'];
  RxString selecteditem = '1'.obs;
  RxString selectedcaste = 'General'.obs;
  RxString selectednationality = 'Indian'.obs;
  RxString selectedreligion = 'Hindu'.obs;
  RxInt gender = 0.obs;
  var devision = ['A', 'B', 'C', 'D'];
  RxString selectedDivision = 'A'.obs;
  RxString school = "".obs;
  RxBool isdate = false.obs;
  RxBool isstudent = true.obs;
  RxBool isimage = false.obs;
  RxBool isset = false.obs;
  RxString image = "".obs;
  Rx<TextEditingController> standard = TextEditingController().obs;
  Rx<DateTime> Dob = DateTime.now().obs;
  RxList formfiled = List.filled(16, TextEditingController()).obs;

  @override
  void onInit() async {
    super.onInit();
    UserModel userModel = await AuthService.getuser();
    print(studenttitle.length);
    school.value = userModel.school;
    Dob.value = DateTime.now();
  }

  void pickimage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? file =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        image.value = file.path;
        isimage.value = true;
      }
      print(isimage);
      print(image);
    } catch (e) {
      print("erroe : ${e}");
    }
  }

  void uploadstudent(GlobalKey<ScaffoldState> _scaffoldKey) async {
    bool ismy = false;
    try {
      var request = await http.MultipartRequest(
        'Post',
        Uri.parse("http://${localhost}/api/v1/student/admission"),
      );
      for (int i = 0; i < studenttitle.length; i++) {
        if (formfiled[i].value.text.isEmpty) {
          ismy = true;
          throw "please fill all the fields";
        }
      }
      request.fields['name'] = formfiled[0].value.text;
      request.fields['fathername'] = formfiled[1].value.text;
      request.fields['mothername'] = formfiled[2].value.text;
      request.fields['enroll'] = formfiled[3].value.text;
      String phone = formfiled[4].value.text;
      // print(phone.length);
      if ((phone[0] != '9' && phone[0] != '7' && phone[0] != '8') ||
          phone.length != 10) {
        ismy = true;
        throw "please enter valid phone number";
      }
      request.fields['phone'] = phone;
      request.fields['mothertoungue'] = formfiled[5].value.text;
      request.fields['placeofbrith'] = formfiled[6].value.text;
      request.fields['aadhar'] = formfiled[7].value.text;
      request.fields['address'] = formfiled[8].value.text;
      for (int i = 9; i < studenttitle.length; i++) {
        request.fields[studenttitle[i]] = formfiled[i].value.text;
      }
      request.fields['nationality'] = selectednationality.value;
      request.fields['religion'] = selectedreligion.value;
      request.fields['caste'] = selectedcaste.value;
      request.fields['dob'] = jsonEncode(Dob.value.toString());
      print(selecteditem.value);
      request.fields['standard'] = selecteditem.value;
      request.fields['gender'] = gender.value.toString();
      request.fields['school'] = school.value;
      request.fields['division'] = selectedDivision.value;
      if (image == "") {
        ismy = true;
        throw "please upload image of student";
      }
      if (image != "") {
        http.MultipartFile file = await http.MultipartFile.fromPath(
          'avatar',
          image.value,
        );
        request.files.add(file);
      }

      var payload;
      var status;
      await request.send().then((streamres) async {
        print(streamres);
        final res = await http.Response.fromStream(streamres);
        status = res.statusCode;
        payload = jsonDecode(res.body);
      });
      print("payload := ${payload}");
      if (status == 200) {
        showtoast(_scaffoldKey, "student added successfully", false);
      }
      if (status == 400) {
        showtoast(_scaffoldKey, "student alredy exist", true);
      }
      for (int i = 0; i < 16; i++) {
        formfiled[i].clear();
      }
      isimage.value = false;
      standard.value.clear();
      Dob.value = DateTime.now();
      // Dob.value.clear();
    } catch (e) {
      print(ismy);
      print(e);
      showtoast(
          _scaffoldKey, ismy ? e.toString() : "somthing went wrong", true);
    }
  }
}
