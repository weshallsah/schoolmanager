import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/progress.controller.dart';
import 'package:schoolmanager/screen/marks.dart';

class ProgressCard extends StatelessWidget {
  ProgressCard({super.key});
  ProgressController progresscontroller = Get.put(ProgressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manager",
        ),
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
                            progresscontroller.tream.value = 1;
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
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: progresscontroller.students.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => Container(
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
                                  progresscontroller.isfeedback.value =
                                      index + 1;
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
                                            height: 420.h,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: progresscontroller
                                                  .subject.length,
                                              itemBuilder: (context, idx) {
                                                print(progresscontroller
                                                    .subject[idx]);
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
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            progresscontroller
                                                                .students[index]
                                                                    ['result']
                                                                    ['marks']
                                                                    [idx]
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        // height: 30,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          vertical: 5.h,
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              progresscontroller
                                                                      .formfield[
                                                                  idx],
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                "Feedback",
                                                            labelStyle:
                                                                TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
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
                                            onTap: () {
                                              progresscontroller.getprogress();
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
