import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/service/auth.service.dart';
import 'package:schoolmanager/utils/constant.dart';
import 'package:schoolmanager/utils/snakbar.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController enroll = TextEditingController();
  RxList fieldname = [
    "School",
    "Address",
    "Affiliated",
    "Center",
    "Taluka",
    "District",
    "E-mail",
    "Medium",
    "State",
    "Contact",
    "Affiliation No",
    "U Dise Code",
    "School Code",
    "Gr No",
  ].obs;
  RxList teachertitle = [
    "name",
    "teacher id",
    "fathername",
    "password",
    "mothername",
    "phone",
    "email",
    "address"
  ].obs;
  RxList formfiled = [].obs;
  Rx<DateTime> Dob = DateTime.now().obs;
  RxBool isset = false.obs;
  RxBool ispset = false.obs;
  RxInt gender = 0.obs;
  // establish
  RxBool isloading = false.obs;
  RxList forminput = [].obs;
  RxBool issignup = false.obs;
  Rx<DateTime> establish = DateTime.now().obs;
  RxBool isimage = false.obs;
  RxString image = "".obs;
  RxBool isnext = false.obs;

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

  void gonext(GlobalKey<ScaffoldState> _scaffoldkey) async {
    bool ismy = false;
    try {
      FocusScope.of(_scaffoldkey.currentContext as BuildContext).unfocus();
      isloading.value = true;
      for (int i = 0; i < forminput.length; i++) {
        if (forminput[i].value.text.isEmpty) {
          ismy = true;
          print(forminput[i].text);
          print(fieldname[i]);
          throw "please fill all the fields";
        }
      }
      if (!forminput[6].text.toString().isEmail) {
        // print(formfiled[6].value.text);
        ismy = true;
        throw "please enter email";
      }
      String phone = forminput[9].value.text;
      if ((phone[0] != '9' && phone[0] != '7' && phone[0] != '8') ||
          phone.length != 10) {
        ismy = true;
        throw "please enter valid phone number";
      }
      isnext.value = true;
    } catch (e) {
      print(e);
      showtoast(
          _scaffoldkey, ismy ? e.toString() : "something went wrong", true);
    }
    isloading.value = false;
  }

  void submit(GlobalKey<ScaffoldState> _scaffoldkey) async {
    try {
      FocusScope.of(_scaffoldkey.currentContext as BuildContext).unfocus();
      isloading.value = true;
      print("submitinggggg");
      if (password.text.isEmpty) {
        throw "please enter password";
      }
      if (!email.text.isEmail || email.text.isEmpty) {
        throw "Email is invalid";
      }
      // print("false");
      final res = await http.post(
          Uri.parse('http://${localhost}/api/v1/teacher/login'),
          body: {"email": email.text, "password": password.text});
      print(res.body);
      final response = jsonDecode(res.body);
      print(response);
      if (response['status'] == 200) {
        showtoast(_scaffoldkey, "Login successful", false);
        await AuthService.setlogin(
            UserModel.fromJson(response['payload'], true));
        email.clear();
        password.clear();
        Get.offAll(() => Homescreen());
        isloading.value = false;
        return;
      }
      if (response['status'] != 500) {
        showtoast(_scaffoldkey, response['message'], true);
      } else {
        throw "Something went worng";
      }
    } catch (e) {
      print(e);
      showtoast(_scaffoldkey, e.toString(), true);
    }
    isloading.value = false;
  }

  void signup(GlobalKey<ScaffoldState> _scaffoldkey) async {
    bool ismy = false;
    try {
      List uploadfields = [
        "school",
        "address",
        "Affiliated",
        "center",
        "Taluka",
        "district",
        "mail",
        "Medium",
        "state",
        "contact",
        "AffiliationNo",
        "UDiseCode",
        "SchoolCode",
        "grno",
      ];
      FocusScope.of(_scaffoldkey.currentContext as BuildContext).unfocus();
      isloading.value = true;

      var request = await http.MultipartRequest(
        'Post',
        Uri.parse("http://${localhost}/api/v1/teacher/register"),
      );
      if (image == null) {
        ismy = true;
        throw "please Select Photo";
      }
      for (int i = 0; i < uploadfields.length; i++) {
        if (forminput[i].value.text.isEmpty) {
          ismy = true;
          throw "please fill all the fields";
        }
      }
      for (int i = 0; i < uploadfields.length; i++) {
        request.fields[uploadfields[i]] = forminput[i].value.text;
      }
      request.fields['establish'] = jsonEncode(establish.value.toString());
      if (formfiled[0].value.text.isEmpty) {
        ismy = true;
        throw "please enter name";
      }
      request.fields['name'] = formfiled[0].value.text;
      if (formfiled[1].value.text.isEmpty) {
        ismy = true;
        throw "please give teacher id";
      }
      request.fields['enroll'] = formfiled[1].value.text;
      request.fields['fathername'] = formfiled[2].value.text;
      if (formfiled[3].value.text.isEmpty) {
        ismy = true;
        throw "please enter password";
      }
      request.fields['password'] = formfiled[3].value.text;
      request.fields['mothername'] = formfiled[4].value.text;
      String phone = formfiled[5].value.text;
      if ((phone[0] != '9' && phone[0] != '7' && phone[0] != '8') ||
          phone.length != 10) {
        ismy = true;
        throw "please enter valid phone number";
      }
      request.fields['phone'] = phone;
      if (!formfiled[6].text.toString().isEmail) {
        // print(formfiled[6].value.text);
        ismy = true;
        throw "please enter email";
      }
      request.fields['email'] = formfiled[6].value.text;
      request.fields['paddress'] = formfiled[7].value.text;
      // request.fields['Standard'] = ;
      request.fields['dob'] = jsonEncode(Dob.value.toString());
      request.fields['gender'] = gender.value.toString();
      request.fields['isadmin'] = "true";
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
        payload = jsonDecode(res.body)['payload'];
      });
      print("payload := ${payload}");
      if (status == 200) {
        // for (int i = 0; i < forminput.length; i++) {
        //   forminput[i].clear();
        // }
        isimage.value = false;
        establish.value = DateTime.now();
        showtoast(_scaffoldkey, "School Register successfully", false);
        await AuthService.setlogin(UserModel.fromJson(payload, true));
        for (int i = 0; i < teachertitle.length; i++) {
          formfiled[i].clear();
        }
        for (int i = 0; i < forminput.length; i++) {
          forminput[i].clear();
        }
        isimage.value = false;
        establish.value = DateTime.now();
        Dob.value = DateTime.now();
        Get.offAll(() => Homescreen());
        isloading.value = false;
        return;
      }
      if (status == 400) {
        showtoast(_scaffoldkey, "School alredy exist", true);
      }
    } catch (e) {
      print(e);
      showtoast(
          _scaffoldkey, ismy ? e.toString() : "something went wrong", true);
    }
    isloading.value = false;
  }
}
