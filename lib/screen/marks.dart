import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/marks.controller.dart';

class Markscreen extends StatelessWidget {
  Markscreen({super.key});
  Markcontroller markcontroller = Get.put(Markcontroller());
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Manager"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 5.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Term",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            markcontroller.tream.value = 1;
                            markcontroller.onInit();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15.r),
                              color: markcontroller.tream == 1
                                  ? Colors.blueGrey
                                  : null,
                            ),
                            child: Text(
                              "1st",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: markcontroller.tream == 1
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            markcontroller.tream.value = 2;
                            markcontroller.onInit();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15.r),
                              color: markcontroller.tream == 2
                                  ? Colors.blueGrey
                                  : null,
                            ),
                            child: Text(
                              "2nd",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: markcontroller.tream == 2
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 5.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Type",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            markcontroller.Regular.value = true;
                            markcontroller.onInit();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15.r),
                              color: markcontroller.Regular.value
                                  ? Colors.blueGrey
                                  : null,
                            ),
                            child: Text(
                              "Regular",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: markcontroller.Regular.value
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            markcontroller.Regular.value = false;
                            markcontroller.onInit();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15.r),
                              color: !markcontroller.Regular.value
                                  ? Colors.blueGrey
                                  : null,
                            ),
                            child: Text(
                              "Ex",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: !markcontroller.Regular.value
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Obx(() => !markcontroller.Regular.value
                ? ExStudent(markcontroller, _scaffoldKey)
                : Regularstudent(markcontroller, _scaffoldKey)),
          ],
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
            alignment: Alignment.center,
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

class ExStudent extends StatelessWidget {
  Markcontroller markcontroller;
  GlobalKey<ScaffoldState> _scaffoldKey;
  ExStudent(this.markcontroller, this._scaffoldKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<Markcontroller>(builder: (controller) {
        return Obx(
          () => ListView.builder(
            itemCount: markcontroller.students.length,
            itemBuilder: (context, index) {
              print(markcontroller.fail[markcontroller.students[index]['_id']]);
              return Obx(
                () => !markcontroller
                        .fail[markcontroller.students[index]['_id']]
                    ? Container()
                    : Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        height: markcontroller.isupload.value == index + 1
                            ? 680.h
                            : null,
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
                                  if (markcontroller.isupload.value ==
                                      index + 1) {
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                            // height: 420.h,
                                            // color: Colors.amber,
                                            child: ListView.builder(
                                              itemCount: markcontroller
                                                  .subjects.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Subjects(
                                                  markcontroller
                                                      .subjects[index],
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
                                            onTap: () {
                                              markcontroller.upload(
                                                  index, _scaffoldKey);
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
        );
      }),
    );
  }
}

class Regularstudent extends StatelessWidget {
  Markcontroller markcontroller;
  GlobalKey<ScaffoldState> _scaffoldKey;
  Regularstudent(this.markcontroller, this._scaffoldKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<Markcontroller>(builder: (controller) {
        return Obx(
          () => ListView.builder(
            itemCount: markcontroller.students.length,
            itemBuilder: (context, index) {
              return Obx(
                () => (markcontroller.uploaded
                            .value[markcontroller.students[index]['_id']]) ||
                        markcontroller.students[index]['trem'] !=
                            markcontroller.tream.value
                    ? Container()
                    : Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        height: markcontroller.isupload.value == index + 1
                            ? 680.h
                            : null,
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
                                  if (markcontroller.isupload.value ==
                                      index + 1) {
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                            // color: Colors.amber,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: markcontroller
                                                  .subjects.length,
                                              itemBuilder: (context, index) {
                                                return Subjects(
                                                  markcontroller
                                                      .subjects[index],
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
                                            onTap: () {
                                              markcontroller.upload(
                                                  index, _scaffoldKey);
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
        );
      }),
    );
  }
}
