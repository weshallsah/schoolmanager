import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/service/auth.service.dart';

class Homescreen extends StatelessWidget {
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
          GetBuilder<HomeController>(
            builder: (controller) => IconButton(
              onPressed: controller.logout,
              icon: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Container(
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
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
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
