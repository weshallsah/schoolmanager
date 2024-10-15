import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/auth.controller.dart';
import 'package:schoolmanager/main.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/service/auth.service.dart';

class Authscreen extends StatelessWidget {
  Authscreen({super.key});
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 92.h,
              ),
              Container(
                width: 245.w,
                alignment: Alignment.center,
                child: Image.asset("./assets/school.png"),
              ),
              SizedBox(
                height: 30.h,
              ),
              GetBuilder<AuthController>(builder: (contrller) {
                return inputBox("School name", contrller.school, false);
              }),
              SizedBox(
                height: 20.h,
              ),
              GetBuilder<AuthController>(builder: (contrller) {
                return inputBox("Email", contrller.email, false);
              }),
              SizedBox(
                height: 20.h,
              ),
              GetBuilder<AuthController>(builder: (contrller) {
                return inputBox("password", contrller.password, true);
              }),
              SizedBox(
                height: 60.h,
              ),
              GetBuilder<AuthController>(builder: (contrller) {
                return InkWell(
                  onTap: contrller.submit,
                  child: Container(
                    height: 56.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.w),
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class inputBox extends StatefulWidget {
  String inputname;
  TextEditingController inputcontroller;
  bool ispassword;
  inputBox(this.inputname, this.inputcontroller, this.ispassword, {super.key});

  @override
  State<inputBox> createState() => _inputBoxState();
}

class _inputBoxState extends State<inputBox> {
  bool isshow = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.inputname,
            style: TextStyle(fontSize: 16.sp),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
            ),
            child: TextFormField(
              obscureText: isshow & widget.ispassword,
              controller: widget.inputcontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: widget.inputname == "Date of Birth"
                    ? "YYYY-MM-DD"
                    : widget.inputname,
                suffixIcon: widget.ispassword
                    ? IconButton(
                        onPressed: () {
                          isshow = !isshow;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          !isshow
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
