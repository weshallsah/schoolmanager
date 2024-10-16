import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class Admissioncontroller extends GetxController {
  RxList<String> studenttitle = [
    "Name",
    "Father Name",
    "Mother Name",
    "Enroll",
    "Phone",
    "Nationality",
    "Mother Toungue",
    "Place of Birth",
    "Aadhar number",
    "Address"
  ].obs;
  RxInt gender = 0.obs;
  RxString school = "".obs;
  RxBool isstudent = true.obs;
  RxBool isimage = false.obs;
  var image;

  List<TextEditingController> formfiled =
      List.filled(12, TextEditingController());
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    UserModel userModel = await AuthService.getuser();
    for (int i = 0; i < 12; i++) {
      formfiled[i] = TextEditingController();
    }
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

  void uploadstudent(GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      var request = await http.MultipartRequest(
        'Post',
        Uri.parse("http://${localhost}/api/v1/student/admission"),
      );
      request.fields['name'] = formfiled[0].value.text;
      request.fields['fathername'] = formfiled[1].value.text;
      request.fields['mothername'] = formfiled[2].value.text;
      request.fields['enroll'] = formfiled[3].value.text;
      request.fields['phone'] = formfiled[4].value.text;
      request.fields['nationality'] = formfiled[5].value.text;
      request.fields['mothertoungue'] = formfiled[6].value.text;
      request.fields['placeofbrith'] = formfiled[7].value.text;
      request.fields['aadhar'] = formfiled[8].value.text;
      request.fields['address'] = formfiled[9].value.text;
      request.fields['dob'] = formfiled[11].value.text;
      request.fields['Standard'] = formfiled[10].value.text;
      request.fields['gender'] = gender.value.toString();
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
      for (int i = 0; i < 11; i++) {
        formfiled[i].clear();
      }
    } catch (e) {
      showtoast(_scaffoldKey, "somthing went wrong", true);
    }
  }
}
