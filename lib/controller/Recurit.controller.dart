import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class Recruitcontroller extends GetxController {
  RxList teachertitle = [
    "name",
    "enroll",
    "fathername",
    "password",
    "mothername",
    "phone",
    "email",
    "address"
  ].obs;
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
  RxInt gender = 0.obs;
  RxString school = "".obs;
  RxInt isnewadmin = 0.obs;
  RxBool isimage = false.obs;
  RxBool isadmission = false.obs;
  var image;
  RxList formfiled = [].obs;
  TextEditingController standard = TextEditingController();
  TextEditingController DoB = TextEditingController();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    UserModel userModel = await AuthService.getuser();
    school.value = userModel.school;
  }

  void pickimage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? file =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        image = File(file.path);
        isimage.value = true;
      }
      print(isimage);
      print(image);
    } catch (e) {
      print("erroe : ${e}");
    }
  }

  void uploadteacher(GlobalKey<ScaffoldState> _scaffoldKey) async {
    bool ismy = false;
    try {
      var request = await http.MultipartRequest(
        'Post',
        Uri.parse("http://10.0.2.2:9000/api/v1/teacher/hire"),
      );
      if (formfiled[0].value.text.isEmpty) {
        ismy = true;
        throw "please enter name";
      }
      request.fields['name'] = formfiled[0].value.text;
      if (formfiled[1].value.text.isEmpty) {
        ismy = true;
        throw "please give enrollment number";
      }
      request.fields['enroll'] = formfiled[1].value.text;
      request.fields['fathername'] = formfiled[2].value.text;
      if (formfiled[3].value.text.isEmpty) {
        ismy = true;
        throw "please enter password";
      }
      request.fields['password'] = formfiled[3].value.text;
      request.fields['mothername'] = formfiled[4].value.text;
      request.fields['phone'] = formfiled[5].value.text;
      if (!formfiled[6].text.toString().isEmail) {
        // print(formfiled[6].value.text);
        ismy = true;
        throw "please enter email";
      }
      request.fields['email'] = formfiled[6].value.text;
      request.fields['address'] = formfiled[7].value.text;
      request.fields['Standard'] = standard.text.isEmpty ? "" : standard.text;
      request.fields['dob'] = DoB.text;
      request.fields['gender'] = gender.value.toString();
      request.fields['isadmin'] = isnewadmin.value == 0 ? "true" : "false";
      request.fields['school'] = school.value;
      print(image?.path);
      if (image?.path != null) {
        http.MultipartFile file = await http.MultipartFile.fromPath(
          'avatar',
          image!.path,
        );
        request.files.add(file);
      }

      var payload;
      var status;
      await request.send().then((streamres) async {
        print(streamres);
        final res = await http.Response.fromStream(streamres);
        payload = jsonDecode(res.body);
        print(payload);
        status = res.statusCode;
      });
      print("payload := ${payload}");
      if (status == 200) {
        showtoast(_scaffoldKey, "Teaacher added successfully", false);
      }
      if (status == 400) {
        // showtoast(_scaffoldKey, "Teacher alredy exist", true);
        ismy = true;
        throw "Teacher alredy exist";
        // return;
      }
      for (int i = 0; i < teachertitle.length; i++) {
        formfiled[i].clear();
      }
      standard.clear();
      DoB.clear();
      isadmission.value = false;
      isimage.value = false;
      image = null;
    } catch (e) {
      print(e);
      showtoast(
          _scaffoldKey, ismy ? e.toString() : "something went wrong", true);
      // ismy=f
    }
  }
}
