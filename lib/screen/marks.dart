import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/controller/marks.controller.dart';

class Markscreen extends StatelessWidget {
  Markscreen({super.key});
  Markcontroller markcontroller = Get.put(Markcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Obx(
          () => ListView.builder(
            itemCount: markcontroller.students.length,
            itemBuilder: (context, index) {
              return Obx(
                () => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  height:
                      markcontroller.isupload.value == index + 1 ? 600.h : null,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          markcontroller.students[index]['name'],
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          markcontroller.students[index]['enroll'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            if (markcontroller.isupload.value == index + 1) {
                              markcontroller.isupload.value = 0;
                              return;
                            }
                            markcontroller.isupload.value = index + 1;
                          },
                          child: Container(
                            height: 55.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              // color: Colors.redAccent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(
                                15.r,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Upload Marks",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => markcontroller.isupload.value == index + 1
                            ? Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 25.w,
                                        vertical: 5.h,
                                      ),
                                      // width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Subjects",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Marks",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 420.h,
                                      // color: Colors.amber,
                                      child: ListView.builder(
                                        itemCount:
                                            markcontroller.subjects.length,
                                        itemBuilder: (context, index) {
                                          return Subjects(
                                            markcontroller.subjects[index],
                                            markcontroller
                                                .formcontroller[index],
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 56.h,
                                        width: 200.w,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 1.w),
                                          borderRadius:
                                              BorderRadius.circular(9.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "update",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Subjects(markcontroller),
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Subjects extends StatelessWidget {
  // Markcontroller markcontroller;
  String text;
  TextEditingController controller;
  Subjects(this.text, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 25.w,
        vertical: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: 100.w,
            height: 50.h,
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              // color: Colors.amber,
              border: Border.all(),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
