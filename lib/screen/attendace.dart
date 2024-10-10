import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:schoolmanager/controller/attendance.controller.dart';
import 'package:schoolmanager/main.dart';
import 'package:table_calendar/table_calendar.dart';

class Attendancescreen extends StatelessWidget {
  Attendancescreen({super.key});
  AttendanceController attendanceController = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Manager"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                new HorizontalWeekCalendar(
                  minDate: DateTime.utc(2000, 1, 1),
                  maxDate: DateTime.utc(2050, 12, 31),
                  initialDate: DateTime.now(),
                  onDateChange: (p0) {
                    attendanceController.selecteddate.value =
                        ((p0.year * 100) + p0.month) * 100 + p0.day;
                  },
                ),
                Container(
                  height: 60.h,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  // color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "select ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Obx(
                            () => Container(
                              alignment: Alignment.center,
                              child: DropdownButton(
                                value: attendanceController.selecteditem.value,
                                items: attendanceController.items.map(
                                  (element) {
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
                                ).toList(),
                                onChanged: (it) {
                                  attendanceController.selecteditem.value =
                                      it.toString();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 40.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(
                            25.r,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "upload",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // if (attendanceController.isadmin.value)
                //   Container(
                //     height: 500.h,
                //     width: double.infinity,
                //     // color: Colors.amber,
                //     child: ListView.builder(
                //       itemBuilder: (context, index) {
                //         return Container(
                //           margin: EdgeInsets.symmetric(
                //             horizontal: 15.w,
                //             vertical: 5.h,
                //           ),
                //           // color: Colors.blue,
                //           child: ListTile(
                //             title: Text(
                //               "Vishal sah",
                //               style: TextStyle(
                //                 fontSize: 20.sp,
                //                 fontWeight: FontWeight.w800,
                //               ),
                //             ),
                //             subtitle: Text(
                //               "0208cs211200",
                //               style: TextStyle(
                //                 fontSize: 14.sp,
                //                 fontWeight: FontWeight.w700,
                //               ),
                //             ),
                //             trailing: Container(
                //               height: 50.h,
                //               width: 100.w,
                //               decoration: BoxDecoration(
                //                 color: Colors.greenAccent,
                //                 borderRadius: BorderRadius.circular(
                //                   25.r,
                //                 ),
                //               ),
                //               alignment: Alignment.center,
                //               child: Text(
                //                 "Present",
                //                 style: TextStyle(
                //                   fontSize: 16.sp,
                //                   fontWeight: FontWeight.w700,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                InkWell(
                  onTap: () {
                    attendanceController.present.value =
                        !attendanceController.present.value;
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 10.h,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    child: Text(
                      "Present student",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Obx(
                  () {
                    if (!attendanceController.present.value) {
                      return Container(
                        height: 500.h,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 5.h,
                              ),
                              // color: Colors.blue,
                              child: ListTile(
                                title: Text(
                                  "Vishal sah",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                subtitle: Text(
                                  "0208cs211200",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                InkWell(
                  onTap: () {
                    attendanceController.Absent.value =
                        !attendanceController.Absent.value;
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 10.h,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    child: Text(
                      "Absent student",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Obx(
                  () {
                    if (attendanceController.Absent.value) {
                      return Container(
                        height: 500.h,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 5.h,
                              ),
                              // color: Colors.blue,
                              child: ListTile(
                                title: Text(
                                  "Vishal sah",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                subtitle: Text(
                                  "0208cs211200",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
