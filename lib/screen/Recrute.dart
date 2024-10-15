import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:schoolmanager/controller/Admission.controller.dart';
import 'package:schoolmanager/controller/Recurit.controller.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/screen/auth.dart';
import 'package:schoolmanager/screen/home.dart';

class TeacherForm extends StatelessWidget {
  TeacherForm({super.key});
  Recruitcontroller recruitcontroller = Get.put(Recruitcontroller());
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Recruit Teacher"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: recruitcontroller.pickimage,
              child: Obx(
                () => Container(
                  height: 120.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(60.w),
                    image: DecorationImage(
                      image: recruitcontroller.isimage.value
                          ? FileImage(recruitcontroller.image as File)
                          : AssetImage(
                              './assets/user.png',
                            ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 650.h,
              padding: EdgeInsets.symmetric(
                horizontal: 35.w,
              ),
              // width: double.infinity,
              child: ListView.builder(
                itemCount: recruitcontroller.teachertitle.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return inputBox(recruitcontroller.teachertitle[index],
                      recruitcontroller.formfiled[index], false);
                },
              ),
            ),
            Container(
              width: 305.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Standard :",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 60.w,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: recruitcontroller.formfiled[9],
                      decoration: InputDecoration(
                          labelText: "STD",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(
            //   height: 15.h,
            // ),
            genderBox("Admin", Admissioncontroller(), recruitcontroller,
                ["Yes", "No"], false),
            SizedBox(
              height: 15.h,
            ),
            genderBox("Gender", Admissioncontroller(), recruitcontroller,
                ["Male", "Female", "Other"], true),
            SizedBox(
              height: 15.h,
            ),
            inputBox(
              "Date of Birth",
              recruitcontroller.formfiled[10],
              false,
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                recruitcontroller.uploadteacher(_scaffoldKey);
              },
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
                  "upload",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
