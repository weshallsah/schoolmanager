import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/Leaving.controller.dart';
import 'package:schoolmanager/controller/progress.controller.dart';
import 'package:schoolmanager/screen/Leaveing.dart';
import 'package:schoolmanager/screen/marks.dart';
import 'package:schoolmanager/screen/showimage.dart';

class ProgressCard extends StatelessWidget {
  ProgressCard({super.key});
  ProgressController progresscontroller = Get.put(ProgressController());
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(
          "Manager",
        ),
        actions: [
          GetBuilder<ProgressController>(builder: (controller) {
            return Obx(
              () => progresscontroller.isadmin.value
                  ? Container(
                      margin: EdgeInsets.only(right: 20.w),
                      alignment: Alignment.center,
                      child: droplist(controller, false, controller.items),
                    )
                  : Container(),
            );
          }),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Obx(
              () => progresscontroller.isadmin.value
                  ? Container()
                  : Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              progresscontroller.isgenerate.value = true;
                            },
                            child: Obx(
                              () => Text(
                                "Generate",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: progresscontroller.isgenerate.value
                                      ? const Color.fromARGB(255, 44, 153, 255)
                                      : null,
                                  decoration:
                                      progresscontroller.isgenerate.value
                                          ? TextDecoration.underline
                                          : null,
                                  decorationColor:
                                      const Color.fromARGB(255, 44, 153, 255),
                                  decorationThickness: 2.h,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              progresscontroller.isgenerate.value = false;
                            },
                            child: Obx(
                              () => Text(
                                "Download",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: !progresscontroller.isgenerate.value
                                      ? const Color.fromARGB(255, 44, 153, 255)
                                      : null,
                                  decoration:
                                      !progresscontroller.isgenerate.value
                                          ? TextDecoration.underline
                                          : null,
                                  decorationColor:
                                      const Color.fromARGB(255, 44, 153, 255),
                                  decorationThickness: 2.h,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
                            progresscontroller.tream.value = 1;
                            progresscontroller.onInit();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15.r),
                              color: progresscontroller.tream == 1
                                  ? Colors.blueGrey
                                  : null,
                            ),
                            child: Text(
                              "1st",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: progresscontroller.tream == 1
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
                            progresscontroller.tream.value = 2;
                            progresscontroller.onInit();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15.r),
                              color: progresscontroller.tream == 2
                                  ? Colors.blueGrey
                                  : null,
                            ),
                            child: Text(
                              "2nd",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: progresscontroller.tream == 2
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
            GetBuilder<ProgressController>(builder: (controller) {
              return Obx(
                () => progresscontroller.isadmin.value
                    ? Expanded(
                        child: DownloadCard(progresscontroller, _globalKey))
                    : Expanded(
                        child: Obx(
                          () => progresscontroller.isgenerate.value
                              ? Generate(progresscontroller, _globalKey)
                              : DownloadCard(progresscontroller, _globalKey),
                        ),
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class DownloadCard extends StatelessWidget {
  ProgressController progresscontroller;
  GlobalKey<ScaffoldState> _globalKey;
  DownloadCard(this.progresscontroller, this._globalKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressController>(builder: (controller) {
      return Obx(
        () => ListView.builder(
          itemCount: progresscontroller.students.length,
          itemBuilder: (context, index) {
            print(progresscontroller.students[index]);
            return Obx(
              () => progresscontroller.students[index]['result']['progress']
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(),
                        ),
                      ),
                      // color: Colors.amber,
                      child: ListTile(
                        title: Text(
                          progresscontroller.students[index]['name'],
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          progresscontroller.students[index]['enroll'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            progresscontroller.Download(index);
                            Get.to(() => Certificate(
                                0, progresscontroller, LeavingController()));
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
                              "Download",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            );
          },
        ),
      );
    });
  }
}

class Generate extends StatelessWidget {
  ProgressController progresscontroller;
  GlobalKey<ScaffoldState> _globalKey;
  Generate(this.progresscontroller, this._globalKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressController>(builder: (context) {
      return Obx(
        () => ListView.builder(
          itemCount: progresscontroller.students.length,
          itemBuilder: (context, index) {
            return Obx(
              () => progresscontroller.students[index]['result']['progress'] ||
                      progresscontroller.students[index]['result']['tream'] !=
                          progresscontroller.tream.value
                  ? Container()
                  : Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      height: progresscontroller.isfeedback.value == index + 1
                          ? 600.h
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
                              progresscontroller.students[index]['name'],
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            subtitle: Text(
                              progresscontroller.students[index]['enroll'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                if (progresscontroller.isfeedback.value ==
                                    index + 1) {
                                  progresscontroller.isfeedback.value = 0;
                                  return;
                                }
                                progresscontroller.isfeedback.value = index + 1;
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
                                  "Feedback",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => progresscontroller.isfeedback.value ==
                                    index + 1
                                ? Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 25.w,
                                            vertical: 5.h,
                                          ),
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
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: progresscontroller
                                                .subject.length,
                                            itemBuilder: (context, idx) {
                                              print(progresscontroller
                                                  .selectedfeeditem[index]);
                                              progresscontroller
                                                      .selectedfeeditem[index] =
                                                  "Good";
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 25.w,
                                                  vertical: 5.h,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          progresscontroller
                                                              .subject[idx],
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          progresscontroller
                                                              .students[index]
                                                                  ['result']
                                                                  ['marks'][idx]
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      // height: 30,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        vertical: 5.h,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Remark",
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          GetBuilder<
                                                                  ProgressController>(
                                                              builder:
                                                                  (controller) {
                                                            return Obx(
                                                              () =>
                                                                  DropdownButton(
                                                                value: controller
                                                                        .selectedfeeditem[
                                                                    idx],
                                                                items: progresscontroller
                                                                    .feeditem
                                                                    .map<
                                                                        DropdownMenuItem>(
                                                                  (element) {
                                                                    // print(element);
                                                                    return DropdownMenuItem(
                                                                      child:
                                                                          Text(
                                                                        element,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16.sp,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      value:
                                                                          element,
                                                                    );
                                                                  },
                                                                ).toList(),
                                                                onChanged:
                                                                    (it) {
                                                                  progresscontroller
                                                                              .selectedfeeditem[
                                                                          idx] =
                                                                      it.toString();
                                                                  // controller.onInit();
                                                                },
                                                              ),
                                                            );
                                                          }),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await progresscontroller.generate(
                                                index, _globalKey);
                                            progresscontroller.students[index]
                                                ['result']['progress'] = true;
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
                                              "Generate Progress",
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
    });
  }
}

class droplist extends StatelessWidget {
  final controller;
  bool isadmission;
  List listitems;
  int type;
  droplist(this.controller, this.isadmission, this.listitems,
      {this.type = 0, super.key});

  @override
  Widget build(BuildContext context) {
    // print(controller.items);
    print(controller.selectedDivision.value);
    return Obx(
      () => DropdownButton(
        value: type == 0
            ? controller.selecteditem.value
            : type == 1
                ? controller.selectednationality.value
                : type == 2
                    ? controller.selectedreligion.value
                    : type == 3
                        ? controller.selectedDivision.value
                        : controller.selectedcaste.value,
        items: listitems.map<DropdownMenuItem>(
          (element) {
            // print(element);
            return DropdownMenuItem(
              child: Text(
                element,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: element,
            );
          },
        ).toList() as List<DropdownMenuItem>,
        onChanged: (it) {
          if (type == 0) {
            controller.selecteditem.value = it.toString();
          } else if (type == 1) {
            controller.selectednationality.value = it.toString();
          } else if (type == 2) {
            controller.selectedreligion.value = it.toString();
          } else if (type == 3) {
            controller.selectedDivision.value = it.toString();
          } else {
            controller.selectedcaste.value = it.toString();
          }
          // controller.onInit();
          if (!isadmission) {
            controller.onInit();
          }
        },
      ),
    );
  }
}
