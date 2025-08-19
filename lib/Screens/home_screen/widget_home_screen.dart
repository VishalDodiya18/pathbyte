import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';

class HomeScreenWidget {
  Widget tabbarWidget() {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) {
        return heightBox(14);
      },
      itemBuilder: (context, index) {
        final isOdd = index.isOdd;
        return InkWell(
          onTap: () {
            //Get.to(() => AssignScreen());
          },
          child: Row(
            spacing: 14.w,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 66.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: const Color(0xFFE7E8EB), // border color
                        width: 1.w, // border thickness
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextConstant(title: 'Alberto Ripley (#12345)', fontWeight: FontWeight.bold),
                            TextConstant(title: '#CASE12345'),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextConstant(title: '+91 78522 10001'),
                            Spacer(),
                            TextConstant(title: '5 Tests'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 66.h,
                width: 83.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: isOdd ? Colors.orange : Colors.green, borderRadius: BorderRadius.circular(10.r)),
                child: const TextConstant(title: '1700', color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
