import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showtoast(
    GlobalKey<ScaffoldState> _scaffoldKey, String text, bool iserror) {
  ScaffoldMessenger.of(_scaffoldKey.currentContext as BuildContext)
      .showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      // width: 250,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.black87,
      content: Text(
        text,
        style: TextStyle(
          color: iserror ? Colors.redAccent : Colors.white,
          fontSize: 16.sp,
        ),
      ),
    ),
  );
}
