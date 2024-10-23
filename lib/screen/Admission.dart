import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/controller/Admission.controller.dart';
import 'package:schoolmanager/controller/Recurit.controller.dart';
import 'package:schoolmanager/controller/auth.controller.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/screen/auth.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/screen/progress.dart';
import 'package:schoolmanager/utils/constant.dart';

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
                          ? FileImage(
                              File(admissioncontroller.image.value) as File)
                          : AssetImage(
                              './assets/user.png',
                            ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 35.w,
              ),
              // width: double.infinity,
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: admissioncontroller.studenttitle.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (!admissioncontroller.isset.value) {
                      admissioncontroller.formfiled[index] =
                          TextEditingController();
                    }
                    if (index == admissioncontroller.studenttitle.length - 1) {
                      admissioncontroller.isset.value = true;
                    }
                    // print(
                    //     index == 4 || index == 8 || index == 12 || index == 13);
                    return inputBox(
                      admissioncontroller.studenttitle[index],
                      admissioncontroller.formfiled[index],
                      false,
                      isnumber: index == 4 || index == 9,
                    );
                  },
                ),
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
                  GetBuilder<Admissioncontroller>(builder: (controller) {
                    return Container(
                      // width: 60.w,
                      margin: EdgeInsets.only(right: 20.w),
                      alignment: Alignment.center,
                      child: droplist(controller, true, controller.items),
                    );
                  })
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 305.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Nationality :",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GetBuilder<Admissioncontroller>(builder: (controller) {
                    return Container(
                      // width: 60.w,
                      margin: EdgeInsets.only(right: 20.w),
                      alignment: Alignment.center,
                      child: droplist(
                        controller,
                        true,
                        countries,
                        type: 1,
                      ),
                    );
                  })
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 305.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Religion :",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GetBuilder<Admissioncontroller>(builder: (controller) {
                    return Container(
                      // width: 60.w,
                      margin: EdgeInsets.only(right: 20.w),
                      alignment: Alignment.center,
                      child: droplist(
                        controller,
                        true,
                        controller.Religion,
                        type: 2,
                      ),
                    );
                  })
                ],
              ),
            ),
            Container(
              width: 305.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Division :",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GetBuilder<Admissioncontroller>(builder: (controller) {
                    return Container(
                      // width: 60.w,
                      margin: EdgeInsets.only(right: 20.w),
                      alignment: Alignment.center,
                      child: droplist(
                        controller,
                        true,
                        controller.devision,
                        type: 3,
                      ),
                    );
                  })
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 305.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Caste :",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GetBuilder<Admissioncontroller>(builder: (controller) {
                    return Container(
                      // width: 60.w,
                      margin: EdgeInsets.only(right: 20.w),
                      alignment: Alignment.center,
                      child: droplist(
                        controller,
                        true,
                        controller.caste,
                        type: 4,
                      ),
                    );
                  })
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            genderBox("Gender", admissioncontroller, Recruitcontroller(),
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
                  GetBuilder<Admissioncontroller>(
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
                            admissioncontroller.reactive;
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
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
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
