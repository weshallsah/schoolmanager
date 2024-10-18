import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:schoolmanager/controller/attendance.controller.dart';
import 'package:schoolmanager/main.dart';
import 'package:table_calendar/table_calendar.dart';

class Attendancescreen extends StatelessWidget {
  Attendancescreen({super.key});
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  AttendanceController attendanceController = Get.put(AttendanceController());
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                new HorizontalWeekCalendar(
                  minDate: DateTime.utc(2000, 1, 1),
                  maxDate: DateTime.utc(2050, 12, 31),
                  initialDate: DateTime.now(),
                  onDateChange: (p0) async {
                    attendanceController.selecteddate.value =
                        ((p0.year * 100) + p0.month) * 100 + p0.day;
                    await attendanceController.getpresent();
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
                          Obx(() {
                            if (attendanceController.isadmin.value &&
                                attendanceController.selecteddate.value ==
                                    attendanceController.today.value) {
                              return Container(
                                alignment: Alignment.center,
                                child: DropdownButton(
                                  value:
                                      attendanceController.selecteditem.value,
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
                              );
                            }
                            return Obx(
                              () => Container(
                                alignment: Alignment.center,
                                child: Text(
                                  attendanceController.std.value,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                      Obx(() {
                        if (!attendanceController.isadmin.value &&
                            !attendanceController.istaken.value &&
                            attendanceController.selecteddate.value ==
                                attendanceController.today.value) {
                          return InkWell(
                            onTap: () {
                              attendanceController.upload(_scaffoldKey);
                            },
                            child: Container(
                              height: 40.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                border: Border.all(),
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
                          );
                        }
                        return Container();
                      }),
                    ],
                  ),
                ),
                Obx(() {
                  if (!attendanceController.isadmin.value &&
                      !attendanceController.istaken.value &&
                      attendanceController.selecteddate.value ==
                          attendanceController.today.value &&
                      attendanceController.cnt !=
                          attendanceController.student.length) {
                    return Container(
                      height: 500.h,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: attendanceController.student.length,
                        itemBuilder: (context, index) {
                          attendanceController.presentlist.value.add("");
                          return Obx(
                            () {
                              return attendanceController.presentlist[index] !=
                                      ""
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 15.w,
                                        vertical: 5.h,
                                      ),
                                      // color: Colors.blue,
                                      child: ListTile(
                                        title: Text(
                                          attendanceController.student[index]
                                              ['name'],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        subtitle: Text(
                                          attendanceController.student[index]
                                              ['enroll'],
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            attendanceController
                                                    .presentlist[index] =
                                                attendanceController
                                                    .student[index]['_id'];
                                            attendanceController.cnt.value++;
                                          },
                                          child: Container(
                                            height: 50.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              color: Colors.greenAccent,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                25.r,
                                              ),
                                              border: Border.all(),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Present",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                }),
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
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Present student",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${attendanceController.presentcnt.value}/${attendanceController.student.length}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Obx(
                  () {
                    if (attendanceController.present.value) {
                      return Container(
                        height: 500.h,
                        width: double.infinity,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: attendanceController.student.length,
                            itemBuilder: (context, index) {
                              attendanceController.presentlist.value.add("");
                              attendanceController.presentcnt.value++;
                              return Obx(
                                () => attendanceController.presentlist[index] ==
                                        ""
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 15.w,
                                          vertical: 5.h,
                                        ),
                                        // color: Colors.blue,
                                        child: ListTile(
                                          title: Text(
                                            attendanceController.student[index]
                                                ['name'],
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          subtitle: Text(
                                            attendanceController.student[index]
                                                ['enroll'],
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          trailing: Container(
                                            height: 50.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              // color: Colors.greenAccent.shade100,
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                25.r,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Present",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.greenAccent,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),
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
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Absent student",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${attendanceController.student.length - attendanceController.presentcnt.value}/${attendanceController.student.length}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                          itemCount: attendanceController.student.length,
                          itemBuilder: (context, index) {
                            attendanceController.presentlist.value.add("");
                            return Obx(
                              () => attendanceController.presentlist[index] !=
                                      ""
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 15.w,
                                        vertical: 5.h,
                                      ),
                                      // color: Colors.blue,
                                      child: ListTile(
                                        title: Text(
                                          attendanceController.student[index]
                                              ['name'],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        subtitle: Text(
                                          attendanceController.student[index]
                                              ['enroll'],
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        trailing: Container(
                                          height: 50.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            // color: Colors.redAccent,
                                            border: Border.all(),
                                            borderRadius: BorderRadius.circular(
                                              25.r,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Absent",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
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
