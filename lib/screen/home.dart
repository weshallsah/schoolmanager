import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/controller/Admission.controller.dart';
import 'package:schoolmanager/controller/Recurit.controller.dart';
import 'package:schoolmanager/controller/auth.controller.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/screen/Admission.dart';
import 'package:schoolmanager/screen/Recrute.dart';
import 'package:schoolmanager/screen/manage.dart';
import 'package:schoolmanager/screen/marks.dart';
import 'package:schoolmanager/utils/constant.dart';

class Homescreen extends StatelessWidget {
  // HomeController homeController;
  Homescreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager"),
        backgroundColor: Color.fromARGB(255, 236, 190, 190),
        toolbarHeight: 80.h,
        actions: [
          IconButton(
            onPressed: homeController.logout,
            icon: Icon(Icons.logout),
          ),
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
                GetBuilder<HomeController>(
                    init: HomeController(),
                    initState: (state) {
                      homeController.onInit();
                    },
                    builder: (controller) {
                      return Obx(
                        () => controller.isadmin.value
                            ? principal(homeController)
                            : Teacher(homeController),
                      );
                    })
              ],
            ),
          ),
          GetBuilder<HomeController>(builder: (controller) {
            return Obx(
              () => controller.isadmission.value
                  ? InkWell(
                      onTap: () {
                        controller.isadmission.value = false;
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.3),
                        alignment: Alignment.center,
                        child: Container(
                          height: 300.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Admin Panel",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => StudentForm());
                                },
                                child: Container(
                                  height: 60.h,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 25.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 26.w,
                                      ),
                                      Container(
                                        width: 47.w,
                                        child:
                                            Image.asset('./assets/student.png'),
                                      ),
                                      SizedBox(
                                        width: 36.w,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Admission",
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => TeacherForm());
                                },
                                child: Container(
                                  height: 60.h,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 25.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 26.w,
                                      ),
                                      Container(
                                        width: 47.w,
                                        child:
                                            Image.asset('./assets/teacher.png'),
                                      ),
                                      SizedBox(
                                        width: 36.w,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "New Recruit",
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => Manage());
                                },
                                child: Container(
                                  height: 60.h,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 25.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 26.w,
                                      ),
                                      Container(
                                        width: 47.w,
                                        child: Image.asset(
                                            './assets/management.png'),
                                      ),
                                      SizedBox(
                                        width: 36.w,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "manage",
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            );
          }),
        ],
      ),
      floatingActionButton: GetBuilder<HomeController>(builder: (controller) {
        return Obx(
            () => controller.isadmin.value && !controller.isadmission.value
                ? FloatingActionButton(
                    shape: CircleBorder(),
                    onPressed: () {
                      controller.isadmission.value = true;
                    },
                    child: Icon(Icons.add),
                  )
                : Container());
      }),
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
            return Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                InkWell(
                    onTap: () {
                      controller.clicked(index);
                    },
                    child: ActionButton(controller.name[index])),
              ],
            );
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
        SizedBox(
          height: 25.h,
        ),
        InkWell(
          onTap: () {
            homeController.clicked(0);
          },
          child: ActionButton("attendance"),
        ),
        SizedBox(
          height: 25.h,
        ),
        InkWell(
          onTap: () {
            Get.to(
              () => Markscreen(),
            );
          },
          child: ActionButton("marks"),
        ),
        SizedBox(
          height: 25.h,
        ),
        InkWell(
          onTap: () {
            homeController.clicked(2);
          },
          child: ActionButton("certificate"),
        )
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
            Obx(
              () => Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.h),
                  color: Colors.amber,
                  border: Border.all(),
                  image: DecorationImage(
                    image: NetworkImage(
                      "http://${localhost}/api/v1/teacher/viewphoto/${homeController.photo}",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
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
  String text;
  Admissioncontroller admissioncontroller;
  Recruitcontroller recruitcontroller;
  AuthController authController;
  List list;
  bool isgender;
  genderBox(this.text, this.admissioncontroller, this.recruitcontroller,
      this.authController, this.list, this.isgender,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 305.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (isgender) {
                      admissioncontroller.gender.value = index;
                      recruitcontroller.gender.value = index;
                      authController.gender.value = index;
                      return;
                    }
                    recruitcontroller.isnewadmin.value = index;
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: index == list.length - 1
                              ? BorderSide(color: Colors.transparent)
                              : BorderSide(),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        list[index],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isgender
                              ? admissioncontroller.gender.value == index
                                  ? Colors.redAccent
                                  : null
                              : recruitcontroller.isnewadmin.value == index
                                  ? Colors.red
                                  : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
