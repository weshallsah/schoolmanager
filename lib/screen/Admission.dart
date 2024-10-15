import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/Admission.controller.dart';
import 'package:schoolmanager/controller/Recurit.controller.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/screen/auth.dart';
import 'package:schoolmanager/screen/home.dart';

class StudentForm extends StatelessWidget {
  StudentForm({super.key});
  Admissioncontroller admissioncontroller = Get.put(Admissioncontroller());
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Admission"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: admissioncontroller.pickimage,
              child: Obx(
                () => Container(
                  height: 120.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(60.w),
                    image: DecorationImage(
                      image: admissioncontroller.isimage.value
                          ? FileImage(admissioncontroller.image as File)
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
              height: 810.h,
              padding: EdgeInsets.symmetric(
                horizontal: 35.w,
              ),
              // width: double.infinity,
              child: ListView.builder(
                itemCount: admissioncontroller.studenttitle.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print(admissioncontroller.studenttitle[index]);
                  return inputBox(admissioncontroller.studenttitle[index],
                      admissioncontroller.formfiled[index], false);
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
                      controller: admissioncontroller.formfiled[10],
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
            SizedBox(
              height: 10.h,
            ),
            genderBox("Gender", admissioncontroller, Recruitcontroller(),
                ["Male", "Female", "Other"], true),
            SizedBox(
              height: 15.h,
            ),
            inputBox(
              "Date of Birth",
              admissioncontroller.formfiled[11],
              false,
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                admissioncontroller.uploadstudent(_scaffoldKey);
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
            )
          ],
        ),
      ),
    );
  }
}
