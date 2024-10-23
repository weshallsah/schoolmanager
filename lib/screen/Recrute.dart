import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/controller/Admission.controller.dart';
import 'package:schoolmanager/controller/Recurit.controller.dart';
import 'package:schoolmanager/controller/auth.controller.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/screen/auth.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/screen/progress.dart';

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
                          ? FileImage(File(recruitcontroller.image.value) as File)
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
                  recruitcontroller.formfiled.value
                      .add(TextEditingController());
                  return inputBox(recruitcontroller.teachertitle[index],
                      recruitcontroller.formfiled[index], false,
                      isnumber: index == 5);
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
                  GetBuilder<Recruitcontroller>(builder: (controller) {
                    return Container(
                      child: droplist(controller, true, controller.items),
                    );
                  })
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            genderBox("Admin", Admissioncontroller(), recruitcontroller,
                AuthController(), ["Yes", "No"], false),
            SizedBox(
              height: 15.h,
            ),
            genderBox("Gender", Admissioncontroller(), recruitcontroller,
                AuthController(), ["Male", "Female", "Other"], true),
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: 305.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Date of Birth :",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GetBuilder<Recruitcontroller>(
                    builder: (controller) {
                      return InkWell(
                        onTap: () async {
                          final date = (await showDatePicker(
                            context: context,
                            // currentDate: ,
                            currentDate: DateTime.now(),
                            firstDate: DateTime.utc(1900, 1, 1),
                            lastDate: DateTime.now(),
                            onDatePickerModeChange: (value) {
                              print(value);
                            },
                          ));
                          if (date != null) {
                            // controller.isdate.value = !controller.isdate.value;
                            controller.Dob.value = date;
                            controller.reactive;
                            controller.Dob.refresh();
                          }
                          print(date);
                        },
                        child: Obx(
                          () => Container(
                            // width: 60.w,
                            margin: EdgeInsets.only(right: 20.w),
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(controller.Dob.value),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
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
