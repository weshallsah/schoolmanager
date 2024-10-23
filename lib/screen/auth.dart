import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/controller/Admission.controller.dart';
import 'package:schoolmanager/controller/Recurit.controller.dart';
import 'package:schoolmanager/controller/auth.controller.dart';
import 'package:schoolmanager/main.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/home.dart';
import 'package:schoolmanager/screen/progress.dart';
import 'package:schoolmanager/service/auth.service.dart';

class Authscreen extends StatelessWidget {
  Authscreen({super.key});
  AuthController authController = Get.put(AuthController());
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => authController.issignup.value
                  ? SchoolRegister(authController)
                  : Teacher(authController)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    print(authController.issignup.value);
                    authController.issignup.value =
                        !authController.issignup.value;
                    print(authController.issignup.value);
                  },
                  child: Obx(() => authController.issignup.value
                      ? Text("Alredy have account Login")
                      : Text("Register Principal")),
                ),
              ),
              Obx(
                () => SizedBox(
                  height: authController.issignup.value ? 10.h : 50.h,
                ),
              ),
              GetBuilder<AuthController>(builder: (contrller) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      if (!contrller.isloading.value) {
                        if (contrller.issignup.value) {
                          if (contrller.isnext.value) {
                            contrller.signup(_globalKey);
                            return;
                          }
                          contrller.gonext(_globalKey);
                          return;
                        }
                        contrller.submit(_globalKey);
                      }
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
                      child: contrller.isloading.value
                          ? CircularProgressIndicator()
                          : Text(
                              contrller.issignup.value
                                  ? contrller.isnext.value
                                      ? "Signup"
                                      : "Next"
                                  : "Login",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchoolRegister extends StatelessWidget {
  AuthController authController;
  SchoolRegister(this.authController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
        ),
        Obx(
          () => Text(
            authController.isnext.value
                ? "Principal Information"
                : "School Information",
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Obx(
          () => authController.isnext.value
              ? Principal(authController)
              : SchoolInfo(authController),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}

class Principal extends StatelessWidget {
  AuthController authController;
  Principal(this.authController, {super.key});
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              authController.isnext.value = false;
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              height: 30.h,
              width: 70.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(
                "Prev",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: authController.pickimage,
          child: Obx(
            () => Container(
              height: 120.h,
              width: 120.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(60.w),
                image: DecorationImage(
                  image: authController.isimage.value
                      ? FileImage(
                          File(authController.image.value) as File,
                        )
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
        ListView.builder(
          shrinkWrap: true,
          itemCount: authController.teachertitle.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (!authController.ispset.value) {
              authController.formfiled.value.add(TextEditingController());
            }
            if (authController.teachertitle.length - 1 == index) {
              authController.ispset.value = true;
            }
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 5.h,
              ),
              child: inputBox(authController.teachertitle[index],
                  authController.formfiled[index], false,
                  isnumber: index == 5),
            );
          },
        ),
        SizedBox(
          height: 15.h,
        ),
        genderBox("Gender", Admissioncontroller(), Recruitcontroller(),
            authController, ["Male", "Female", "Other"], true),
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
              GetBuilder<AuthController>(
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
                          DateFormat('yyyy-MM-dd').format(controller.Dob.value),
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
      ],
    );
  }
}

class SchoolInfo extends StatelessWidget {
  AuthController authController;
  SchoolInfo(this.authController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 5.h,
          ),
          child: GetBuilder<AuthController>(builder: (controller) {
            return Obx(
              () => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: authController.fieldname.length,
                itemBuilder: (context, index) {
                  if (!authController.isset.value) {
                    authController.forminput.add(TextEditingController());
                  }
                  if (index == authController.fieldname.length - 1) {
                    authController.isset.value = true;
                  }
                  return inputBox(
                    authController.fieldname[index],
                    authController.forminput[index],
                    false,
                    isnumber: index == 9 || index == 10 || index == 13,
                  );
                },
              ),
            );
          }),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          width: 305.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Establish At ",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GetBuilder<AuthController>(
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
                        controller.establish.value = date;
                        authController.reactive;
                        controller.establish.refresh();
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
                              .format(controller.establish.value),
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
      ],
    );
  }
}

class Teacher extends StatelessWidget {
  AuthController authController;
  Teacher(this.authController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 50.h,
        ),
        GetBuilder<AuthController>(builder: (contrller) {
          return inputBox("Email", contrller.email, false);
        }),
        GetBuilder<AuthController>(builder: (contrller) {
          return inputBox("password", contrller.password, true);
        }),
      ],
    );
  }
}

class inputBox extends StatefulWidget {
  String inputname;
  TextEditingController inputcontroller;
  bool ispassword;
  bool isnumber;
  bool isdate;
  inputBox(this.inputname, this.inputcontroller, this.ispassword,
      {this.isnumber = false, this.isdate = false, super.key});

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
              keyboardType: widget.isnumber
                  ? TextInputType.number
                  : widget.isdate
                      ? TextInputType.datetime
                      : null,
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
