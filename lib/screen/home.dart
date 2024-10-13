import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/screen/auth.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Manager"),
        backgroundColor: Color.fromARGB(255, 236, 190, 190),
        toolbarHeight: 80.h,
        actions: [
          GetBuilder<HomeController>(
            builder: (controller) => IconButton(
              onPressed: controller.logout,
              icon: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 190, 190),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.w,
                    vertical: 15.h,
                  ),
                  child: Greet(homeController),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Obx(
                  () => homeController.isadmin.value
                      ? principal(homeController)
                      : Teacher(homeController),
                )
              ],
            ),
          ),
          Obx(
            () => homeController.isadmission.value
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              // color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r),
                              ),
                              border: Border(
                                bottom: BorderSide(),
                              ),
                            ),
                            child: Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      homeController.isstudent.value = true;
                                    },
                                    child: Container(
                                      child: Text(
                                        "Student",
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold,
                                          color: homeController.isstudent.value
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      homeController.isstudent.value = false;
                                    },
                                    child: Container(
                                      child: Text(
                                        "Teacher",
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold,
                                          color: !homeController.isstudent.value
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(
                            () => homeController.isstudent.value
                                ? StudentForm(homeController, _scaffoldKey)
                                : TeacherForm(homeController,_scaffoldKey),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
      floatingActionButton: Obx(() =>
          homeController.isadmin.value && !homeController.isadmission.value
              ? FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    homeController.isadmission.value = true;
                  },
                  child: Icon(Icons.add),
                )
              : Container()),
    );
  }
}

class principal extends StatelessWidget {
  HomeController homeController;
  principal(this.homeController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<HomeController>(builder: (controller) {
        return ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  controller.clicked(index);
                },
                child: ActionButton(controller.name[index]));
          },
        );
      }),
    );
  }
}

class Teacher extends StatelessWidget {
  HomeController homeController;
  Teacher(this.homeController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionButton("attendance"),
        ActionButton("marks"),
      ],
    );
  }
}

class Greet extends StatelessWidget {
  HomeController homeController;
  Greet(this.homeController, {super.key});

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    int num = int.parse(DateFormat.H().format(time));
    if (num >= 4 && num < 12) {
      homeController.greet.value = "Good Morning!";
    } else if (num >= 12 && num <= 17) {
      homeController.greet.value = "Good Afternoon!";
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    homeController.greet.value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    homeController.username.value,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    homeController.school.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.h),
                  color: Colors.amber,
                  border: Border.all()),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today is",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(
                  () => Text(
                    "${DateFormat('EEEE').format(homeController.date.value)}!",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "date",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(
                  () => Text(
                    "${DateFormat.yMd().format(homeController.date.value)}",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  String str;
  ActionButton(this.str, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25.h,
        ),
        Container(
          height: 88.h,
          width: 349.w,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 26.w,
              ),
              Container(
                width: 47.w,
                child: Image.asset('./assets/${str}.png'),
              ),
              SizedBox(
                width: 36.w,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  str == "certificate" ? "Progress" : str,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class genderBox extends StatelessWidget {
  HomeController homeController;
  genderBox(this.homeController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 305.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Gender",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    homeController.gender.value = 0;
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: homeController.gender == 0
                            ? Colors.green.shade200
                            : null,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          bottomLeft: Radius.circular(15.r),
                        ),
                        border: Border(
                          right: BorderSide(),
                        ),
                      ),
                      child: Text(
                        "Male",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    homeController.gender.value = 1;
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        color: homeController.gender == 1
                            ? Colors.green.shade200
                            : null,
                        border: Border.symmetric(
                          vertical: BorderSide(),
                        ),
                      ),
                      child: Text(
                        "Female",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    homeController.gender.value = 2;
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        color: homeController.gender == 2
                            ? Colors.green.shade200
                            : null,
                        border: Border(
                          left: BorderSide(),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r),
                        ),
                      ),
                      child: Text(
                        "other",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StudentForm extends StatelessWidget {
  HomeController homeController;
  GlobalKey<ScaffoldState> _scaffoldKey;
  StudentForm(this.homeController, this._scaffoldKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: 30.h,
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              homeController.isadmission.value = false;
            },
            icon: Icon(Icons.cancel),
          ),
        ),
        InkWell(
          onTap: homeController.pickimage,
          child: Obx(
            () => Container(
              height: 120.h,
              width: 120.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(60.w),
                image: DecorationImage(
                  image: homeController.isimage.value
                      ? FileImage(homeController.image as File)
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
          height: 750.h,
          padding: EdgeInsets.symmetric(
            horizontal: 35.w,
          ),
          // width: double.infinity,
          child: ListView.builder(
            itemCount: homeController.studenttitle.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              print(homeController.studenttitle[index]);
              return inputBox(homeController.studenttitle[index],
                  homeController.formfiled[index], false);
            },
          ),
        ),
        genderBox(homeController),
        SizedBox(
          height: 10.h,
        ),
        inputBox(
          "Date of Birth",
          homeController.formfiled[10],
          false,
        ),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: () {
            homeController.uploadstudent(_scaffoldKey);
          },
          child: Container(
            height: 56.h,
            width: 200.w,
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 1.w),
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
    );
  }
}

class TeacherForm extends StatelessWidget {
  HomeController homeController;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TeacherForm(this.homeController, this._scaffoldKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30.h,
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.cancel),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: homeController.pickimage,
          child: Obx(
            () => Container(
              height: 120.h,
              width: 120.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(60.w),
                image: DecorationImage(
                  image: homeController.isimage.value
                      ? FileImage(homeController.image as File)
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
          height: 680.h,
          padding: EdgeInsets.symmetric(
            horizontal: 35.w,
          ),
          // width: double.infinity,
          child: ListView.builder(
            itemCount: homeController.teachertitle.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return inputBox(homeController.teachertitle[index],
                  homeController.formfiled[index], false);
            },
          ),
        ),
        genderBox(homeController),
        SizedBox(
          height: 10.h,
        ),
        inputBox(
          "Date of Birth",
          TextEditingController(),
          false,
        ),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 56.h,
            width: 200.w,
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 1.w),
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
    );
  }
}
